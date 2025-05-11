import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'custom_keyboard.dart';
import 'mental_calculation.dart';
import 'package:share_plus/share_plus.dart';


void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void shareApp() {
    const String appLink = 'https://play.google.com/store/apps/details?id=com.tech4dev.math_joy_practice_english';
    const String appName = 'Math Joy Practice';

    Share.share(
      'Check out $appName: $appLink',
      subject: 'Share $appName',
    );
  }


// Update the function signature to accept context
  Future<void> launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'tarashekaft@gmail.com',
      queryParameters: {
        'subject': 'Math Joy practice App Feedback',
        'body': 'Dear Developer,\n\n'
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No email app found')),
        );
        await Clipboard.setData(const ClipboardData(text: 'tarashekaft@gmail.com'));
      }
    } catch (e) {
      debugPrint('Email error: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to launch email')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/page1.JPEG'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), // Adjust opacity here (0.0 to 1.0)
              BlendMode.darken, // Use BlendMode to control how the color is applied
            ),
          ),
        ),

        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Align(
                child: SizedBox(
                  height: 10,
                ),
              ),

              const Text('Math Is Beautiful',
                style: TextStyle(
                  color: Colors.limeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,// double
                ),
              ),

              const SizedBox(
                height: 190,
              ),

              Center( // Wrap the Column in a Center widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Use center instead of stretch
                  children: [
                    SizedBox(
                      width: 300, // Set your desired button width here
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Mental_calculation_page()),
                          );
                        },
                        child: const Text('Math Mental Tricks'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300, // Same width for all buttons
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                          );
                        },
                        child: const Text('Number Systems'),
                      ),
                    ),
                  ],
                ),
              ),

              const Align(
                child: SizedBox(
                  height: 110,
                ),
              ),


              Column(
                children: [
                  IconButton(
                    icon:  const Icon(Icons.data_saver_on),
                    color:Colors.limeAccent,
                    iconSize: 40,
                    onPressed: (){
                      showAlertDialog(context);
                    },
                  ),

                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.share, size: 28, color: Colors.deepOrange),
                    onPressed: shareApp, // Use the shareApp function directly
                    tooltip: 'Share App',
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.email, size: 28, color: Colors.deepOrange),
                    onPressed: () {
                      launchEmail(context);  // Pass context here
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              )
            ]
        ),

      ),

    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = Center(
    child: ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(scrollable: true,
    title: const Text("\nPurpose & Audience",
        style: TextStyle(   fontSize: 24, color: Colors.pink)),

    content:RichText(
      text: const TextSpan(
        children: <TextSpan>[
      TextSpan(
      text: 'Many people do not find learning mathematics easy or enjoyable. '
          'The goal of creating the app is to introduce and teach several mathematical topics in an accessible way. '
          'We have strived to ensure that users, through familiarity, simple learning, '
          'and interactive exercises, have an enjoyable experience of learning and applying mathematical knowledge.\n\n'
          'Different groups of people can use the app, including elementary '
          'school students and older individuals who may not have extensive '
          'formal education. They can utilize different sections of the app, '
          'such as mental addition and subtraction, and apply them in their daily lives.\n\n\n',
         style: TextStyle(   fontSize: 22, color: Colors.black)),

          TextSpan(text: 'Benefits of the app\n\n', style: TextStyle( color: Colors.pink, fontSize: 24)),
          TextSpan(text:
              '🚀 This app helps you develop your mental abilities by teaching some mathematical concepts and computational tricks.\n\n'
              '🧠 Numerous studies suggest that mental activity can reduce the risk of cognitive decline and Alzheimer\'s disease, which may occur with aging. Especially today, as we heavily rely on technology and smart tools handle many of our tasks, we no longer memorize phone numbers, smart navigators guide us, and many other daily routines are increasingly replaced by technology, which can diminish our mental abilities.\n\n'
                '💪 Like muscles, the brain becomes more capable and efficient with exercise. '
                  'One of the best mental exercises is learning and practicing mathematics.'
                  ' Mathematical skills keep the brain dynamic, improve logical thinking, '
                  'and help us find better solutions to challenges by recognizing patterns.\n\n'
                '📚 Researches indicate that continuous use of social networks causes our brains to be constantly stimulated, becoming accustomed to performing multiple simple tasks in a short time, such as viewing photos and short texts. This reduces our ability to concentrate, especially on complex subjects, for extended periods. Moreover, browsing social media extensively accustoms our brains to consuming and discarding information, which can also impair our learning ability because learning requires us to remember various pieces of information.\n\n'
                'Various methods exist to enhance mental capacity, such as practicing and learning mathematics or playing chess, which requires concentration and increases our attention span. Attention span is the amount of time we continuously focus on a task before becoming fatigued. This app helps you increase your attention span.\n\n'
                '✨ So, if you encounter a difficulty in an exercise, know that apart from learning mathematics, you are also enhancing your mental abilities and can concentrate more on difficult tasks, even if they are not related to mathematics. Furthermore, mental math skills assist students in mathematics and other subjects like science, physics, and even art, which require estimating lengths, areas, and angles. Mental math skills are particularly beneficial in exams where calculator use is not permitted.\n\n'
                '🎉 Treat the exercises as a form of entertainment and try to apply the skills you learn in '
                  'your daily tasks and occupation. Beyond this, regular use of the app can also improve memory, '
                  'boost confidence, and enhance overall cognitive function! To further enhance your experience, '
                  'the app offers a range of benefits, including:\n\n'
                '✅ Facilitates understanding: It makes complex math concepts easier to grasp.\n\n'
                '🚀 Offers independent learning: It allows users to learn and practice at their own pace.\n\n'
             //   '💡 Creates motivation: It uses rewards and engaging elements to encourage learning.\n\n'
                  '🧩 Strengthens problem-solving skills: It provides exercises to enhance analytical skills.\n\n'
                  '🌍 Having an educational mobile app enables learning anytime, anywhere: It offers access to education on the go.\n\n'
                '⚙️ Offers customization: It can be personalized based on the user\'s level by setting range of numbers.\n\n'
                '🤝 Offers interactive learning: It empowers learners with unlimited practice, encouraging active engagement and mastery.\n\n'
                '🎮 After mastering the concepts, use timer in the app to track your progress, and also compete against '
                  'others to solve problems quickly.\n\n '
                  '📚 Compare different conversion methods using the reference links at the bottom of'
                  ' each learning page. '
                  'In compare to them, if you find techniques provided in this'
                  ' app helpful, especially in the section of converting number bases and the'
                  ' design of practices'
                  ', please share the app with fellow math enthusiasts!\n\n',
            style: TextStyle( fontSize: 22, color: Colors.black),
          )

            // TextSpan(text: ' world!', style: TextStyle(fontFamily: "Roboto", fontSize: 30, color: Colors.red)),
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/////////////////////////////////////// pop ups

showAlertDialog_empty_input(BuildContext context) {
  // Create button
  Widget okButton = Center(
    child: ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(scrollable: true,
    content:RichText(
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(text:'Please fill all fields and make sure numeral bases are not greater than 10.'
              , style: TextStyle(   fontSize: 25, color: Colors.black)),
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



////////////////////////////////////////////////////////////Numeral menu page


class Numeral_menu_page extends StatefulWidget {
  const Numeral_menu_page({super.key});

  @override
  _Numeral_menu_pageState createState() => _Numeral_menu_pageState();
}

class _Numeral_menu_pageState extends State<Numeral_menu_page> {
  static const String _productId = 'nonConsumable1';
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _isPurchased = false;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _initPurchaseInfo();
    _subscription = _iap.purchaseStream.listen(_handlePurchaseUpdate);
  }


  Future<void> _initPurchaseInfo() async {
    // Check local storage first
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPurchased = prefs.getBool(_productId) ?? false;
    });
  }

  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID == _productId &&
          (purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored)) {
        // Save purchase status locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_productId, true);

        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }

        setState(() => _isPurchased = true);
      }
    }
  }

  Future<void> _buyProduct() async {
    setState(() => _isLoading = true);

    try {
      final productDetails = (await _iap.queryProductDetails({_productId})).productDetails.first;
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
    setState(() => _isLoading = true);

    try {
      await _iap.restorePurchases();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Purchases restored successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restore failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }



  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/back4.JPEG'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), // Adjust opacity here (0.0 to 1.0)
                BlendMode.darken, // Use BlendMode to control how the color is applied
              ),
              //  fit: BoxFit.cover,
            )
        ),


        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 90,
              ),

              Container(
                padding: const EdgeInsets.all(8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                  color: const Color.fromARGB(120, 66, 4, 4), // Transparent background color (adjust the alpha value as needed)
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
                ),
                child: const Text('Math: Precise Ideas, Better Living ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                    fontSize: 22.0,// double

                  ),
                ),
              ),

              const Align(
                child: SizedBox(
                  height: 90,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 2, 139, 4),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(220, 95),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Numeralbase_explain_page()),
                  );
                },
                child: const Text('Numeric systems?',
                  style: TextStyle(color: Colors.white,

                    fontSize: 24,// double
                     
                  ),
                ),
              ),
              const Align(
                child: SizedBox(
                  height: 20,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 2, 139, 4),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(220, 85),
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Numeralbase_example_page()),
                  );
                },

                child: const Text(
                  '   Examples   ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,// double
                     
                  ),
                ),
              ),


              const Align(
                child: SizedBox(
                  height: 20,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 139, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: const Size(220, 75),
                ),
                onPressed: _isLoading
                    ? null
                    : () {
                  if (_isPurchased) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Numeralbase_practice_page(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Unlock Practice'),
                        content: const Text('Get lifetime access to practice features.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _buyProduct();
                            },
                            child: const Text('Purchase'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  '  Practice  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _isLoading ? null : _restorePurchases,
                child: const Text(
                  'Restore Purchases',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const Align(
                child: SizedBox(
                  height: 70,
                ),
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon:  const Icon(Icons.keyboard_return),
                    color:Colors.lightGreenAccent,
                    iconSize: 44,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Homepage()),
                      );
                    },
                  )),
           const SizedBox(
                height: 30,
              ),
            ]
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

