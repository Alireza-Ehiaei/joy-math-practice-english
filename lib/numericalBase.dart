import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
//import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';
import 'customKeyboard.dart';
import 'main.dart';
class NumericalBasesPage extends StatefulWidget {
  const NumericalBasesPage({super.key});

  @override
  _NumericalBasesPageState createState() => _NumericalBasesPageState();
}

class _NumericalBasesPageState extends State<NumericalBasesPage> {
  static const String _productId = 'nonConsumable1';
  bool _isPurchased = false;
  bool _isLoading = false;
  late bool _isRestoring = false; // Add this line
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  final InAppPurchase _iap = InAppPurchase.instance;

  @override
  void initState() {
    super.initState();
    _initPurchaseInfo();
    _purchaseSubscription = _iap.purchaseStream.listen(_handlePurchaseUpdate);
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initPurchaseInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPurchased = prefs.getBool(_productId) ?? false;
    });
  }

  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID == _productId) {
        final isValid = await _verifyPurchase(purchase);

        if (isValid && (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored)) {

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(_productId, true);

          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }

          setState(() => _isPurchased = true);
        }
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchase) async {
    return purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored;
  }

  Future<void> _buyProduct() async {
    setState(() => _isLoading = true);

    try {
      final response = await _iap.queryProductDetails({_productId});
      if (response.productDetails.isEmpty) {
        throw Exception('Product not found in store');
      }

      final productDetails = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: productDetails);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _restorePurchases() async {
    if (_isRestoring) return;

    setState(() => _isRestoring = true);

    try {
      await _iap.restorePurchases();
      // Restoration results come through _handlePurchaseUpdate stream
    } on SocketException catch (_) {
      setState(() => _isRestoring = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Network error. Please check your connection.')),
        );
      }
    } catch (e) {
      setState(() => _isRestoring = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: ${e.toString()}')),
        );
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNoProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Not Available'),
        content: const Text('Product not available at this time.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> showPracticeSubscriptionUI(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      final response = await InAppPurchase.instance.queryProductDetails({_productId});

      if (response.error != null) {
        _showErrorDialog(context, response.error!.message);
        return;
      }

      if (response.productDetails.isEmpty) {
        _showNoProductDialog(context);
        return;
      }

      final product = response.productDetails.firstWhere(
            (product) => product.id == _productId,
        orElse: () => throw Exception('$_productId not found'),
      );

      List<Widget> subscriptionTiles = [
        const SizedBox(height: 20),
        // Practice subscription button
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: _isLoading ? null : () async {
              try {
                await _buyProduct();
                if (mounted) Navigator.of(context).pop();
              } catch (e) {
                if (mounted) _showErrorDialog(context, e.toString());
              }
            },
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
              'Lifetime Access\n\$${product.price} (One-time)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Unlock unlimited practice forever!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        // Learn More button
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: null,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Practice Features'),
                  content: const Text(
                    'With lifetime access to Practice, you get:\n\n'
                        '• Unlimited practice sessions\n'
                        '• All difficulty levels unlocked\n'
                        '• One-time payment, forever product access\n\n'
                        'Perfect for mastering math skills at your own pace!',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'Learn More',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Restore Purchases button
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: null,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
              elevation: 0,
            ),
            onPressed: _isRestoring ? null : () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );
              try {
                await _restorePurchases();
                if (mounted) Navigator.of(context, rootNavigator: true).pop();
              } catch (e) {
                if (mounted) {
                  Navigator.of(context, rootNavigator: true).pop();
                  _showErrorDialog(context, e.toString());
                }
              }
            },
            child: _isRestoring
                ? const CircularProgressIndicator()
                : const Text(
              'Restore Purchases',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Privacy Policy and Terms of Use links
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _launchUrl(context, 'https://www.termsfeed.com/live/1338938e-748c-4423-9431-196fdbebc78e'),
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _launchUrl(context, 'https://www.apple.com/legal/internet-services/itunes/us/terms.html'),
              child: const Text(
                'Terms of Use',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ];

      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Unlock Practice Features',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: subscriptionTiles,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        _showErrorDialog(context, 'Failed to load products: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600; // Tablet breakpoint


// Define base sizes for phone
    const baseTitleFontSize = 22.0;
    const baseButtonFontSize = 24.0;
    const baseButtonMinWidth = 220.0;
    const baseButtonMinHeight1 = 95.0;
    const baseButtonMinHeight2 = 85.0;
    const baseButtonMinHeight3 = 75.0;
    const baseIconSize = 38.0;
    const baseSpacingLarge = 90.0;
    const baseSpacingMedium = 70.0;
    const baseSpacingSmall = 20.0;
    const baseSpacingExtraSmall = 30.0;

// Scale factor (increase sizes on tablets)
    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

// Scaled sizes
    final titleFontSize1 = baseTitleFontSize * scaleFactor;
    final buttonFontSize = baseButtonFontSize * scaleFactor;
    final buttonMinWidth = baseButtonMinWidth * scaleFactor;
    final buttonMinHeight1 = baseButtonMinHeight1 * scaleFactor;
    final buttonMinHeight2 = baseButtonMinHeight2 * scaleFactor;
    final buttonMinHeight3 = baseButtonMinHeight3 * scaleFactor;
    final iconSize = baseIconSize * scaleFactor;
    final spacingLarge = baseSpacingLarge * scaleFactor;
    final spacingMedium = baseSpacingMedium * scaleFactor;
    final spacingSmall = baseSpacingSmall * scaleFactor;
    final spacingExtraSmall = baseSpacingExtraSmall * scaleFactor;

    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/back4.JPEG'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.4), // Adjust opacity here (0.0 to 1.0)
                BlendMode.darken, // Use BlendMode to control how the color is applied
              ),
              //  fit: BoxFit.cover,
            )
        ),


        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: spacingLarge),
          
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(120, 66, 4, 4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Math: Precise Ideas, Better Living',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize1,
                  ),
                ),
              ),
          
              SizedBox(height: spacingLarge),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 106, 2, 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(buttonMinWidth, buttonMinHeight1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NumeralBaseExplainPage()),
                  );
                },
                child: Text(
                  'Numeric systems?',
                  style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
                ),
              ),
          
              SizedBox(height: spacingSmall),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 106, 2, 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(buttonMinWidth, buttonMinHeight2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NumeralBaseExamplePage()),
                  );
                },
                child: Text(
                  '   Examples   ',
                  style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
                ),
              ),
          
              SizedBox(height: spacingSmall),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 106, 2, 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(buttonMinWidth, buttonMinHeight3),
                ),
                onPressed: _isLoading
                    ? null
                    : () {
                  if (_isPurchased) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NumeralBasePracticePage()),
                    );
                  } else {
                    showPracticeSubscriptionUI(context); // Call the new function
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  '  Practice  ',
                  style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
                ),
              ),
          
              SizedBox(height: spacingSmall),
          
              SizedBox(height: spacingMedium),
          
              const Spacer(),
          
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_return),
                  color: Colors.white,
                  iconSize: iconSize,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                ),
              ),
          
              SizedBox(height: spacingExtraSmall),
            ],
          ),
        ),

      ),
    );
  }
}


/////////////////////////////////////////:://////////////////////////// Numeral_base explain page
class AdvancedTile {
  final String title;
  final Widget body;
  AdvancedTile({required this.title, required this.body  });
}

class NumeralBaseExplainPage extends StatefulWidget {
  const NumeralBaseExplainPage({super.key});

  @override
  State<NumeralBaseExplainPage> createState() => _NumeralBaseExplainPage();
}

class _NumeralBaseExplainPage extends State<NumeralBaseExplainPage> with TickerProviderStateMixin {
  int selected = -1;
  bool get isTablet => MediaQuery.of(context).size.width >= 600;

