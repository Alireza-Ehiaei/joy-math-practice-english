import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mental_calculation.dart';
import 'numericalBase.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove Android status bar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp( MaterialApp( // don't add const that adds a debug sign on pages even with debugging off
  //  title: 'Navigation Basics',
    home: Homepage(),
    debugShowCheckedModeBanner: false, // This removes the debug banner
  ));
}


class Homepage extends StatelessWidget {
  const Homepage({super.key});
/*
  void shareApp() {
    const String appLink = 'https://play.google.com/store/apps/details?id=com.tech4dev.math_joy_practice_english';
    const String appName = 'Math Joy Practice';

    Share.share(
      'Check out $appName: $appLink',
      subject: 'Share $appName',
    );
  }*/




  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;


// Base sizes for phones
    const baseButtonWidth = 300.0;
    const baseFontSize = 30;
    const baseTitleFontSize = 35;
    const baseIconSizeLarge = 42;

// Calculate scale factor for tablets (e.g., width > 400)
    final bool isTablet = screenWidth >= 600;
    double scaleFactor = isTablet ? (screenWidth / 750) : 1.0;

// Scaled sizes
    final buttonWidth = baseButtonWidth * scaleFactor;
    final fontSize = baseFontSize * scaleFactor;
    final titleFontSize = baseTitleFontSize * scaleFactor;
    final iconSizeLarge = baseIconSizeLarge * scaleFactor;


    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Future<void> launchEmail() async {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'tarashekaft@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Math Joy Practice Feedback',
          'body': 'Dear Developer,\n\n'
        }),
      );

      try {
        // Check if the device can handle the mailto URL
        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
        } else {
          // Fallback: Copy the email address to clipboard and inform the user
          await Clipboard.setData(const ClipboardData(text: 'tarashekaft@gmail.com'));
          // Show a dialog or snackbar
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'No email app found. Email address "tarashekaft@gmail.com" has been copied to your clipboard.'),
              ),
            );
          }
        }
      } catch (e) {
        // Handle any other errors
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch email: $e'),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/page1.JPEG'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3), // Adjust opacity here (0.0 to 1.0)
              BlendMode.darken, // Use BlendMode to control how the color is applied
            ),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Align(
              child: SizedBox(
                height: 10,
              ),
            ),

            Text(
              'Math Is Beautiful',
              style: TextStyle(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 44 : 26,
              ),
            ),

            const SizedBox(height: 190),

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 26,
                            vertical: 16),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 38 : 22,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MentalCalculationPage()),
                        );
                      },
                      child: const Text('Math Mental Tricks'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: buttonWidth,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 38 : 22,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NumericalBasesPage()),
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
                  icon: const Icon(Icons.data_saver_on),
                  color: Colors.limeAccent,
                  iconSize: iconSizeLarge,
                  onPressed: () {
                    showAlertDialog(context);
                  },
                ),

                const SizedBox(height: 16),

                /* Uncomment if needed
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.deepOrange),
                    iconSize: iconSizeSmall,
                    onPressed: shareApp,
                    tooltip: 'Share App',
                  ),
                  const SizedBox(height: 16),
                  */

                IconButton(
                  icon: Icon(Icons.email
                      , size: iconSizeLarge, color: Colors.deepOrange),
                  // Close icon
                  onPressed: () {
                    launchEmail();
                  },
                ),

                const SizedBox(height: 16),
              ],
            )
          ],
        ),


      ),

    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  final screenWidth = MediaQuery.of(context).size.width;
  final bool isTablet = screenWidth >= 600;
  Widget okButton = Center(
    child: ElevatedButton(
      child: Text("OK", style: TextStyle(fontSize: isTablet ? 30 : 20)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(scrollable: true,
    title: Text("\nPurpose & Audience",
        style: TextStyle(   fontSize: isTablet ? 33 : 24, color: Colors.pink)),

    content:RichText(
      text: TextSpan(
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
         style: TextStyle(   fontSize: isTablet ? 33 : 20, color: Colors.black)),

          TextSpan(text: 'Benefits of the app\n\n',
              style: TextStyle( color: Colors.pink, fontSize: isTablet ? 33 : 24)),
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
            style: TextStyle( fontSize: isTablet ? 33 : 22, color: Colors.black),
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

showAlertDialogEmptyInput(BuildContext context) {

  final screenWidth = MediaQuery.of(context).size.width;
  final bool isTablet = screenWidth >= 600;
  // Create button
  Widget okButton = Center(
    child: ElevatedButton(
      child:  Text("OK", style: TextStyle(fontSize: isTablet ? 30 : 20)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(scrollable: true,
    content:RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text:'Please fill all fields and make sure numeral bases are not greater than 10.'
              , style: TextStyle(fontSize: isTablet ? 33 : 24, color: Colors.black)),
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
  late List<GlobalKey> expansionTileNumberBase;
  late List<GlobalKey> expansionTile;
  int selected = -1;
  bool get isTablet => MediaQuery.of(context).size.width >= 600;

  List<AdvancedTile> buildItems(bool isTablet) {
    return  [

      AdvancedTile(
        title: 'Decimal numeral system\n',
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
                    fontSize: isTablet ? 32 : 26,
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
    const baseIconSize = 44.0;
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
                    iconSize: iconSize,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const NumericalBasesPage()),
                      );
                    },
                  ),

                  IconButton(
                    icon:  const Icon(Icons.home),
                    color:Colors.white,
                    iconSize: iconSize,
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
                    iconSize: iconSize,
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
    const baseIconSize = 44.0;
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
                                color: const Color.fromARGB(255, 110, 29, 4),
                                fontSize: isTablet ? 32 : 26,
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
                                color: const Color.fromARGB(255, 110, 29, 4),
                                fontSize: isTablet ? 32 : 26,
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
                                color: const Color.fromARGB(255, 110, 29, 4),
                                fontSize: isTablet ? 32 : 26,
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




/////////////////////////////////////////////////////////////// ChangeNotifier model for Timer class (methods)
// This model is used in main codes using provider + consumer, and in timer box using context.read

class MyModel with ChangeNotifier {
  Timer? countUpTimer;
  Duration myDuration = const Duration(days: 5);
  List<bool> timerSelected = [false];
  List<bool> timerStartIsPressed = [false];
  String timerTextStartBtn = 'start';
  Color timerButtonColor = Colors.green;
  bool timerRunning = false;

  String strDigits(int n) => n.toString().padLeft(2, '0');

  String get days => strDigits(myDuration.inDays);

  String get hours => strDigits(myDuration.inHours.remainder(24));

  String get minutes => strDigits(myDuration.inMinutes.remainder(60));

  String get seconds => strDigits(myDuration.inSeconds.remainder(60));

  String get timeValue => (int.parse(hours) > 0)
      ? '$hours:$minutes:$seconds'
      : '$minutes:$seconds';

  /// Timer related methods ///
  void startTimer() {
    countUpTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountUp());
    timerButtonColor = Colors.purple;
    timerTextStartBtn = 'stop';
    timerRunning = true;
    timerStartIsPressed[0] = true;
    notifyListeners();
  }

  void stopTimer() {
    countUpTimer?.cancel();
    timerButtonColor = Colors.red;
    timerTextStartBtn = 'resume';
    timerRunning = false;
    timerStartIsPressed[0] = false;
    notifyListeners();
  }

  void resetTimer() {
    myDuration = const Duration(days: 5);
    stopTimer();
    timerButtonColor = Colors.green;
    timerTextStartBtn = 'start';
    timerRunning = false;
    timerStartIsPressed[0] = false;
    notifyListeners();
  }


  void setCountUp() {
    const increaseSecondsBy = 1;
    myDuration += const Duration(seconds: increaseSecondsBy);
    notifyListeners();
  }
}


/////////////////////////////////////////////////////////////////// Timer box class (layouts)

/*
class TimerModel extends ChangeNotifier {
  List<bool> timerSelected = [true];
  bool timerRunning = false;
  List<bool> timerStartIsPressed = [false];

  Color timerButtonColor = Colors.grey;
  String timerTextStartBtn = "Start";
  String timeValue = "00:00";

  void toggleTimerSelected() {
    timerSelected[0] = !timerSelected[0];
    notifyListeners();
  }

  void startTimer() {
    timerRunning = true;
    timerTextStartBtn = "Stop";
    timerButtonColor = Colors.green;
    timerStartIsPressed[0] = true;
    notifyListeners();
  }

  void stopTimer() {
    timerRunning = false;
    timerTextStartBtn = "Start";
    timerButtonColor = Colors.grey;
    timerStartIsPressed[0] = false;
    notifyListeners();
  }

  void resetTimer() {
    timeValue = "00:00";
    notifyListeners();
  }
}

class TimerBox extends StatelessWidget {
  final Function(bool?) timerChanged;

  const TimerBox({Key? key, required this.timerChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<TimerModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;
    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 0, 14),
      body: SizedBox(
        height: isTablet ? 55.0 : 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TIMER TOGGLE
            SizedBox(
              child: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 50, 87, 86),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ToggleButtons(
                  isSelected: timerModel.timerSelected,
                  onPressed: (int index) {
                    timerModel.toggleTimerSelected();
                    timerChanged(timerModel.timerSelected[0]);
                  },
                  borderRadius: BorderRadius.all(Radius.circular(5 * scaleFactor)),
                  selectedColor: Colors.red,
                  fillColor: Colors.lightBlueAccent,
                  color: Colors.red,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(4 * scaleFactor, 0, 4 * scaleFactor, 0),
                      child: Text(
                        '   Timer   ',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0 * scaleFactor),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // TIMER START/STOP BUTTON
            SizedBox(
              child: Center(
                child: ToggleButtons(
                  isSelected: timerModel.timerStartIsPressed,
                  onPressed: (int index) {
                    if (timerModel.timerSelected[0]) {
                      if (timerModel.timerRunning) {
                        timerModel.stopTimer();
                      } else {
                        timerModel.startTimer();
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            "Timer Required",
                            style: TextStyle(fontSize: 18 * scaleFactor),
                          ),
                          content: Text(
                            "If you want to capture time for each practice, turn on the timer.",
                            style: TextStyle(fontSize: 16 * scaleFactor),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK", style: TextStyle(fontSize: 16 * scaleFactor)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.all(Radius.circular(8 * scaleFactor)),
                  selectedColor: Colors.grey,
                  color: Colors.white70,
                  children: [
                    Container(
                      width: screenWidth / (isTablet ? 6 : 4),
                      height: 30 * scaleFactor,
                      decoration: BoxDecoration(
                        color: timerModel.timerButtonColor,
                        borderRadius: BorderRadius.circular(8 * scaleFactor),
                      ),
                      child: Center(
                        child: Text(
                          timerModel.timerTextStartBtn,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0 * scaleFactor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // RESET ICON
            IconButton(
              icon: Icon(Icons.rotate_left, color: Colors.white70, size: 24 * scaleFactor),
              onPressed: () {
                timerModel.resetTimer();
              },
            ),

            // TIME DISPLAY
            SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  timerModel.timeValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * scaleFactor,
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
*/



class TimerBox extends StatefulWidget with ChangeNotifier{
  TimerBox({super.key, required this.timerChanged,
  });
  //  TimerBox({super.key, required this.timerChanged});
  final Function(bool?) timerChanged;
  List<bool> timerSelected = <bool>[true];

  get timerSelected_ => timerSelected;


  @override
  _TimerBoxState createState() => _TimerBoxState();
}


class _TimerBoxState extends State<TimerBox> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // since we don't access to MyModel context we should use context.read:
    final myModel = Provider.of<MyModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;
    double scaleFactor = isTablet ? (screenWidth / 850) : 1.0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 0, 14 ),
      body: SizedBox( height: isTablet ? 55.0 : 30,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TIMER TOGGLE
            SizedBox(
              child: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 50, 87, 86),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ToggleButtons(
                  isSelected: myModel.timerSelected,
                  onPressed: (int index) {
                    setState(() {
                      myModel.timerSelected[0] = !myModel.timerSelected[0];
                      widget.timerChanged(myModel.timerSelected[0]);
                    });
                  },
                  borderRadius: BorderRadius.all(Radius.circular(5 * scaleFactor)),
                  selectedColor: Colors.red,
                  fillColor: Colors.lightBlueAccent,
                  color: Colors.red,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          4 * scaleFactor, 0, 4 * scaleFactor, 0),
                      child: Text(
                        '   Timer   ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0 * scaleFactor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // TIMER START/STOP BUTTON
            SizedBox(
              child: Center(
                child: ToggleButtons(
                  isSelected: myModel.timerStartIsPressed,
                  onPressed: (int index) {
                    if (myModel.timerSelected[0]) {
                      if (myModel.timerRunning) {
                        myModel.stopTimer();
                      } else {
                        myModel.startTimer();
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Timer Required",
                              style: TextStyle(fontSize: 18 * scaleFactor),
                            ),
                            content: Text(
                              "If you want to capture time for each practice, turn on the timer.",
                              style: TextStyle(fontSize: 16 * scaleFactor),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK", style: TextStyle(fontSize: 16 * scaleFactor)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  borderRadius: BorderRadius.all(Radius.circular(8 * scaleFactor)),
                  selectedColor: Colors.grey,
                  color: Colors.white70,
                  children: [
                    Container(
                      width: screenWidth / (isTablet ? 6 : 4),
                      height: 30 * scaleFactor,
                      decoration: BoxDecoration(
                        color: myModel.timerButtonColor,
                        borderRadius: BorderRadius.circular(8 * scaleFactor),
                      ),
                      child: Center(
                        child: Text(
                          myModel.timerTextStartBtn,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0 * scaleFactor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // RESET ICON
            IconButton(
              icon: Icon(Icons.rotate_left, color: Colors.white70, size: 24 * scaleFactor),
              onPressed: () {
                myModel.resetTimer();
              },
            ),

            // TIME DISPLAY
            SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  myModel.timeValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * scaleFactor,
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