class Numeralbase_explain_page extends StatefulWidget {
  @override
  State<Numeralbase_explain_page> createState() => _Numeralbase_explain_page();
}

class _Numeralbase_explain_page extends State<Numeralbase_explain_page> with TickerProviderStateMixin {
  late List<GlobalKey> expansionTile_number_base;
  int selected = -1;
  final List<AdvancedTile> items = [

    AdvancedTile(
      title: 'Decimal numeral system\n',
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 163, 3),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[

              TextSpan(
                text: 'The Decimal Number System\n\n ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
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
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


              TextSpan(
                text: '🤔 Why Powers in Expanded Form (Base 10)?\n ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
              ),
              TextSpan(
                text: "📌 In base 10, we only use digits 0-9.  These digits are actually the coefficients of powers of 10.\n\n"

                    "❌ We can't write 147 as 14 × 10^1 + 7 × 10^0 because coefficients must be single digits (0-9). 14 is not a single digit!\n\n"

                    "✅ Instead: We need a higher power of 10 to represent a larger part of 147.  This ensures all coefficients of 10 are from 0 to 9:\n\n"

                    "   147 = 1 × 10^2 + 4 × 10^1 + 7 × 10^0 = 1 × 10^2 + 4 × 10^1 + 7\n\n"

                    "✨ In everyday life, we use powers of 10 (place value) to easily express numbers. The 5 in 536 represents 500, but in 5206 it represents 5000! Position matters!\n\n"

                    "💡 Explanation:\n\n"

                    "  📍 Place Value: A digit's 'address' in a number (e.g., in 123, 1 is 100, 2 is 20, 3 is 3).\n\n"

                    "  📍 Powers of 10: Help assign the correct value based on position (e.g., in 123, 1 is multiplied by 10^2, 2 by 10^1, 3 by 10^0).\n\n"

                    "  📍 Why Powers? We can represent *any* number using only digits 0-9 as coefficients and powers of 10! This compact form is crucial.\n\n"

                    "🎓 The Bottom Line: Powers of 10 and digits 0-9 are the foundation of our number system, allowing us to represent any number and perform mathematical operations effectively. 🧮\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(
                text: '🔢 Expanded Form for Decimal Numbers (Base 10)?\n ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
              ),
              TextSpan(
                text: "📌 Decimal numbers (like 14.67) have digits *after* the decimal point, representing fractions of 1.\n\n"

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
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


            ],
          ),
        ),
      ),),

    AdvancedTile(
      title: 'Number systems with a base less than 10\n',
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 163, 3),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '🔢 Number Systems with Base < 10\n',
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
              ),
              TextSpan(
                text: "📌 In a base-n number system, there are only n digits (0 to n-1). E.g., base 10 has 0-9, base 8 has 0-7. 📌\n\n"

                    "✨ Base-8 numbers use powers of 8 with coefficients from 0 to 7. Example: 17 (base 10) = 21 (base 8) ✨\n\n"

                    " 1️⃣  17 (base 10) = 1 × 10^1 + 7 × 10^0\n"
                    " 2️⃣  21 (base 8) = 2 × 8^1 + 1 × 8^0\n\n"

                    "🤔 But how do we know 17 (base 10) = 21 (base 8)?\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(
                text: ' Method 1: Repeated Division\n',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                    255, 150, 1, 76), fontSize: 26),
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
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(
                text: ' Method 2: Predicting Coefficients (Base Conversion)\n',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                    255, 150, 1, 76), fontSize: 26),
              ),
              TextSpan(
                text: "✨ For mental math lovers! This method is quicker for smaller numbers with some practice. ✨\n\n"

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
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

            ],
          ),
        ),
      ),),

    AdvancedTile(
      title: 'Number systems with a base greater than 10\n',
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 163, 3),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[


              TextSpan(
                text: '🔢 Number Systems with Base > 10\n',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
              ),
              TextSpan(
                text: "📌 Bases larger than 10 need more than ten digits! Base 12, for example, needs twelve unique digits. 📌\n\n"

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
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


            ],
          ),
        ),
      ),),

  ];

  @override
  void initState(){
    super.initState();
    // Generating key for each items
    expansionTile_number_base = List<GlobalKey<_Numeralbase_explain_page>>.generate(items.length,
            (index) => GlobalKey());

    }

  double? _fontSize = 25;
  void _changeFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }
  @override
  Widget build(BuildContext context) {

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
                Colors.black.withOpacity(0.4), // Adjust opacity here (0.0 to 1.0)
                BlendMode.darken, // Use BlendMode to control how the color is applied
              ),
            )
        ),

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
                                  // Whenever newState is True, setState will be called and index of clicked
                                  // menu goes to selected that closes other opened widget
                                  onExpansionChanged: (newState){
                                    if(newState){
                                      setState(() {
                                        selected = index;
                                        _changeFontSize(10);
                                      });
                                    }
                                    else{
                                      setState(() {
                                        selected = -1;
                                        // items are numbered from zero, so no one of widgets would be opened
                                        _changeFontSize(35);
                                      });
                                    }
                                  },
                                  title: Center(

                                    child: SizedBox(
                                      child: Text(
                                        items[index].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:  selected==-1 ? 20:15,// size of closed tiles

                                        ),
                                      ),
                                    ),
                                  ),
                                  children:  <Widget>[
                                    AspectRatio(aspectRatio: .8, // ratio of width to height of each opened tile
                                      child: ListView.builder(itemCount: 1,
                                          itemBuilder: (context, item){
                                            //if you have defined body of advanced tile as string then here:
                                            // return Image.asset(items[index].body but now we need:
                                            return (items[index].body
                                            );
                                          }),
                                    )
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
                    iconSize: 35,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                      );
                    },
                  ),

                  IconButton(
                    icon:  const Icon(Icons.home),
                    color:Colors.white,
                    iconSize: 35,
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
                    iconSize: 35,
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
    );
  }
}