  List<AdvancedTile> buildItems(bool isTablet) {
    late double titleFontSize= isTablet ? 30 : 20;
    return  [

      AdvancedTile(
        title: 'Decimal number system\n',
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 233, 163, 3),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'The Decimal Number System\n\n ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 29, 4),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  '📌 Each digit in a number (e.g., 7, 5, and 3 in 753) derives its value from its position and the base (or radix) of the numbering system.'
                      '\n\n[Base/Radix: The number that determines both available digits (0 to base-1) and how each position\'s value scales]'
                      '\n\nThe base determines how much each digit contributes to the total value considering its position.'
                      ' For example, in base ten, it\'s the digit multiplied by 10 raised to the power of the digits to its right. For example, the third digit from the right has a place value of 10^2 (100). In 1485, the 4 is in the third position, representing 400.'
                      '\n\n📌 The decimal number system, or base-10 system, is the number system we use daily for counting, ranking, and measuring. It employs ten digits: 0, 1, 2, 3, 4, 5, 6, 7, 8, and 9.\n\n'
                      "📌 Base-10's simplicity is a key advantage: e.g., 1000 = 10^3, and 80 = 8 × 10.  Its origin is possibly linked to our ten fingers, but historical records indicate that it took millennia for the full digit set and zero to develop.\n\n"
                      "💡 Key Points:\n\n"
                      "  🔑 Power of a Number: Multiplying a number by itself a certain number of times (e.g., 3^2 = 3 × 3 = 9).\n\n"
                      "  🔑 Any Number Raised to the Power of 0 Equals 1: This means that any number multiplied by 1 will remain unchanged.\n\n"
                      "  🔑 Expanded Form: Expressing a number as the sum of its digits multiplied by their place values (e.g., 24 = 2 × 10^1 + 4 × 10^0).\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '🤔 Why Powers in Expanded Form (Base 10)?\n ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 29, 4),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "📌 In base 10, we only use digits 0-9.  These digits are actually the coefficients of powers of 10.\n\n"
                      "❌ We can't write 147 as 14 × 10^1 + 7 × 10^0 because coefficients must be single digits (0-9). 14 is not a single digit!\n\n"
                      "✅ Instead: We need a higher power of 10 to represent a larger part of 147.  This ensures all coefficients of 10 are from 0 to 9:\n\n"
                      "   147 = 1 × 10^2 + 4 × 10^1 + 7 × 10^0 = 1 × 10^2 + 4 × 10^1 + 7\n\n"
                      "✨ In everyday life, we use powers of 10 (place value) to easily express numbers. The 5 in 536 represents 500, but in 5206 it represents 5000! Position matters!\n\n"
                      "💡 Explanation:\n\n"
                      "  📍 Place Value: A digit's 'address' in a number (e.g., in 123, 1 is 100, 2 is 20, 3 is 3).\n\n"
                      "  📍 Powers of 10: Help assign the correct value based on position (e.g., in 123, 1 is multiplied by 10^2, 2 by 10^1, 3 by 10^0).\n\n"
                      "  📍 Why Powers? We can represent *any* number using only digits 0-9 as coefficients and powers of 10! This compact form is crucial.\n\n"
                      "🎓 The Bottom Line: Powers of 10 and digits 0-9 are the foundation of our number system, allowing us to represent any number and perform mathematical operations effectively. 🧮\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '🔢 Expanded Form for Decimal Numbers (Base 10)?\n ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 29, 4),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "📌 Decimal numbers (like 14.67) have digits *after* the decimal point, representing fractions of 1.\n\n"
                      "📍 Digits to the *left* of the decimal are whole numbers (powers of 10 like we saw before).\n\n"
                      "📍 Digits to the *right* of the decimal are tenths, hundredths, thousandths, etc. (negative powers of 10).\n\n"
                      "Let's expand 14.67:\n\n"
                      "✅  14.67 = (1 × 10^1) + (4 × 10^0) + (6 × 10^-1) + (7 × 10^-2)\n\n"
                      "✨What does this mean?\n\n"
                      " 1️⃣  (1 × 10^1) = 10 (One ten)\n\n"
                      " 2️⃣  (4 × 10^0) = 4 (Four ones)\n\n"
                      " 3️⃣  (6 × 10^-1) = 0.6 (Six tenths)\n\n"
                      " 4️⃣  (7 × 10^-2) = 0.07 (Seven hundredths)\n\n"
                      "➕ Adding it all together: 10 + 4 + 0.6 + 0.07 = 14.67. It works! ➕\n\n"
                      "💡 Key Points:\n\n"
                      "   🔑 Negative Powers: 10^-1 = 1/10 = 0.1; 10^-2 = 1/100 = 0.01, and so on.\n\n"
                      "   🔑 Place Value (Again!): In a positional numeral system, the position "
                      "of each digit relative to the decimal determines its value. Sometimes, in this systems \n\n"
                      "   🔑 Expanded Form: Breaks down the number into the sum of each digit multiplied by its place value (a power of 10).\n\n"
                      "   🔑 Expanded Form: Breaks down the number into the sum of each digit multiplied by its place value (a power of 10).\n\n"
                      " 🧠 Tip: Think of the decimal point as the 'ones' place (10^0). Moving left increases the power of 10, and moving right *decreases* the power (becomes negative). 🧠\n\n"
                      " 🎯 In summary: Decimal numbers use both positive and negative powers of 10 to represent whole numbers and fractions, all with the same base-10 system! 💯\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


      AdvancedTile(
        title: 'Number systems with a base less than 10\n',
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 233, 163, 3),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '🔢 Number Systems with Base < 10\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 29, 4),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "📌 In a base-n number system, there are only n digits (0 to n-1). E.g., base 10 has 0-9, base 8 has 0-7. 📌\n\n"
                      "✨ Base-8 numbers use powers of 8 with coefficients from 0 to 7. Example: 17 (base 10) = 21 (base 8) ✨\n\n"
                      " 1️⃣  17 (base 10) = 1 × 10^1 + 7 × 10^0\n"
                      " 2️⃣  21 (base 8) = 2 × 8^1 + 1 × 8^0\n\n"
                      "🤔 But how do we know 17 (base 10) = 21 (base 8)?\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' Method 1: Repeated Division\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 150, 1, 76),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "❌ Dividing 17 by 8 gives 2.125, BUT 2.125 isn't an integer from 0-7. We only want the *integer quotient*! ❌\n\n"
                      "✅ Steps to convert a base-10 number to another base using division: ✅\n\n"
                      "   1️⃣ Divide the number by the new base.\n"
                      "   2️⃣ If the quotient is divisible by the base, divide *again*! Repeat until the quotient is less than the new base.\n"
                      "   3️⃣ Write down the remainders from *last to first*. This is the number in the new base!\n\n"
                      "Let's convert 17 (base 10) to base 8:\n\n"
                      "   ⬆️ Quotient 2 is not divisible by 8.  Remainders (last to first): 2, then 1. Thus, 17 (base 10) = 21 (base 8).\n\n"
                      "Another Example: Convert 155 (base 10) to base 6:\n\n"
                      "   ➗ Divide 155 by 6: Quotient = 25, Remainder = 5.\n"
                      "   ➗ Divide 25 by 6: Quotient = 4, Remainder = 1.\n"
                      "   🛑 4 is not divisible by 6, so we stop.\n"
                      "   📝 Remainders (last to first): 4, 1, 5.  Thus, 155 (base 10) = 415 (base 6).\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' Method 2: Predicting Coefficients (Base Conversion)\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 150, 1, 76),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "✨ For mental math lovers! This method is quicker for smaller numbers with some practice. ✨\n\n"
                      "🎯 The Goal: Express numbers in a new base by predicting the coefficients of its powers. 🎯\n\n"
                      "🪜 Steps: 🪜\n\n"
                      " 1️⃣ Find the *largest* power of the new base that's *smaller* than your original number. Find the *largest* coefficient for this power where their product ≤ the original number. This coefficient is the leftmost digit in the new base!\n\n"
                      " 2️⃣ Subtract the product (coefficient × power) from the original number. The remainder is what's left to convert!\n\n"
                      " 3️⃣ Repeat steps 1 & 2 with the remainder until the remainder is zero.\n\n"
                      " 4️⃣ Write down the coefficients from left to right. 🎉 This is your number in the new base! 🎉\n\n"
                      "Let's convert 17 (base 10) to base 8:\n\n"
                      " 💡 8^1 (8) is the largest power of 8 less than 17.\n"
                      " 💡 2 is the largest coefficient for 8^1 that's ≤ 17 (2 × 8 = 16).\n"
                      " ➖ The remainder is 17 - 16 = 1.\n"
                      " ✅ 1 is less than 8, so the final digits are 2 and 1. 17 (base 10) = 21 (base 8).\n\n"
                      "Let's convert 155 (base 10) to base 6:\n\n"
                      " 🔎 6^2 (36) is the largest power of 6 less than 155.\n"
                      " 🔎 4 is the largest coefficient for 6^2 that's ≤ 155 (4 × 36 = 144).\n"
                      " ➖ The remainder is 155 - 144 = 11.\n"
                      " 🔎 6^1 (6) is the largest power of 6 less than 11.\n"
                      " 🔎 1 is the largest coefficient for 6^1 that's ≤ 11 (1 × 6 = 6).\n"
                      " ➖ The remainder is 11 - 6 = 5.\n"
                      " ✅ So, 155 (base 10) = 415 (base 6).\n\n"
                      "⚠️ There's no strict formula! Trial and error is your friend. Practice makes perfect! ⚠️\n\n"
                      "💡 Key Points:\n\n"
                      " 📍 We break down the number into a sum of powers of the new base.\n"
                      " 📍 Coefficients must be less than the new base.\n"
                      " 📍 Repeated subtraction (finding the largest possible coefficients) is key.\n"
                      " 🤸 It's another way to understand base conversion - building the number step-by-step. 🤸\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


      AdvancedTile(
        title: 'Number systems with a base greater than 10\n',
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 233, 163, 3),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '🔢 Number Systems with Base > 10\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 29, 4),
                    fontSize: titleFontSize,
                  ),
                ),
                TextSpan(
                  text:
                  "📌 Bases larger than 10 need more than ten digits! Base 12, for example, needs twelve unique digits. 📌\n\n"
                      "❌ Let's convert 155 (base 10) to base 12:  Is 12(1 0 11) correct? NO! We can't tell if '11' means eleven or one-one! ❌\n\n"
                      "✅ We need *unique symbols* for *all* digits. In base 12, we can use 0-9, 'a' for 10, and 'b' for 11. ✅\n\n"
                      " 1️⃣ So, 155 (base 10) = 12(10b).\n"
                      " 2️⃣  And 1453 (base 10) = 12(a11).  Now we can tell the difference!\n\n"
                      "✨ Base 50 would need 50 unique symbols – hard to memorize! ✨\n\n"
                      "🤯 Smaller bases can be tricky too! Memorizing powers of 7 (like 7^2, 7^3, 7^4) isn't as easy as powers of 10! 🤯\n\n"
                      "🎉 Working with different bases is FUN! It boosts mental math skills and can help you make cool codes or passwords! 🎉\n\n"
                      "💡 Key Points:\n\n"
                      " 📍 Base > 10 means more symbols are needed.\n"
                      " 📍 Powers of the base help represent numbers in different bases.\n"
                      " 📍 Repeated division converts between bases.\n"
                      " 📍 Understanding different systems is math skill unlocked 🔓!\n\n",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    ];}

  double? _fontSize = 25;
  void _changeFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600; // Tablet breakpoint
    final items = buildItems(isTablet);

// Define base sizes for phone
    const baseTitleFontSize = 22.0;
    const baseButtonFontSize = 24.0;
    const baseButtonMinWidth = 220.0;
    const baseButtonMinHeight1 = 95.0;
    const baseButtonMinHeight2 = 85.0;
    const baseButtonMinHeight3 = 75.0;
    const baseIconSize = 38.0;
    const baseSpacingLarge = 90.0;
    const baseSpacingMedium = 70.0;
    const baseSpacingSmall = 20.0;
    const baseSpacingExtraSmall = 30.0;

// Scale factor (increase sizes on tablets)
    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

// Scaled sizes

    final iconSizeScaledNumberSysMenu = baseIconSize * scaleFactor;


    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/back2.JPG'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              //  fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.4), // Adjust opacity here (0.0 to 1.0)
                BlendMode.darken, // Use BlendMode to control how the color is applied
              ),
            )
        ),

        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child : Column(
                        children : <Widget>[
                          ListView.builder(
                            key: Key('builder ${selected.toString()}'), //attention
                            padding: EdgeInsets.only(left: 10.0, right: 10.0, top:  selected==-1 ? 120 :20),
                            shrinkWrap: true, //the builder is called only for those children that are actually visible.
                            //   physics: NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.0),
                                child: Card( color:Colors.purple[900],
                                  shadowColor: Colors.blueGrey,
                                  elevation: 0.0,
                                  shape:  const RoundedRectangleBorder(
                                    //     side: BorderSide(color: Colors.purple, width:2),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.zero,
                                        topLeft:   Radius.zero,
                                        bottomRight: Radius.zero,
                                        topRight:Radius.circular(25),
                                      )
                                  ),
                                  child: ExpansionTile(
                                    key: Key(index.toString()),
                                    initiallyExpanded: index == selected,
                                    onExpansionChanged: (newState) {
                                      setState(() {
                                        if (newState) {
                                          selected = index;
                                          _changeFontSize(isTablet ? 25 : 10);  // larger font size on tablets when expanded
                                        } else {
                                          selected = -1;
                                          _changeFontSize(isTablet ? 40 : 35);  // reset font size on collapse
                                        }
                                      });
                                    },
                                    title: Center(
                                      child: SizedBox(
                                        child: Text(
                                          items[index].title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: selected == -1
                                                ? (isTablet ? 45 : 25)  // larger font size for closed tile on tablet
                                                : (isTablet ? 38 : 18), // larger font size for opened tile on tablet
                                          ),
                                        ),
                                      ),
                                    ),
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: isTablet ? 1.2 : 0.8,  // reduce height on tablets
                                        child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, item) {
                                            return items[index].body;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                  children: [
                    const SizedBox(width: 10,),
                    IconButton(
                      icon:  const Icon(Icons.keyboard_return),
                      color:Colors.white,
                      iconSize: iconSizeScaledNumberSysMenu,
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const NumericalBasesPage()),
                        );
                      },
                    ),
          
                    IconButton(
                      icon:  const Icon(Icons.home),
                      color:Colors.white,
                      iconSize: iconSizeScaledNumberSysMenu,
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Homepage()),
                        );
                      },
                    ),
          
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.source),
                      color: Colors.white,
                      iconSize: iconSizeScaledNumberSysMenu,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('References'),
                              content: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 18.0, color: Colors.black),
                                    children: [
                                      const TextSpan(
                                        text: '\nMethod 2 (Base Prediction) of converting numbers between bases'
                                            ' was custom-developed by the developer of this application. '
                                            'The core concepts may intersect with existing base-conversion '
                                            'methodologies, such as those discussed in:\n\n',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.deepPurple,
          
                                        ),),
                                      // 1. Khan Academy - Number Bases
                                      TextSpan(
                                        text: '\nKhan Academy - Number Bases\n\n',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final url = Uri.parse('https://www.khanacademy.org/math/algebra-home/alg-intro-to-algebra/algebra-alternate-number-bases/v/number-systems-introduction');
                                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Failed to open link')),
                                              );
                                            }
                                          },
                                      ),
          
                                      // 2. Purplemath - Base Conversion
                                      TextSpan(
                                        text: '\nPurplemath - Base Conversion\n\n',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final url = Uri.parse('https://www.purplemath.com/modules/numbbase.htm');
                                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Failed to open link')),
                                              );
                                            }
                                          },
                                      ),
          
                                      // 3. TutorialsPoint - Number System Conversion
                                      TextSpan(
                                        text: '\nTutorialsPoint - Base Conversion\n\n',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final url = Uri.parse('https://www.tutorialspoint.com/computer_logical_organization/number_system_conversion.htm');
                                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Failed to open link')),
                                              );
                                            }
                                          },
                                      ),
          
                                      // 4. RapidTables - Base Converter
                                      TextSpan(
                                        text: '\nRapidTables - Interactive Converter\n\n',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final url = Uri.parse('https://www.rapidtables.com/convert/number/base-converter.html');
                                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Failed to open link')),
                                              );
                                            }
                                          },
                                      ),
          
                                      // 5. GeeksforGeeks - Number System
                                      TextSpan(
                                        text: '\nGeeksforGeeks - Number Systems\n\n',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final url = Uri.parse('https://www.geeksforgeeks.org/number-system-in-maths/');
                                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Failed to open link')),
                                              );
                                            }
                                          },
                                      ),
          
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
          
                            );
                          },
                        );
                      },
                    ),
          
                    const SizedBox(width: 10,)
                  ]
              ),
              const SizedBox(height: 5,)
            ],
          
          ),
        ),
      ),
    );
  }
}


/////////////////////////////////////////:://////////////////////////// Numeralbase_example page