/////////////////////////////////////////:://////////////////////////// Numeralbase_example page

class Numeralbase_example_page extends StatelessWidget {
  const Numeralbase_example_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(color: Color.fromARGB(255, 230, 86, 3),
        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(
                height: 20,
              ),
               Container(width: 360,
                padding: const EdgeInsets.all(18.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
             //     color: const Color.fromARGB(120, 66, 4, 4), // Transparent background color (adjust the alpha value as needed)
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
                ),
                child: const Text(
                  'Mathematics is about exploring patterns and making connections. '
                      'Does one have to be a genius to do mathematics? The answer is an emphatic NO - Terence Tao',
                  style: TextStyle(
                    color: Colors.white,
                //    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                      text: const TextSpan(
                        children: <TextSpan>[

                          TextSpan(
                            text: '✨ Examples of Numbers in Bases Other Than 10\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
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
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),

                          TextSpan(
                            text: '✨ Finding (78)₁₀ in Base 3\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
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
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (78)₁₀ in Base 7 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
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
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (78)₁₀ in Base 7 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
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
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (44)₁₀ in Base 9 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [5]\n\n"
                                "   🔑 44 ÷ 9 = 4 remainder 8\n"
                                "   🔑 4 ÷ 9 = 0 remainder 4\n"
                                "   🔑 Reading remainders from bottom to top: (48)₉\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 9 less than 44: 9¹ = 9\n"
                                "   2️⃣ Largest multiple of 9 less than 44: 4 * 9 = 36 (So the first digit is 4)\n"
                                "   3️⃣ Remainder: 44 - 36 = 8\n"
                                "   4️⃣ Largest power of 9 less than 8: 9⁰ = 1\n"
                                "   5️⃣ Largest multiple of 1 less than 8: 8 * 1 = 8 (So the next digit is 8)\n"
                                "   ✅ Combining the digits: (48)₉\n\n"
                                "So (44)₁₀ = (48)₉ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (25)₁₀ in Base 2 (Binary) ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division\n\n"
                                "   🔑 25 ÷ 2 = 12 remainder 1\n"
                                "   🔑 12 ÷ 2 = 6 remainder 0\n"
                                "   🔑 6 ÷ 2 = 3 remainder 0\n"
                                "   🔑 3 ÷ 2 = 1 remainder 1\n"
                                "   🔑 1 ÷ 2 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (11001)₂\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 2 less than 25: 2⁴ = 16\n"
                                "   2️⃣ Largest multiple of 16 less than 25: 1 * 16 = 16 (So the first digit is 1)\n"
                                "   3️⃣ Remainder: 25 - 16 = 9\n"
                                "   4️⃣ Largest power of 2 less than 9: 2³ = 8\n"
                                "   5️⃣ Largest multiple of 8 less than 9: 1 * 8 = 8 (So the next digit is 1)\n"
                                "   6️⃣ Remainder: 9 - 8 = 1\n"
                                "   7️⃣ Largest power of 2 less than 1: 2⁰ = 1\n"
                                "   8️⃣ Largest multiple of 1 less than 1: 1 * 1 = 1 (So the next digit is 1)\n"
                                "   ✅ Combining the digits: (11001)₂\n\n"
                                "So (25)₁₀ = (11001)₂ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (52)₁₀ in Base 8 (Octal) ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [1][3]\n\n"
                                "   🔑 52 ÷ 8 = 6 remainder 4\n"
                                "   🔑 6 ÷ 8 = 0 remainder 6\n"
                                "   🔑 Reading remainders from bottom to top: (64)₈\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 8 less than 52: 8¹ = 8\n"
                                "   2️⃣ Largest multiple of 8 less than 52: 6 * 8 = 48 (So the first digit is 6)\n"
                                "   3️⃣ Remainder: 52 - 48 = 4\n"
                                "   4️⃣ Largest power of 8 less than 4: 8⁰ = 1\n"
                                "   5️⃣ Largest multiple of 1 less than 4: 4 * 1 = 4 (So the next digit is 4)\n"
                                "   ✅ Combining the digits: (64)₈\n\n"
                                "So (52)₁₀ = (64)₈ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (233)₁₀ in Base 5 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division\n\n"
                                "   🔑 233 ÷ 5 = 46 remainder 3\n"
                                "   🔑 46 ÷ 5 = 9 remainder 1\n"
                                "   🔑 9 ÷ 5 = 1 remainder 4\n"
                                "   🔑 1 ÷ 5 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (1413)₅\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 5 less than 233: 5³ = 125\n"
                                "   2️⃣ Largest multiple of 125 less than 233: 1 * 125 = 125 (So the first digit is 1)\n"
                                "   3️⃣ Remainder: 233 - 125 = 108\n"
                                "   4️⃣ Largest power of 5 less than 108: 5² = 25\n"
                                "   5️⃣ Largest multiple of 25 less than 108: 4 * 25 = 100 (So the next digit is 4)\n"
                                "   6️⃣ Remainder: 108 - 100 = 8\n"
                                "   7️⃣ Largest power of 5 less than 8: 5¹ = 5\n"
                                "   8️⃣ Largest multiple of 5 less than 8: 1 * 5 = 5 (So the next digit is 1)\n"
                                "   9️⃣ Remainder: 8 - 5 = 3\n"
                                "   🔟 Largest power of 5 less than 3: 5⁰ = 1\n"
                                "   🔢 Largest multiple of 1 less than 3: 3 * 1 = 3 (So the next digit is 3)\n"
                                "   ✅ Combining the digits: (1413)₅\n\n"
                                "So (233)₁₀ = (1413)₅ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (499)₁₀ in Base 2 (Binary) ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [3][6]\n\n"
                                "   🔑 499 ÷ 2 = 249 remainder 1\n"
                                "   🔑 249 ÷ 2 = 124 remainder 1\n"
                                "   🔑 124 ÷ 2 = 62 remainder 0\n"
                                "   🔑 62 ÷ 2 = 31 remainder 0\n"
                                "   🔑 31 ÷ 2 = 15 remainder 1\n"
                                "   🔑 15 ÷ 2 = 7 remainder 1\n"
                                "   🔑 7 ÷ 2 = 3 remainder 1\n"
                                "   🔑 3 ÷ 2 = 1 remainder 1\n"
                                "   🔑 1 ÷ 2 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (111110011)₂\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 2 less than 499: 2⁸ = 256\n"
                                "   2️⃣ Largest multiple of 256 less than 499: 1 * 256 = 256 (So the first digit is 1)\n"
                                "   3️⃣ Remainder: 499 - 256 = 243\n"
                                "   4️⃣ Largest power of 2 less than 243: 2⁷ = 128\n"
                                "   5️⃣ Largest multiple of 128 less than 243: 1 * 128 = 128 (So the next digit is 1)\n"
                                "   6️⃣ Remainder: 243 - 128 = 115\n"
                                "   7️⃣ Largest power of 2 less than 115: 2⁶ = 64\n"
                                "   8️⃣ Largest multiple of 64 less than 115: 1 * 64 = 64 (So the next digit is 1)\n"
                                "   9️⃣ Remainder: 115 - 64 = 51\n"
                                "   🔟 Largest power of 2 less than 51: 2⁵ = 32\n"
                                "   Numbers: Largest multiple of 32 less than 51: 1 * 32 = 32 (So the next digit is 1)\n"
                                "   🔑 Remainder: 51 - 32 = 19\n"
                                "   🔑 Largest power of 2 less than 19: 2⁴ = 16\n"
                                "   🔑 Largest multiple of 16 less than 19: 1 * 16 = 16 (So the next digit is 1)\n"
                                "   🔑 Remainder: 19 - 16 = 3\n"
                                "   🔑 Largest power of 2 less than 3: 2¹ = 2\n"
                                "   🔑 Largest multiple of 2 less than 3: 1 * 2 = 2 (So the next digit is 1)\n"
                                "   ✅ Remainder: 3 - 2 = 1\n"
                                "   ⛔️ Largest power of 2 less than 1: 2⁰ = 1\n"
                                "   ✅ Largest multiple of 1 less than 1: 1 * 1 = 1 (So the next digit is 1)\n"
                                "   Combining the digits: (111110011)₂\n\n"
                                "So (499)₁₀ = (111110011)₂ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (1333)₁₀ in Base 9 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [1][4][5]\n\n"
                                "   🔑 1333 ÷ 9 = 148 remainder 1\n"
                                "   🔑 148 ÷ 9 = 16 remainder 4\n"
                                "   🔑 16 ÷ 9 = 1 remainder 7\n"
                                "   🔑 1 ÷ 9 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (1741)₉\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 9 less than 1333: 9³ = 729\n"
                                "   2️⃣ Largest multiple of 729 less than 1333: 1 * 729 = 729 (So the first digit is 1)\n"
                                "   3️⃣ Remainder: 1333 - 729 = 604\n"
                                "   4️⃣ Largest power of 9 less than 604: 9² = 81\n"
                                "   5️⃣ Largest multiple of 81 less than 604: 7 * 81 = 567 (So the next digit is 7)\n"
                                "   6️⃣ Remainder: 604 - 567 = 37\n"
                                "   7️⃣ Largest power of 9 less than 37: 9¹ = 9\n"
                                "   8️⃣ Largest multiple of 9 less than 37: 4 * 9 = 36 (So the next digit is 4)\n"
                                "   9️⃣ Remainder: 37 - 36 = 1\n"
                                "   Numbers: Largest power of 9 less than 1: 9⁰ = 1\n"
                                "   🔑 Largest multiple of 1 less than 1: 1 * 1 = 1 (So the next digit is 1)\n"
                                "   Combining the digits: (1741)₉\n\n"
                                "So (1333)₁₀ = (1741)₉ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),

                          TextSpan(
                            text: '✨ Finding (444)₁₀ in Base 4 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [4][7]\n\n"
                                "   🔑 444 ÷ 4 = 111 remainder 0\n"
                                "   🔑 111 ÷ 4 = 27 remainder 3\n"
                                "   🔑 27 ÷ 4 = 6 remainder 3\n"
                                "   🔑 6 ÷ 4 = 1 remainder 2\n"
                                "   🔑 1 ÷ 4 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (12330)₄\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 4 less than 444: 4³ = 64\n"
                                "   2️⃣ Largest multiple of 64 less than 444: 6 * 64 = 384 (So the first digit is 6). However, 6 is not a valid digit in base 4, which only uses digits 0-3. So we can only have 3*64=384 So the first digit is 3.\n"
                                "   3️⃣ Remainder: 444 - 384 = 60\n"
                                "   4️⃣ Largest power of 4 less than 60: 4² = 16\n"
                                "   5️⃣ Largest multiple of 16 less than 60: 3 * 16 = 48 (So the next digit is 3)\n"
                                "   6️⃣ Remainder: 60 - 48 = 12\n"
                                "   7️⃣ Largest power of 4 less than 12: 4¹ = 4\n"
                                "   8️⃣ Largest multiple of 4 less than 12: 3 * 4 = 12 (So the next digit is 3)\n"
                                "   9️⃣ Remainder: 12 - 12 = 0\n"
                                "   Numbers: Largest power of 4 less than 0: 4⁰ = 1\n"
                                "   🔑 Largest multiple of 1 less than 0: 0 * 1 = 0 (So the next digit is 0)\n"
                                "   Combining the digits: (3330)₄\n\n"
                                "So (444)₁₀ = (12330)₄ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Finding (5000)₁₀ in Base 5 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 We'll use both Repeated Division and Coefficient Prediction! 📌\n\n"

                                "✅ Method 1: Repeated Division [3][4]\n\n"
                                "   🔑 5000 ÷ 5 = 1000 remainder 0\n"
                                "   🔑 1000 ÷ 5 = 200 remainder 0\n"
                                "   🔑 200 ÷ 5 = 40 remainder 0\n"
                                "   🔑 40 ÷ 5 = 8 remainder 0\n"
                                "   🔑 8 ÷ 5 = 1 remainder 3\n"
                                "   🔑 1 ÷ 5 = 0 remainder 1\n"
                                "   🔑 Reading remainders from bottom to top: (130000)₅\n\n"

                                "✨ Method 2: Predicting Coefficients ✨\n\n"
                                "   1️⃣ Largest power of 5 less than 5000: 5⁵ = 3125\n"
                                "   2️⃣ Largest multiple of 3125 less than 5000: 1 * 3125 = 3125 (So the first digit is 1)\n"
                                "   3️⃣ Remainder: 5000 - 3125 = 1875\n"
                                "   4️⃣ Largest power of 5 less than 1875: 5⁴ = 625\n"
                                "   5️⃣ Largest multiple of 625 less than 1875: 3 * 625 = 1875 (So the next digit is 3)\n"
                                "   6️⃣ Remainder: 1875 - 1875 = 0\n"
                                "   7️⃣ Since the remainder is 0, all remaining digits are 0: (0000)\n"

                                "   Combining the digits: (130000)₅\n\n"
                                "So (5000)₁₀ = (130000)₅ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Converting (88)₇ from Base 7 to Base 10 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "📌 Important: The number (88)₇ is **invalid**!  In base 7, you can only use digits 0-6. 📌\n\n"

                                "✅ Explanation:\n\n"
                                "   In base 7, the only valid digits are 0, 1, 2, 3, 4, 5, and 6.  The digit '8' is not allowed in base 7.\n\n"

                                "💡 What if you meant something else? 💡\n\n"
                                "   If you perhaps meant (66)₇, here's how you'd convert it to base 10:\n\n"
                                "      🔑 (66)₇ = (6 * 7¹) + (6 * 7⁰) = 42 + 6 = (48)₁₀\n\n"

                                "   Let me know if you had a different number in mind to convert!\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),


                          TextSpan(
                            text: '✨ Converting (3233)₇ from Base 7 to Base 10 ✨\n',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 110, 29, 4), fontSize: 26),
                          ),
                          TextSpan(
                            text: "✅ Conversion Process:\n\n"
                                "   We'll expand the base-7 number into powers of 7 and then calculate the result:\n\n"

                                "   (3233)₇ = (3 * 7³) + (2 * 7²) + (3 * 7¹) + (3 * 7⁰)\n\n"

                                "   🔑 Let's break it down step by step:\n\n"
                                "      1️⃣ 3 * 7³ = 3 * 343 = 1029\n"
                                "      2️⃣ 2 * 7² = 2 * 49 = 98\n"
                                "      3️⃣ 3 * 7¹ = 3 * 7 = 21\n"
                                "      4️⃣ 3 * 7⁰ = 3 * 1 = 3\n\n"

                                "   Now, add all the parts together:\n\n"
                                "   1029 + 98 + 21 + 3 = 1151\n\n"

                                "   Therefore, (3233)₇ = (1151)₁₀\n\n"
                                "So, (3233)₇ = (1151)₁₀ ✅\n\n",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Row(

                  children: [
                    IconButton(
                      icon:  const Icon(Icons.keyboard_return),
                      color:Colors.lightBlue[100],
                      iconSize: 30,
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                        );
                      },
                    ),

                    IconButton(
                      icon:  const Icon(Icons.home),
                      color:Colors.lightBlue[100],
                      iconSize: 30,
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
    );
  }
}



/////////////////////////////////////////:://////////////////////////// Numeralbase_practice page
class Numeralbase_practice_page extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Numeralbase_practice_page> {
  final  ValueNotifier<List<String>> notificationlist = ValueNotifier(<String>[]); // <type> variable= initialisation
  final  ValueNotifier<String> notificationtext = ValueNotifier("");
  final  ValueNotifier<int> notificationcolor = ValueNotifier(2); // // for changing answer textfield color
  bool _visible = false;
  bool calculator_visible = false;
  final bool _flag = true;
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

  final int _counter = 0;
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
    var random = new Random();
    int result = min + random.nextInt(max - min);
    return result;
  }

  final _insertText = insertText();
  final _backspace = backspace(); // calling class backspace from customkeyboard.dart
  final _operators = ['+','-','×','÷'];
  bool _main_number_isClicked = false; // for changing answer textfield color
  List<bool> random_interval = <bool>[false];

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.

    return MultiProvider( //                                     <--- MultiProvider
      /*providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ChangeNotifierProvider<Timerbox>( // ChangeNotifierProxyProvider helps if
          // CatalogModel were to update, then CartModel will be able to update accordingly.
          create: (context) =>Timerbox(timer_changed: timer_CallBack),
        ),
      ]*/
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ChangeNotifierProvider<Timerbox>( // ChangeNotifierProxyProvider helps if
          // CatalogModel were to update, then CartModel will be able to update accordingly.
          create: (context) =>Timerbox(timer_changed: timer_CallBack),
        ),
      ],
      child: MaterialApp(
        home:Scaffold(
            backgroundColor: const Color.fromARGB(255, 32, 0, 14 ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(8,8,8,0,),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),

                    SizedBox(height: 30,
                      child: Row(
                        children: [
                          IconButton(
                            icon:  const Icon(Icons.keyboard_return),
                            color:Colors.purple,
                            iconSize: 25,
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                              );
                            },
                          ),

                          IconButton(
                            icon:  const Icon(Icons.home),
                            color:Colors.purple,
                            iconSize: 25,
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
                            iconSize: 25,
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Instructions"),
                                    content: SingleChildScrollView( // Make content scrollable
                                      child: RichText(
                                        text: const TextSpan(
                                          style: TextStyle(fontSize: 16, color: Colors.black), // Default style
                                          children: <TextSpan>[
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
                                                  "your settings to declutter the screen. However, if you close the app, "
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
                                        child: const Text("OK"),
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
                          const SizedBox(width: 110,),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: ToggleButtons(
                              isSelected: timer_box,
                              onPressed: (int index) {
                                setState(() {
                                  timer_box[index] = !timer_box[index];
                                  timer_visible = !timer_visible;
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              //  selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.yellow[400],
                              //  fillColor: Colors.blue[200],
                              color: Colors.green,
                              children: const <Widget>[
                                Icon(Icons.lock_clock, size: 25,),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: ToggleButtons( // for showing timer box
                              isSelected: random_interval_box,
                              onPressed: (int index) {
                                setState(() {
                                  random_interval_box[index] = !random_interval_box[index]; // changes the state of the button
                                  random_interval_visible = !random_interval_visible;    // gets action based on the state
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              //  selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.yellow[400],
                              //  fillColor: Colors.blue[200],
                              color: Colors.green,
                              children: const <Widget>[
                                Icon(Icons.social_distance, size: 25,),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4,),

                    Consumer<MyModel>( //            <--- MyModel Consumer
                        builder: (context, myModel, child) {
                          return Visibility(visible: timer_visible,

                            child : SizedBox(height: 32,
                                child: Timerbox(timer_changed: timer_CallBack)),
                          );}
                    ),

                    const SizedBox(height: 3,),

                    Visibility(visible: random_interval_visible,
                      child : SizedBox(height: 28,
                        child: Row(
                          children: [

                            ToggleButtons(
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
                              borderColor: const Color.fromARGB(255, 50, 87, 86),
                              borderWidth: 1.0,
                              // Remove constraints:
                              // constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                                  child: Text(
                                    'Random number',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5,),
                            Flexible(
                              child:  TextField(focusNode: _focus_minimum,
                                readOnly: true, showCursor: true,  cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 20, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                controller: _controller_minimum,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(

                                  hintText: 'min',
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(6,1,8,11),
                                  fillColor: const Color.fromARGB(255, 246, 182, 58 ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 5,),

                            Flexible(
                              child: TextField(
                                focusNode: _focus_maximum,
                                readOnly: true,
                                showCursor: true,
                                cursorHeight: 22,
                                cursorColor: Colors.black,
                                onTap: () {
                                  if (!_visible) {
                                    show_keboard();
                                  }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
                                controller: _controller_maximum,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(

                                  hintText: 'max',
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(6,1,8,11),
                                  fillColor: const Color.fromARGB(255, 246, 182, 58 ),
                                ),

                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),

                    SizedBox(height: 40,
                      child:  Consumer<MyModel>( //            <--- MyModel Consumer
                        builder: (context, myModel, child) {
                          return  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255,50, 87, 86),
                              minimumSize: const Size(399, 45), //////// HERE
                            ),
                            onPressed: () {myModel.timer_selected[0] ? {
                               myModel.resetTimer(),
                                myModel.startTimer(),
                            myModel.timerTextStartBtn ='stop',
                              myModel.timerRunning= true,
                              setState(() {
                             //   _main_number_isClicked = true;
                                notificationlist.value = []; // removing shown previous plus_power answer
                                notificationtext.value = ""; // removing shown previous answer
                                notificationcolor.value = 3;
                                myModel.timer_start_ispressed[0] = true;
                              })} :
                            { setState(() {
                            //  _main_number_isClicked = true;
                              notificationlist.value = [];
                              notificationtext.value = "";
                              notificationcolor.value = 3;
                            })};
                            _controller_answer.text = "";
                            if (random_interval[0])
                            {
                              if ( (_controller_minimum.text == "") || (_controller_maximum.text == "")) {
                                main_number_text = (randomNumber(1, 100).toString());
                              } else {
                                main_number_text = (randomNumber(int.parse((_controller_minimum.text)),
                                    int.parse((_controller_maximum.text))).toString());
                              }

                              _controller_main_number.text = main_number_text;

                              from_base_text= "10";
                              _controller_from_base.text = "10";

                              to_base_text= randomNumber(2,9).toString();
                              _controller_to_base.text = (to_base_text);

                            }
                            else {
                              main_number_text = (randomNumber(1, 100).toString());
                              _controller_main_number.text = main_number_text;

                              from_base_text= "10";
                              _controller_from_base.text = "10";

                              to_base_text= randomNumber(2,9).toString();
                              _controller_to_base.text = (to_base_text);
                              //  main_number_text = from_base_text = to_base_text = user_answer_text = "";
                            }
                            }, // onPressed

                            child:  const Text(
                              "New practice",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,// double
                                 
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    SizedBox(height:40,
                      child: Row(
                        children:  [

                          const Text('Convert number',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,// double

                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child:  TextField(focusNode: _focus_main_number, readOnly: true, showCursor: true,
                                cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  border : InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 221, 217, 218 ),
                                ),
                                controller: _controller_main_number,
                                onChanged: (text) {
                                  setState(() {});
                                }
                            ),
                          ),

                      ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    SizedBox(height:40,
                      child: Row(
                        children:  [


                          const Text('from base',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 18,// double

                            ),
                          ),
                          const SizedBox(width: 14),
                          Flexible(
                            child:  TextField(focusNode: _focus_from_base, readOnly: true, showCursor: true,
                                cursorHeight: 12, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  filled: true, border : InputBorder.none,
                                  fillColor: Color.fromARGB(255, 221, 217, 218 ),
                                ),
                                controller: _controller_from_base,
                                onChanged: (text) {
                                  setState(() {});
                                }
                            ),
                          ),


                          const SizedBox(width: 10),

                          const Text('to base',
                            style: TextStyle(
                              color: Colors.white,
                              
                              fontSize: 18,// double
                               
                            ),
                          ),

                          const SizedBox(width: 10),
                          Flexible(
                            child:  TextField(focusNode: _focus_to_base , readOnly: true, showCursor: true,
                                cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  filled: true, border : InputBorder.none,
                                  fillColor: Color.fromARGB(255, 221, 217, 218 ),
                                ),
                                controller: _controller_to_base,
                                onChanged: (text) {
                                  setState(() {});
                                }
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    SizedBox(height:40,
                      child: Row(
                        children:  [

                          const Text('Answer?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,// double
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible( child: ValueListenableBuilder<int>(valueListenable: notificationcolor,
                            builder: (context, value, widget) { return
                              TextField(focusNode: _focus_answer,
                                  readOnly: true, cursorHeight: 22, cursorColor: Colors.black,
                                  showCursor: true,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();

                                    }
                                  },
                                  autofocus: false,
                                  style: const TextStyle(
                                      fontSize: 26.0, color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                    filled: true, border : InputBorder.none,
                                    fillColor:   (value== 0) ? Color.fromARGB(255, 253, 14, 42) :
                                    (value== 1) ? Color.fromARGB(255, 43, 163, 16) :
                                    Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_answer,
                                  onChanged: (text) {
                                    setState(() {});
                                  }
                              );

                            },
                          )
                          ),


                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                Consumer<MyModel>( //            <--- MyModel Consumer
                    builder: (context, myModel, child) {
                      return
                    SizedBox(height: 40,
                      child: Row(
                        children: [
                          Flexible(
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255,50, 87, 86),
                                minimumSize: const Size(330, 45),
                              ),
                              onPressed: () => {id=0,
                              myModel.timer_selected[0] ? {
                              _controller_answer.text.isNotEmpty ? myModel.stopTimer() : null,
                              show_answer(id, timer_enabled),}
                                  :
                              show_answer(id, timer_enabled),
                              },
                              child: const Text(
                                'Answer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,// double
                                   
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 7),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255,50, 87, 86),
                                minimumSize: const Size(330, 45), //////// HERE
                              ),
                              onPressed: () => {id=1,
                                myModel.timer_selected[0] ? {
                                  _controller_answer.text.isNotEmpty ? myModel.stopTimer() : null,
                                  show_answer(id, timer_enabled),}
                                    :
                                show_answer(id, timer_enabled),
                              },
                              child: const Text(
                                'Check',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,// double
                                   
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    }
                    ),

                    const SizedBox(height: 10),
                    Padding( // box for first two line of answer
                      padding: const EdgeInsets.fromLTRB(8.0,10,0,0),
                      child: SizedBox(
                        child: ValueListenableBuilder<String>(valueListenable: notificationtext,
                            builder: (context, value, widget) {
                              if(1==1){
                                return Align(alignment: Alignment.centerLeft,
                                  child: Text(value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize:  20,// double
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                );
                              }else {

                                return
                                  // displaying list items in different box size that will be modified automatically
                                  Text("Loadinnnnnnng");
                              }
                            }
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
                                  padding: const EdgeInsets.fromLTRB(10,5,40,10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Align(alignment: Alignment.centerLeft,
                                      child: Container(color: Color.fromARGB(255, 1, 61, 59 ),
                                        child: Wrap(
                                          spacing: 8, // space between row items
                                          runSpacing: 5,
                                          children: value.map((e) => Container(
                                            margin: EdgeInsets.all(0),
                                            //    padding: EdgeInsets.all(0),
                                            //    decoration: BoxDecoration(
                                            //    color: Colors.red,
                                            //  borderRadius: BorderRadius.circular(4),

                                            child: Padding(  padding: (e.contains("*")) ?
                                            const EdgeInsets.all(0):
                                            const EdgeInsets.fromLTRB(0,10,0,0),

                                              child:LayoutBuilder(builder: (context, constraints) {
                                                if (e.contains("*")) { //
                                                  return Text(e.replaceAll("*", ""),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      
                                                      fontSize: 20, // double
                                                       
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  );
                                                } else if (e.contains("/")) {
                                                  return Text(e.replaceAll("/", ""),
                                                    style: const TextStyle(
                                                      color: Colors.lightBlue,
                                                      
                                                      fontSize: 20, // double
                                                       
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  );
                                                }
                                                else {
                                                  return Text(e,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      
                                                      fontSize: 20, // double
                                                       
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  );
                                                }
                                              }
                                              ),
                                            ),
                                          )
                                          ).toList(),
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
                )
            )
        ),
      ),
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
      showAlertDialog_empty_input(context);
    }
    else if (int.parse(main_number_text) >100000000000) {
      showAlertDialog_empty_input(context);
    } else if (int.parse(from_base_text) > 10 || int.parse(to_base_text) > 10) {
      showAlertDialog_empty_input(context);
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


/////////////////////////////////////////////////////////////// ChangeNotifier model for Timer class (methods)
// This model is used in main codes using provider + consumer, and in timer box using context.read

class MyModel with ChangeNotifier {
  Timer? countupTimer;
  Duration myDuration = const Duration(days: 5);
  List<bool> timer_selected = [false];
  List<bool> timer_start_ispressed = [false];
  String timerTextStartBtn = 'start';
  Color timerButtonColor = Colors.green;
  bool timerRunning = false;

  String strDigits(int n) => n.toString().padLeft(2, '0');

  String get days => strDigits(myDuration.inDays);

  String get hours => strDigits(myDuration.inHours.remainder(24));

  String get minutes => strDigits(myDuration.inMinutes.remainder(60));

  String get seconds => strDigits(myDuration.inSeconds.remainder(60));

  String get timeValue => (int.parse(hours) > 0)
      ? '${hours}:${minutes}:${seconds}'
      : '${minutes}:${seconds}';

  /// Timer related methods ///
  void startTimer() {
    countupTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountUp());
    timerButtonColor = Colors.purple;
    timerTextStartBtn = 'stop';
    timerRunning = true;
    timer_start_ispressed[0] = true;
    notifyListeners();
  }

  void stopTimer() {
    countupTimer?.cancel();
    timerButtonColor = Colors.red;
    timerTextStartBtn = 'resume';
    timerRunning = false;
    timer_start_ispressed[0] = false;
    notifyListeners();
  }

  void resetTimer() {
    myDuration = const Duration(days: 5);
    stopTimer();
    timerButtonColor = Colors.green;
    timerTextStartBtn = 'start';
    timerRunning = false;
    timer_start_ispressed[0] = false;
    notifyListeners();
  }


  void setCountUp() {
    const increaseSecondsBy = 1;
    myDuration += const Duration(seconds: increaseSecondsBy);
    notifyListeners();
  }
}


/////////////////////////////////////////////////////////////////// Timer box class (layouts)
class Timerbox extends StatefulWidget with ChangeNotifier{
  Timerbox({Key? key, required this.timer_changed,
  }) : super(key: key);
  //  Timerbox({super.key, required this.timer_changed});
  final Function(bool?) timer_changed;
  List<bool> timer_selected = <bool>[true];

  get timer_selected_ => timer_selected;


  _TimerboxState createState() => new _TimerboxState();
}


class _TimerboxState extends State<Timerbox> {

  String text_btn1 = 'start';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // since we don't access to MyModel context we should use context.read:
    final myModel = Provider.of<MyModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 0, 14 ),
      body: SizedBox(height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            SizedBox(
           //   width: itemWidth,
              child: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255,50, 87, 86),
                  //     border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ToggleButtons(
                  isSelected: myModel.timer_selected,
                  onPressed: (int index) {
                    setState(() {
                      myModel.timer_selected[0] = !myModel.timer_selected[0];
                      widget.timer_changed(myModel.timer_selected[0]);
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  selectedColor: Colors.red,
                  fillColor: Colors.lightBlueAccent,
                  color: Colors.red,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        '   Timer   ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
          //    width: itemWidth,
              child: Center(
                child: ToggleButtons(
                  isSelected: myModel.timer_start_ispressed,
                  onPressed: (int index) {
                    if (myModel.timer_selected[0]) {
                      if (myModel.timerRunning) {
                        myModel.stopTimer();
                      } else {
                        myModel.startTimer();
                      }
                    } else {
                      // Show the popup here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Timer Required"),
                            content: const Text("If you want to capture time for each practice, turn on the timer."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },

                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedColor: Colors.grey,
                  color: Colors.white70, // Color when *not* selected
                  children: [
                    Container(
                      width: screenWidth / 4,
                      height: 30,
                      decoration: BoxDecoration(
                        color: myModel.timerButtonColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          myModel.timerTextStartBtn,
                          style: const TextStyle( // Make the text white *always*
                            color: Colors.white, // FORCE WHITE HERE
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),

            IconButton(
              icon: const Icon(Icons.rotate_left, color: Colors.white70),
              onPressed: () {
                myModel.resetTimer();
              },
            ),

            SizedBox(
       //       width: itemWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  myModel.timeValue,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