class NumeralBaseExamplePage extends StatelessWidget {
  const NumeralBaseExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600; // Tablet breakpoint

// Define base sizes for phone
    const baseTitleFontSize = 22.0;
    const baseButtonFontSize = 24.0;
    const baseButtonMinWidth = 220.0;
    const baseButtonMinHeight1 = 95.0;
    const baseButtonMinHeight2 = 85.0;
    const baseButtonMinHeight3 = 75.0;
    const baseIconSize = 38.0;
    const baseSpacingLarge = 90.0;
    const baseSpacingMedium = 70.0;
    const baseSpacingSmall = 20.0;
    const baseSpacingExtraSmall = 30.0;

// Scale factor (increase sizes on tablets)
    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

// Scaled sizes
    final titleFontSize = baseTitleFontSize * scaleFactor;
    final buttonFontSize = baseButtonFontSize * scaleFactor;
    final buttonMinWidth = baseButtonMinWidth * scaleFactor;
    final buttonMinHeight1 = baseButtonMinHeight1 * scaleFactor;
    final buttonMinHeight2 = baseButtonMinHeight2 * scaleFactor;
    final buttonMinHeight3 = baseButtonMinHeight3 * scaleFactor;
    final iconSize = baseIconSize * scaleFactor;
    final spacingLarge = baseSpacingLarge * scaleFactor;
    final spacingMedium = baseSpacingMedium * scaleFactor;
    final spacingSmall = baseSpacingSmall * scaleFactor;
    final spacingExtraSmall = baseSpacingExtraSmall * scaleFactor;
// Set container width: fixed for phones, wider for tablets
    final containerWidth = isTablet ? 600.0 : 360.0;

// Set font size: larger for tablets
    final fontSize = isTablet ? 30.0 : 16.0;

    return Scaffold(

      body: Container(color: const Color.fromARGB(255, 230, 86, 3),
        child: SafeArea(
          child: Column (mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: containerWidth,
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(120, 66, 4, 4), // Uncomment if needed
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Mathematics is about exploring patterns and making connections. '
                        'Does one have to be a genius to do mathematics? The answer is an emphatic NO - Terence Tao',
                    style: TextStyle(
                      color: Colors.black87,
                      // fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
          
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 194, 213, 213),
                      //     border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SingleChildScrollView(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '✨ Examples of Numbers in Bases Other Than 10\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 110, 29, 4),
                                  fontSize: titleFontSize,
                                ),
                              ),
                              TextSpan(
                                text: "📌 Reminder:\n\n"
                                    "   🔑 A number raised to the power of n: Multiplying that number by itself n times (e.g., 100 = 10×10 = 10^2).\n"
                                    "   🔑 Any number raised to the power of zero equals one (e.g. 1 = 1^0 or 1 = 5^0).\n"
                                    "   🔑 Numbers we use daily are in base 10: expressed as a sum of multiples of powers of 10, (e.g., 369 = 3×10^2 + 6×10^1 + 9×10^0).\n"
                                    "   🔑 Expressing a number in a base other than 10: representing it as a sum of multiples of powers of the new base.\n\n"
                                    "❌ For example, to express 369 in base 5:❌\n"
                                    "   369 = 5×8^2 + 6×8^1 + 1×8^0\n\n"
                                    "📌 In these explanations, we use the notation (a)<sub>b</sub> as shorthand.  This means 'the number 'a' expressed in base 'b'.📌\n\n"
                                    "✅ For Example:\n\n"
                                    "    ✨(100)₅ is a shorter way of writing '100 in base 5'.✨\n\n"
                                    "More examples:\n\n"
                                    "✅ Converting 32 (base 10) to base 5: We can use the division method:✅\n"
                                    "   🔑 32 ÷ 5 = 6 remainder 2\n"
                                    "   🔑  6 ÷ 5 = 1 remainder 1\n"
                                    "   🔑 So, 32 in base 10 is (112)₅.\n\n"
                                    "Method 1: Repeated Division\n\n"
                                    "   🔑 We divide the number by the new base repeatedly until the quotient is less than the base. The remainders, read from bottom to top, give us the number in the new base.\n\n"
                                    "✨ Another Method: Coefficient Prediction ✨\n\n"
                                    "   🔑 Instead of repeated division, we can use a mental approach to find the equivalent number in a new base. With practice, you'll find this method quicker and more intuitive for smaller numbers.\n\n"
                                    "   🔑 Here's how it works:\n\n"
                                    "      1️⃣  Find the largest power of the new base that is smaller than the original number. For example, to convert 32 (base 10) to base 5, the largest power of 5 smaller than 32 is 5^2 (which is 25).\n"
                                    "      2️⃣  Find the largest coefficient for this power such that their product is less than or equal to the original number. In our example, the largest coefficient for 5^2 that is less than 32 is 1 (since 1 * 25 = 25).\n"
                                    "      3️⃣ Subtract the product from the original number to find the remainder. In our example, 32 - 25 = 7. This remainder is the part of the original number that we still need to convert.\n"
                                    "      4️⃣ Repeat steps 2 and 3 for the remainder, using the next smaller power of the base. Continue this process until the remainder is 0.\n"
                                    "      5️⃣  Write down the coefficients in the order you found them, from left to right. These coefficients represent the number in the new base.\n\n"
                                    "   🔑 Example: Converting 32 (base 10) to base 5:\n\n"
                                    "      🔎 We found that 25 (which is 5^2) is the largest power of 5 smaller than 32, and the coefficient is 1.\n"
                                    "      🔎 The remainder is 7.\n"
                                    "      🔎 The largest power of 5 smaller than 7 is 5^1 (which is 5). The coefficient is 1.\n"
                                    "      🔎 The remainder is 7 - 5 = 2.\n"
                                    "      🔎 The largest power of 5 smaller than 2 is 5^0 (which is 1). The coefficient is 2.\n"
                                    "      ✅ So, 32 in base 10 is (112)₅.\n\n",
                                style: TextStyle(
                                  fontSize: isTablet ? 30 : 25,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '✨ Finding (78)₁₀ in Base 3\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 110, 29, 4),
                                  fontSize: titleFontSize,
                                ),
                              ),
                              TextSpan(
                                text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"
                                    "✅ Method 1: Repeated Division\n\n"
                                    "   🔑 78 ÷ 3 = 26 remainder 0\n"
                                    "   🔑 26 ÷ 3 = 8 remainder 2\n"
                                    "   🔑 8 ÷ 3 = 2 remainder 2\n"
                                    "   🔑 2 ÷ 3 = 0 remainder 2\n"
                                    "   🔑 Reading remainders from bottom to top: (2220)₃\n\n"
                                    "✨ Method 2: Predicting Coefficients ✨\n\n"
                                    "   1️⃣ Largest power of 3 less than 78: 3³ = 27\n"
                                    "   2️⃣ Largest multiple of 27 less than 78: 2 * 27 = 54 (So the first digit is 2)\n"
                                    "   3️⃣ Remainder: 78 - 54 = 24\n"
                                    "   4️⃣ Largest power of 3 less than 24: 3² = 9\n"
                                    "   5️⃣ Largest multiple of 9 less than 24: 2 * 9 = 18 (So the next digit is 2)\n"
                                    "   6️⃣ Remainder: 24 - 18 = 6\n"
                                    "   7️⃣ Largest power of 3 less than 6: 3¹ = 3\n"
                                    "   8️⃣ Largest multiple of 3 less than 6: 2 * 3 = 6 (So the next digit is 2)\n"
                                    "   9️⃣ Remainder: 6 - 6 = 0\n"
                                    "   🔟 Largest power of 3 less than 0: 3⁰ = 1 (we technically don't need this step, since the remainder is 0, so we fill last digit with 0)\n"
                                    "   ✅ Combining the digits: (2220)₃\n\n"
                                    "So (78)₁₀ = (2220)₃ ✅\n\n",
                                style: TextStyle(
                                  fontSize: isTablet ? 30 : 25,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '✨ Finding (78)₁₀ in Base 7 ✨\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 110, 29, 4),
                                  fontSize: titleFontSize,
                                ),
                              ),
                              TextSpan(
                                text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"
                                    "✅ Method 1: Repeated Division [1]\n\n"
                                    "   🔑 78 ÷ 7 = 11 remainder 1\n"
                                    "   🔑 11 ÷ 7 = 1 remainder 4\n"
                                    "   🔑 1 ÷ 7 = 0 remainder 1\n"
                                    "   🔑 Reading remainders from bottom to top: (141)₇\n\n"
                                    "✨ Method 2: Predicting Coefficients ✨\n\n"
                                    "   1️⃣ Largest power of 7 less than 78: 7² = 49\n"
                                    "   2️⃣ Largest multiple of 49 less than 78: 1 * 49 = 49 (So the first digit is 1)\n"
                                    "   3️⃣ Remainder: 78 - 49 = 29\n"
                                    "   4️⃣ Largest power of 7 less than 29: 7¹ = 7\n"
                                    "   5️⃣ Largest multiple of 7 less than 29: 4 * 7 = 28 (So the next digit is 4)\n"
                                    "   6️⃣ Remainder: 29 - 28 = 1\n"
                                    "   7️⃣ Largest power of 7 less than 1: 7⁰ = 1\n"
                                    "   8️⃣ Largest multiple of 1 less than 1: 1 * 1 = 1 (So the next digit is 1)\n"
                                    "   9️⃣ Remainder: 1 - 1 = 0\n"
                                    "   ✅ Combining the digits: (141)₇\n\n"
                                    "So (78)₁₀ = (141)₇ ✅\n\n",
                                style: TextStyle(
                                  fontSize: isTablet ? 30 : 25,
                                  color: Colors.black,
                                ),
                              ),
                              // ...continue with the rest of your TextSpans, using isTablet for fontSize...
                            ],
                          ),
                        )
          
                    ),
                  ),
                ),
          
                Row(
          
                    children: [
                      IconButton(
                        icon:  const Icon(Icons.keyboard_return),
                        color:Colors.lightBlue[100],
                        iconSize: iconSize,
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const NumericalBasesPage()),
                          );
                        },
                      ),
          
                      IconButton(
                        icon:  const Icon(Icons.home),
                        color:Colors.lightBlue[100],
                        iconSize: iconSize,
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Homepage()),
                          );
                        },
                      )
                    ]
                )
              ]
          ),
        ),
      ),
    );
  }
}



/////////////////////////////////////////:://////////////////////////// Numeralbase_practice page
class NumeralBasePracticePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NumeralBasePracticePage> {
  final  ValueNotifier<List<String>> notificationlist = ValueNotifier(<String>[]); // <type> variable= initialisation
  final  ValueNotifier<String> notificationtext = ValueNotifier("");
  final  ValueNotifier<int> notificationcolor = ValueNotifier(2); // // for changing answer textfield color
  bool _visible = false;
  bool calculator_visible = false;
  final FocusNode _focus_main_number = FocusNode();
  final FocusNode _focus_from_base = FocusNode();
  final FocusNode _focus_to_base = FocusNode();
  final FocusNode _focus_answer = FocusNode();
  final FocusNode _focus_calc = FocusNode();
  final FocusNode _focus_minimum = FocusNode();
  final FocusNode _focus_maximum = FocusNode();


  final TextEditingController _controller_main_number = TextEditingController();
  final TextEditingController _controller_from_base = TextEditingController();
  final TextEditingController _controller_to_base = TextEditingController();
  final TextEditingController _controller_answer = TextEditingController();
  final TextEditingController _controller_minimum = TextEditingController();
  final TextEditingController _controller_maximum = TextEditingController();
  TextEditingController _controller_calc = TextEditingController();
  final TextEditingController _controller_first_number = TextEditingController();
  final TextEditingController _controller_second_number = TextEditingController();

  String main_number_text ="";
  String from_base_text ="";
  String to_base_text ="";
  String user_answer_text ="";
  String _answer_text ="";
  String _answer_text1 ="";
  List<String> dig =[];
  List<String> n_base_expand = [];
  List<String> plus_power = [];
  bool timer_enabled= false;
  int id = 2; // It's for showing results in the screen based on check or answer button passing
  String min_ = "4";
  String max_ = "1";
  final bool _readOnly = true;
  bool _calculateor_textfield_focus = false;
  Parser p=Parser();
  final List<bool> timer_box = <bool>[false];
  late bool timer_visible = false;

  final List<bool> random_interval_box = <bool>[false];
  late bool random_interval_visible = false;

  get digit1 => null;

  changeClassValue_input(String answerText) {
    // nexText is the input (textController.text below) and goes to
    // text label that is defined in container
    setState(() {
      // changeClass = !changeClass;
      _answer_text = answerText;
    });
  }

  calculator_textfield_focus_(calculatorFocused) {
    setState(() {
      // if calculator_focused is focused _calculateor_textfield_focus will be true and
      // gets text of buttons
      _calculateor_textfield_focus = calculatorFocused;  });
  }

  calculator_textfield_controller_(ControllerAddress,) {
    setState(() {  // _controller_calculator goes to Controller_address and goes to _controller_calc
      _controller_calc = ControllerAddress;    }, );
  }

  timer_CallBack(bool? toggleTimer, ) {
    if (toggleTimer != null) {
      setState(() {
        timer_enabled = toggleTimer;
      });
    }
  }

  @override
  void initState() {
    _focus_main_number.addListener(_onFocusChange);
    _focus_from_base.addListener(_onFocusChange);
    _focus_to_base.addListener(_onFocusChange);
    _focus_answer.addListener(_onFocusChange);
    _focus_minimum.addListener(_onFocusChange);
    _focus_maximum.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focus_main_number.removeListener(_onFocusChange);
    _focus_from_base.removeListener(_onFocusChange);
    _focus_to_base.removeListener(_onFocusChange);
    _focus_answer.removeListener(_onFocusChange);
    _focus_minimum.removeListener(_onFocusChange);
    _focus_maximum.removeListener(_onFocusChange);

    _controller_main_number.dispose();
    _controller_from_base.dispose();
    _controller_to_base.dispose();
    _controller_answer.dispose();
    _controller_minimum.dispose();
    _controller_maximum.dispose();
    _controller_first_number.dispose();
    _controller_second_number.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    debugPrint("_focus_main_number.hasFocus ${_focus_main_number.hasFocus}");
    debugPrint("_focus_from_base.hasFocus ${_focus_from_base.hasFocus}");
    debugPrint("_focus_to_base.hasFocus ${_focus_to_base.hasFocus}");
    debugPrint("_focus_answer.hasFocus ${_focus_answer.hasFocus}");
    debugPrint("_focus_minimum.hasFocus ${_focus_minimum.hasFocus}");
    debugPrint("_focus_maximum.hasFocus ${_focus_maximum.hasFocus}");
  }

  // Generating random numbers
  randomNumber(int min, int max) {
    var random = Random();
    int result = min + random.nextInt(max - min);
    return result;
  }

  final _insertText = insertText();
  final _backspace = backspace(); // calling class backspace from customkeyboard.dart
  final _operators = ['+','-','×','÷'];
// for changing answer textfield color
  List<bool> random_interval = <bool>[false];

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600; // Tablet breakpoint

// Define base sizes for phone
    const baseTitleFontSize = 22.0;
    const baseButtonFontSize = 24.0;
    const baseButtonMinWidth = 220.0;
    const baseButtonMinHeight1 = 95.0;
    const baseButtonMinHeight2 = 85.0;
    const baseButtonMinHeight3 = 75.0;
    const baseIconSize = 38.0;
    const baseSpacingLarge = 90.0;
    const baseSpacingMedium = 70.0;
    const baseSpacingSmall = 20.0;
    const baseSpacingExtraSmall = 30.0;

    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

// Base sizes
    const baseIconSizeMain = 30.0;
    const baseIconSizeSmall = 25.0;
    const baseDialogFontSize = 20.0;
    const baseRowHeight = 30.0;
    const baseSizedBoxWidth = 5.0;
    const baseSizedBoxWide = 110.0;

// Scaled sizes
    final iconSizeMain = baseIconSizeMain * scaleFactor;
    final iconSizeSmall = baseIconSizeSmall * scaleFactor;
    final dialogFontSize = baseDialogFontSize * scaleFactor;
    final rowHeight = baseRowHeight * scaleFactor;
    final sizedBoxWidth = baseSizedBoxWidth * scaleFactor;
    final sizedBoxWide = baseSizedBoxWide * scaleFactor;


    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider( //                                     <--- MultiProvider
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ChangeNotifierProvider<TimerBox>( // ChangeNotifierProxyProvider helps if
          // CatalogModel were to update, then CartModel will be able to update accordingly.
          create: (context) =>TimerBox(timerChanged: timer_CallBack),
        ),      ],
      child:
        SafeArea(
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 32, 0, 14 ),
              body: Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,0,),
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                       
                    
                        SizedBox(height: rowHeight,
                          child: Row(
                            children: [
                              IconButton(
                                icon:  const Icon(Icons.keyboard_return),
                                color:Colors.purple,
                                iconSize: iconSizeMain,
                                onPressed: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const NumericalBasesPage()),
                                  );
                                },
                              ),
                    
                              IconButton(
                                icon:  const Icon(Icons.home),
                                color:Colors.purple,
                                iconSize: iconSizeMain,
                                onPressed: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const Homepage()),
                                  );
                                },
                              ),
                    
                              const SizedBox(width: 5,),
                              IconButton(
                                icon:  const Icon(Icons.question_mark_outlined),
                                color:Colors.green,
                                iconSize: iconSizeSmall,
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:  Text("Instructions",
                                          style: TextStyle(fontSize: dialogFontSize),),
                                        content: SingleChildScrollView( // Make content scrollable
                                          child: RichText(
                                            text:  TextSpan(
                                              style: TextStyle(fontSize: dialogFontSize, color: Colors.black), // Default style
                                              children: const <TextSpan>[
                                                TextSpan(
                                                  text: "🧩 For a new exercise, press the \"New practice\" button and answer based "
                                                      "on the generated random numbers.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: "✅ To check if your answer is correct, press the \"Check\" button. "
                                                      "To see the correct answer, press the \"Answer\" button.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                    
                    
                                                TextSpan(
                                                  text: "⏱️ Tap the clock icon in the top right corner to activate the timer. "
                                                      "The timer automatically resets each time you start a new practice, "
                                                      "displaying the time passed. Use the controls to manually stop, resume, "
                                                      "or reset the timer as needed.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: "🔢 A random number between 1 and 100 will be generated for each new practice. "
                                                      "If you want more challenging exercises, adjust the minimum and maximum values "
                                                      "by clicking on the icon next to ⏱️.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: "🛠️ You can change the given random numbers manually and answer questions based on your custom inputs. "
                                                      "When you want to convert a number from one numerical base to another, "
                                                      "none of the bases can be greater than 10.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                    
                                                TextSpan(
                                                  text: "⚙️ You can close the timer and random number range windows without losing "
                                                      "your settings to make the screen more readable. However, if you close the app, "
                                                      "your settings will be reset.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: "🎓 When you're first learning, it's not necessary to use a timer. "
                                                      "Once you're comfortable with the concepts, you can use "
                                                      "the timer to improve your speed.\n\n",
                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(fontSize: dialogFontSize)),
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                    
                                },
                              ),
                    
                              const Spacer(),
                              Padding(
                                padding:  EdgeInsets.fromLTRB(0, 5 * scaleFactor, 0, 0),
                                child: ToggleButtons(
                                  isSelected: timer_box,
                                  onPressed: (int index) {
                                    setState(() {
                                      timer_box[index] = !timer_box[index];
                                      timer_visible = !timer_visible;
                                    });
                                  },
                                  borderRadius: BorderRadius.all(Radius.circular((8 * scaleFactor))),
                                  //  selectedBorderColor: Colors.blue[700],
                                  selectedColor: Colors.yellow[400],
                                  //  fillColor: Colors.blue[200],
                                  color: Colors.green,
                                  children: <Widget>[
                                    Icon(Icons.lock_clock, size: iconSizeSmall,),
                                  ],
                                ),
                              ),
                    
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5* scaleFactor, 0, 0),
                                child: ToggleButtons( // for showing timer box
                                  isSelected: random_interval_box,
                                  onPressed: (int index) {
                                    setState(() {
                                      random_interval_box[index] = !random_interval_box[index]; // changes the state of the button
                                      random_interval_visible = !random_interval_visible;    // gets action based on the state
                                    });
                                  },
                                  borderRadius: BorderRadius.all(Radius.circular(8* scaleFactor)),
                                  //  selectedBorderColor: Colors.blue[700],
                                  selectedColor: Colors.yellow[400],
                                  //  fillColor: Colors.blue[200],
                                  color: Colors.green,
                                  children: <Widget>[
                                    Icon(Icons.social_distance, size: iconSizeSmall,),
                    
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                              ),
                    
                            ],
                          ),
                        ),
                    
                        SizedBox(
                          height: isTablet ? 12.0 : 10, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),
                    
                    
                        Consumer<MyModel>( //            <--- MyModel Consumer
                            builder: (context, myModel, child) {
                              return Visibility(visible: timer_visible,
                    
                                child : SizedBox(height: 30 * scaleFactor,
                                    child: TimerBox(timerChanged: timer_CallBack)),
                              );}
                        ),
                    
                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),
                    
                    
                        Visibility(
                          visible: random_interval_visible,
                          child: SizedBox(
                            height: 33 * scaleFactor,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 50, 87, 86),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: ToggleButtons(
                                    isSelected: random_interval,
                                    onPressed: (int index) {
                                      setState(() {
                                        random_interval[0] = !random_interval[0];
                                      });
                                    },
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    selectedColor: Colors.red,
                                    fillColor: Colors.lightBlueAccent,
                                    color: Colors.red,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            6 * scaleFactor, 2 * scaleFactor, 6 * scaleFactor, 2 * scaleFactor),
                                        child: Text(
                                          'Random number',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                            fontSize: 18 * scaleFactor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5 * scaleFactor),
                                Flexible(
                                  child: SizedBox(
                                    height: 33 * scaleFactor,
                                    child: TextField(
                                      focusNode: _focus_minimum,
                                      readOnly: true,
                                      showCursor: true,
                                      cursorColor: Colors.black,
                                      onTap: () {
                                        if (!_visible) {
                                          show_keboard();
                                        }
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: 22.0 * scaleFactor,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      controller: _controller_minimum,
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'min',
                                        hintStyle: TextStyle(fontSize: 16 * scaleFactor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10 * scaleFactor,
                                          horizontal: 10 * scaleFactor,
                                        ),
                                        fillColor: const Color.fromARGB(255, 246, 182, 58),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8 * scaleFactor),
                                Flexible(
                                  child: SizedBox(
                                    height: 33 * scaleFactor,
                                    child: TextField(
                                      focusNode: _focus_maximum,
                                      readOnly: true,
                                      showCursor: true,
                                      cursorColor: Colors.black,
                                      onTap: () {
                                        if (!_visible) {
                                          show_keboard();
                                        }
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: 22.0 * scaleFactor,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      controller: _controller_maximum,
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'max',
                                        hintStyle: TextStyle(fontSize: 16 * scaleFactor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10 * scaleFactor,
                                          horizontal: 10 * scaleFactor,
                                        ),
                                        fillColor: const Color.fromARGB(255, 246, 182, 58),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                    
                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),
                    
                        SizedBox  (height: isTablet ? 60 : 40,
                          child:  Consumer<MyModel>( //            <--- MyModel Consumer
                            builder: (context, myModel, child) {
                              return  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 50, 87, 86),
                                  minimumSize: Size(isTablet ? screenWidth * .7 : 399,
                                      isTablet ? 70 : 45), // adaptive size
                                ),
                                onPressed: () {
                                  if (myModel.timerSelected[0]) {
                                    myModel.resetTimer();
                                    myModel.startTimer();
                                    myModel.timerTextStartBtn = 'stop';
                                    myModel.timerRunning = true;
                                    setState(() {
                                      notificationlist.value = [];
                                      notificationtext.value = "";
                                      notificationcolor.value = 3;
                                      myModel.timerStartIsPressed[0] = true;
                                    });
                                  } else {
                                    setState(() {
                                      notificationlist.value = [];
                                      notificationtext.value = "";
                                      notificationcolor.value = 3;
                                    });
                                  }
                    
                                  _controller_answer.text = "";
                    
                                  if (random_interval[0]) {
                                    if (_controller_minimum.text.isEmpty || _controller_maximum.text.isEmpty) {
                                      main_number_text = randomNumber(1, 100).toString();
                                    } else {
                                      main_number_text = randomNumber(
                                        int.parse(_controller_minimum.text),
                                        int.parse(_controller_maximum.text),
                                      ).toString();
                                    }
                    
                                    _controller_main_number.text = main_number_text;
                                    from_base_text = "10";
                                    _controller_from_base.text = "10";
                                    to_base_text = randomNumber(2, 9).toString();
                                    _controller_to_base.text = to_base_text;
                                  } else {
                                    main_number_text = randomNumber(1, 100).toString();
                                    _controller_main_number.text = main_number_text;
                                    from_base_text = "10";
                                    _controller_from_base.text = "10";
                                    to_base_text = randomNumber(2, 9).toString();
                                    _controller_to_base.text = to_base_text;
                                  }
                                },
                                child: Text(
                                  "New practice",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 33 : 18, // adaptive font size
                                  ),
                                ),
                              );
                    
                            },
                          ),
                        ),
                    
                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),
                    
                        SizedBox(height: isTablet ? 60 : 40,
                          child: Row(
                            children: [
                              Text(
                                'Convert number',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 33 : 18,
                                ),
                              ),
                              SizedBox(width: isTablet ? 16 : 10),
                              Flexible(
                                child: TextField(
                                  focusNode: _focus_main_number,
                                  readOnly: true,
                                  showCursor: true,
                                  cursorHeight: isTablet ? 32 : 22,
                                  cursorColor: Colors.black,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: isTablet ? 34 : 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(6, 1, 8, 11),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_main_number,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),

                        SizedBox(
                          height: isTablet ? 60 : 40,
                          child: Row(
                            children: [
                              Text(
                                'from base',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 33 : 18,
                                ),
                              ),
                              SizedBox(width: isTablet ? 20 : 14),
                              Flexible(
                                child: TextField(
                                  focusNode: _focus_from_base,
                                  readOnly: true,
                                  showCursor: true,
                                  cursorHeight: isTablet ? 32 : 12,
                                  cursorColor: Colors.black,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: isTablet ? 34 : 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(6, 1, 8, 11),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_from_base,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: isTablet ? 16 : 10),
                              Text(
                                'to base',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 33 : 18,
                                ),
                              ),
                              SizedBox(width: isTablet ? 16 : 10),
                              Flexible(
                                child: TextField(
                                  focusNode: _focus_to_base,
                                  readOnly: true,
                                  showCursor: true,
                                  cursorHeight: isTablet ? 32 : 22,
                                  cursorColor: Colors.black,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: isTablet ? 34 : 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(6, 1, 8, 11),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_to_base,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),

                        SizedBox(
                          height: isTablet ? 60 : 40,
                          child: Row(
                            children: [
                              Text(
                                'Answer?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 33 : 18,
                                ),
                              ),
                              SizedBox(width: isTablet ? 16 : 10),
                              Flexible(
                                child: ValueListenableBuilder<int>(
                                  valueListenable: notificationcolor,
                                  builder: (context, value, widget) {
                                    return TextField(
                                      focusNode: _focus_answer,
                                      readOnly: true,
                                      cursorHeight: isTablet ? 32 : 33,
                                      cursorColor: Colors.black,
                                      showCursor: true,
                                      onTap: () {
                                        if (!_visible) {
                                          show_keboard();
                                        }
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: isTablet ? 34 : 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(6, 1, 8, 11),
                                        filled: true,
                                        border: InputBorder.none,
                                        fillColor: (value == 0)
                                            ? const Color.fromARGB(255, 253, 14, 42)
                                            : (value == 1)
                                            ? const Color.fromARGB(255, 43, 163, 16)
                                            : const Color.fromARGB(255, 221, 217, 218),
                                      ),
                                      controller: _controller_answer,
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                        SizedBox(
                          height: isTablet ? 12.0 : 5.0, // or use 5.0 * scaleFactor if you want proportional scaling
                        ),
                    
                        Consumer<MyModel>( //            <--- MyModel Consumer
                            builder: (context, myModel, child) {
                              return
                                SizedBox(height: 40 * scaleFactor,
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Flexible(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromARGB(255, 50, 87, 86),
                                              minimumSize: Size(isTablet ? 400 : 330, isTablet ? 60 : 45),
                                            ),
                                            onPressed: () => {
                                              id = 0,
                                              myModel.timerSelected[0]
                                                  ? {
                                                _controller_answer.text.isNotEmpty ? myModel.stopTimer() : null,
                                                show_answer(id, timer_enabled),
                                              }
                                                  : show_answer(id, timer_enabled),
                                            },
                                            child: Text(
                                              'Answer',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isTablet ? 33 : 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: isTablet ? 16 : 7),
                                      Flexible(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 50, 87, 86),
                                            minimumSize: Size(isTablet ? 400 : 330, isTablet ? 60 : 45),
                                          ),
                                          onPressed: () => {
                                            id = 1,
                                            myModel.timerSelected[0]
                                                ? {
                                              _controller_answer.text.isNotEmpty ? myModel.stopTimer() : null,
                                              show_answer(id, timer_enabled),
                                            }
                                                : show_answer(id, timer_enabled),
                                          },
                                          child: Text(
                                            'Check',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isTablet ? 33 : 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                            }
                        ),
                    
                        SizedBox(height: isTablet ? 20 : 5.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10, 0, 0),
                          child: SizedBox(
                            child: ValueListenableBuilder<String>(
                              valueListenable: notificationtext,
                              builder: (context, value, widget) {
                                Color textColor;
                                double fontSize;
                    
                                if (value == "The answer is not correct") {
                                  textColor = Colors.red;
                                  fontSize = isTablet ? 44 : 20;
                                } else if (value == "Correct answer:") {
                                  textColor = Colors.blue;
                                  fontSize = isTablet ? 42 : 20;
                                } else if (value == "Very good, your answer is correct!") {
                                  textColor = Colors.green;
                                  fontSize = isTablet ? 44 : 20;
                                } else {
                                  textColor = Colors.white;
                                  fontSize = isTablet ? 44 : 20;
                                }
                    
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize:  isTablet ? 44 : 20,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    
                        // box for the correct answer
                        //      SizedBox(height: calculator_visible ?  135 : 220, child:
                        ValueListenableBuilder<List<String>>(valueListenable: notificationlist,
                            // using List<String> to be able to check each character of answer
                            builder: (context, value, widget) {
                              if(1!=1){
                                return Text("Loading");
                              }else {
                    
                                return
                                  // displaying list items in different box size that will be modified automatically
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 40, 10),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            color: const Color.fromARGB(255, 1, 61, 59),
                                            child: Wrap(
                                              spacing: isTablet ? 14 : 8,
                                              runSpacing: isTablet ? 10 : 5,
                                              children: value.map((e) {
                                                Color textColor;
                                                double fontSize;
                    
                                                if (e.contains("The answer is not correct")) {
                                                  textColor = Colors.red;
                                                  fontSize = isTablet ? 44 : 20;
                                                } else if (e.contains("Correct answer:")) {
                                                  textColor = Colors.blue;
                                                  fontSize = isTablet ? 42 : 20;
                                                } else if (e.contains("Very good, your answer is correct!")) {
                                                  textColor = Colors.green;
                                                  fontSize = isTablet ? 46 : 20;
                                                } else if (e.contains("/")) {
                                                  textColor = Colors.lightBlue;
                                                  fontSize = isTablet ? 44 : 20;
                                                } else {
                                                  textColor = Colors.white;
                                                  fontSize = isTablet ? 44 : 20;
                                                }
                    
                                                return Container(
                                                  margin: EdgeInsets.all(0),
                                                  child: Padding(
                                                    padding: (e.contains("*"))
                                                        ? const EdgeInsets.all(0)
                                                        : EdgeInsets.fromLTRB(0, isTablet ? 14 : 10, 0, 0),
                                                    child: Text(
                                                      e.replaceAll("*", "").replaceAll("/", ""),
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: fontSize,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                              }
                            }
                        ),
                        //    ),
                    
                        Visibility(visible: _visible,
                          child: CustomKeyboard(
                            onTextInput: (myText) {
                              _insertText(_focus_main_number.hasFocus ? _controller_main_number :
                              _focus_from_base.hasFocus ? _controller_from_base :
                              _focus_to_base.hasFocus ? _controller_to_base :
                              _focus_answer.hasFocus ? _controller_answer :
                              _focus_minimum.hasFocus ? _controller_minimum :
                              _focus_maximum.hasFocus ? _controller_maximum :
                              _controller_calc , myText);
                            },
                            onBackspace_: () {_focus_main_number.hasFocus ? _backspace(_controller_main_number) :
                            _focus_from_base.hasFocus ? _backspace(_controller_from_base) :
                            _focus_to_base.hasFocus ? _backspace(_controller_to_base) :
                            _focus_answer.hasFocus ? _backspace(_controller_answer) :
                            _focus_minimum.hasFocus ? _backspace(_controller_minimum) :
                            _focus_maximum.hasFocus ? _backspace(_controller_maximum) :
                            _backspace(_controller_calc) ;
                            } ,
                            callbackFunction: () {
                              show_keboard();
                            },
                            calculator_callbackFunction: () {
                              show_keboard_calculator();
                            },
                          ),
                        ),
                    
                        Visibility(visible: calculator_visible ,
                          child: Align(alignment: Alignment.bottomCenter,
                            child: Calculator_Keyboard(
                              // we don't have access to _calculateor_textfield_focus directly so we use
                              // below methods
                                calculator_textfield_focus: calculator_textfield_focus_
                                ,
                                calculator_textfield_controller: calculator_textfield_controller_
                                ,
                                onTextInput: (myText) {check_calculator_input(_controller_calc.text, myText);},
                    
                                onBackspace: () {
                                  _backspace(_controller_calc);
                                } ,
                                calculator_callbackFunction: () {
                                  show_keboard_calculator();
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          ),
        )
    );
  }


  // ////////////////////////////////////  Functions for numeral practice page

  void check_calculator_input(current , myText) {
    // current is _controller_calc.text that is just numbers
    final textSelection = _controller_calc.selection;
    if (myText != "=") {
      if (_controller_calc.text == "" ||
          (_controller_calc.text != "" && (_operators.any((item) =>
              _controller_calc.text[_controller_calc.text.length - 1].contains(
                  item))))) {
        showAlertDialog(context);
      } else {
        // (current1 =  current1 + myText) ;
        (_controller_calc.text = _controller_calc.text + myText);
        _controller_calc.selection = textSelection.copyWith(
          baseOffset: _controller_calc.text.length,
          extentOffset: _controller_calc.text.length,
        );
      }
    }

    else {
      eval_math();
    }
    _controller_calc.selection = textSelection.copyWith(
      baseOffset: _controller_calc.text.length,
      extentOffset: _controller_calc.text.length,
    );
  }

  void eval_math() {
    String _result = (_controller_calc.text);
    Expression exp = p.parse(_result);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);
    String toFarsi = eval.toStringAsFixed(0);
    _controller_calc.text = toFarsi ;
  }




  void show_keboard() {
    setState(() {
      _visible = !_visible; if (calculator_visible = false);
    }
    );
  }

  void show_keboard_calculator() {
    setState(() {
      calculator_visible = !calculator_visible;
    });
  }

  int onPress(id) {
    return(id);
  }


  // void show_answer <T extends num>() {
  show_answer(id, timerEnabled){
    // updating random numbers if user manually change them
    main_number_text =(_controller_main_number.text);
    to_base_text= (_controller_to_base.text);
    from_base_text= (_controller_from_base.text);

    // removing zeros at the start of number
    int y = 0;
    while (main_number_text[y] == "0") {
      y = y + 1;
    }
    int j = main_number_text.length;
    main_number_text = main_number_text.substring(y,j);


    int k = 0;
    ValueChanged<String> changeClassValue;

    if ((_controller_main_number.text == "") || (_controller_from_base.text == "") ||
        (_controller_to_base.text == "") || (_controller_answer.text == "")) {
      showAlertDialogEmptyInput(context);
    }
    else if (int.parse(main_number_text) >100000000000) {
      showAlertDialogEmptyInput(context);
    } else if (int.parse(from_base_text) > 10 || int.parse(to_base_text) > 10) {
      showAlertDialogEmptyInput(context);
    } else {

      // sw_started = False
      int digit1 = int.parse(main_number_text);
      String digit1Print = (digit1.toString());
      int toBase = int.parse(to_base_text);
      int fromBase = int.parse(from_base_text);


      if (fromBase < 10)   // first the main number must convert to base ten
        // T res = main_number_text[0] as T;
        for (var i = 0; i < (main_number_text.length); i++) {
          int reverseIndex = main_number_text.length - i - 1;
          k = k + (int.parse(main_number_text[i]) * (pow(fromBase,reverseIndex)) as int);
          // as int prevents occurring error of dart A value of type 'num' can't be assigned to a variable of type 'int'
          digit1= k;
          //  digit1.copyWith =
          //      k; // copyWith is used to prevent occurring error "There isn’t a setter named 'digit1' in class"
        }


      String text1 = "The answer is not correct.";

      String text3 = "Your answer is correct. ";


      if (!(fromBase < 10 && toBase < 10)) {

        int i = 0;
        List<int> q = [];
        int remainder = digit1 % toBase;
        int quotient = digit1 ~/ toBase;
        int quotient_ = quotient;
        q.add(remainder);
        q.add(quotient);
        List<String> strDigit1 = List<String>.generate(
          // sending characters of digit1 to list str_dihit1
            main_number_text.length, (index) => main_number_text[index]);

        while (quotient > toBase - 1) {
          quotient = quotient ~/ toBase; // to_base
          q.add(quotient);}

        dig = [];
        n_base_expand = [];
        List<String> nBaseDigit = [];

        // generating list of nested quotients which are the coefficients
        for (var i = 0; i < (q.length); i++) {
          dig.add((q[i] % toBase).toString());
        }

        if (int.parse((_controller_main_number.text)) <
            int.parse((_controller_to_base.text))) {
          dig.removeAt(1);
        } // removing last "+"

        plus_power=[" "];
        int j = dig.length - 1; // (start, stop, step)
        for (var i = j;  i >-1 ; i--)
        {
          plus_power.add("/${dig[i]}" );
          plus_power.add( "× ${_controller_to_base.text}" );
          plus_power.add("*${(i.toString())} ");
          plus_power.add("+");
          nBaseDigit.add(dig[i].toString());
        }
        plus_power.removeAt(plus_power.length -1); // removing last "+"

        String expanded ="";
        expanded = n_base_expand.join("");

        String? digit_;
        digit_ = nBaseDigit.join("");
        digit_ = (digit_);
        if (digit_ == _controller_answer.text) {
          notificationcolor.value = 1;
        } else {
          notificationcolor.value = 0;
        }

        if (id == 0) {//show answer of check button is pressed
          if (fromBase < 10) {
            _answer_text = (
                ' $digit1Print (in base ${_controller_from_base.text} ) =\n $digit1 (in base 10) =');
          } else  {
            _answer_text = (' $digit1Print (in base 10) = \n $digit_ (in base ${(toBase.toString())} ) = ');
          };

        }
        else if (id == 1) { //show answer of answer button is pressed
          _answer_text =  (digit_ == (_controller_answer.text)) ? text3 : text1;
          notificationlist.value = [];

        }
        if (id== 0) {
          notificationlist.value = plus_power;
        }

        notificationtext.value = _answer_text;



      } // if of Random_numbers

      else {
        // Logic for converting from a base < 10 to another base < 10

        // 1. Convert from 'fromBase' to base 10
        int base10Value = 0;
        for (int i = 0; i < main_number_text.length; i++) {
          int digit = int.parse(main_number_text[i]);
          base10Value += digit * pow(fromBase, main_number_text.length - 1 - i) as int;
        }

        // 2. Convert from base 10 to 'toBase'
        String convertedValue = "";
        int quotient = base10Value;
        List<String> remainders = [];

        while (quotient > 0) {
          int remainder = quotient % toBase;
          remainders.add(remainder.toString());
          quotient = quotient ~/ toBase;
        }

        // Reverse remainders to get the correct order
        convertedValue = remainders.reversed.join();

        // Set value to display on notification list
        if (id == 0) {
          notificationlist.value = [digit1Print];
        }

        // Set value to display on answer text
        _answer_text = '$digit1Print (in base $fromBase) =\n $base10Value (in base 10) =\n $convertedValue (in base $toBase)';
        if (id== 0) {
          notificationlist.value = plus_power;
        }

        notificationtext.value = _answer_text;

      }


      /*else {
        //   List <String> str_digit1;
        String strDigit1 = digit1.toString() ;
        List<String> nBaseExpand = [];
        int digitIntoTen = 0;


        // converting to base 10
        for (int i = strDigit1.length - 1; i == 0; i--) {
          digitIntoTen = (digitIntoTen) +
              int.parse(strDigit1[strDigit1.length - i - 1]) *
                  pow(fromBase, i) as int;
        }


        List<int> q = [];
        int remainder = int.parse(main_number_text) % toBase;
        int quotient = int.parse(main_number_text) ~/ toBase;

        q.add(remainder);
        q.add(quotient);

        while (quotient > toBase - 1){
          quotient = quotient ~/ toBase;
          q.add(quotient);}

        List<String> dig = [];
        List<String> nBaseDigit = [];
        plus_power = [];

        for (int i = 0; i < nBaseExpand.length ; i++) {
          dig.add((q[i] % toBase).toString());
        }
        String jointLetters = "";


        //     if ((dig[0]) == 0)
        //      dig = dig[1:] as List<int>;

        int j = dig.length - 1;
        for (int i = j; i == 0; i--){
          nBaseExpand.add(' $dig[i] × $toBase  ');
          nBaseDigit.add(dig[i].toString());
          jointLetters = jointLetters + dig[i].toString();}


        String expanded = "";
        for (int i = 0; i < nBaseExpand.length - 1; i++) {
          expanded = expanded + (nBaseExpand[i] + "+");
        }
        // concatenating all items but the last one with + in their between
        expanded = expanded +  (nBaseExpand[nBaseExpand.length - 1]);
        // adding last item

        String digit_ = "";
        int h; // concatenating all items of n_base_digit
        for (int i = 0; i < nBaseDigit.length - 1; i++) {
          digit_ = digit_ + (nBaseDigit[i].toString());
        }


        if (fromBase < 10) {
          _answer_text1 = (
              ' $digit1Print  ($fromBase in base) =\n $digit1 (in base 10) = \n $digit_ ($toBase in base) = ');
        } else {
          _answer_text1 = (
              ' $digit1Print ($fromBase in base) = $digit_ ($toBase in base) = ');
        }

      }*/ //else of Random_numbers

      // else if (id == 1)

    } //else of input errors
  }
}
