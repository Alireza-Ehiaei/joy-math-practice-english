
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_keyboard.dart';
import 'main.dart';

//////////////////////////////////////////////////////////// Mental calculation page

class Mental_calculation_page extends StatelessWidget {
  const Mental_calculation_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints:  BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back4.JPEG'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Adjust opacity here (0.0 to 1.0)
              BlendMode.darken, // Use BlendMode to control how the color is applied
            ),
          ),
        ),


        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              Center( // Centers the content horizontally and vertically
                child: Container(
                  width: 280, // Adjust the width of the window
                  padding: const EdgeInsets.all(16.0), // Add padding around the text

                  child: Container(
                    padding: const EdgeInsets.all(8.0), // Optional: Add padding for better visual appearance
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(120, 66, 4, 4), // Transparent background color (adjust the alpha value as needed)
                      borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
                    ),
                    child: const Text(
                      "Mathematics fosters the abilities of logical argumentation, "
                          "problem-solving, innovation, abstract thinking, and critical thinking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ),
              ),

              const SizedBox(
                height: 70,
              ),

              SizedBox(
                width: 300, // Same width for all buttons
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 129, 3, 32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Mental_calculation_explain_page()),
                    );
                  },
                  child: const Text('Basic Arithmetic'),
                ),
              ),


              const Align(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SizedBox(
                width: 300, // Same width for all buttons
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 129, 3, 32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Mental_calculation_practice_page()),
                    );
                  },
                  child: const Text('Practice'),
                ),
              ),

           Spacer(),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon:  const Icon(Icons.keyboard_return),
                  color:Colors.red,
                  iconSize: 38,
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}






/////////////////////////////////////////:://////////////////////////// Mental calculation explain page

class AdvancedTile_mental {
  final String title;
  final Widget body;
  AdvancedTile_mental({required this.title, required this.body  });
}

class Mental_calculation_explain_page extends StatefulWidget {
  @override
  State<Mental_calculation_explain_page> createState() => _Mental_calculation_explain_page();
}

class _Mental_calculation_explain_page extends State<Mental_calculation_explain_page>
    with TickerProviderStateMixin {
  late List<GlobalKey> expansionTile;
  int selected = -1;
  final List<AdvancedTile_mental> items = [

    AdvancedTile_mental(
      title: '+',
      body:  Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 228, 204),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Mental addition tricks\n\n ', style: TextStyle(fontWeight: FontWeight.bold, 
                  color: Colors.pink, fontSize: 28)),
              TextSpan(text: 'Addition in smaller parts\n ', style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text:   "📌 Break numbers into smaller, more manageable parts for easier mental calculation. "
                    "Add from left to right, unlike traditional written addition.\n\n"

                    "🧩 Example 1: 281 + 610 = (600 + 200) + (81 + 10) = 800 + 91 = 891\n\n"

                    "🧩 Example 2: 386 + 5492 = (5400 + 300) + (90 + 80) + (6 + 2) = 5700 + 176 = 5876\n\n"

                    "💡 Tip: Don't always group by place value! Create simpler sums with easier-to-add numbers (e.g., 5400 + 300).\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


              TextSpan(text: 'Round the numbers\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Round numbers to the nearest ten, hundred, or thousand to simplify the addition. Remember to adjust the final result.\n\n"

                    "🧩 Example 1: 792 + 260 = (792 + 8) + 260 - 8 = 800 + 260 - 8 = 1060 - 8 = 1052\n\n"

                    "🧩 Example 2: 27 + 9 = 27 + 10 - 1 = 37 - 1 = 36\n\n"

                    "🧩 Example 3: 267 + 99 = 267 + 100 - 1 = 367 - 1 = 366\n\n"

                    "💡 Tip: For adding 8, add 10 and subtract 2. Create similar tricks for other numbers!\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Begin with simpler sums\n ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                      255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 When adding multiple numbers, look for pairs or groups that are easy to add together. Rearrange the numbers to create simpler sums.\n\n"

                    "🧩 Example: 61 + 17 + 4 + 19 + 13 + 16 = (4 + 16) + (13 + 17) + (19 + 61) = 20 + 30 + 80 = 130\n\n"

                    "💡 Tip: Look for numbers that add up to 10, 20, 50, or 100 for quicker mental calculations.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(
                text: 'Simplify Addition by Ignoring Zeros\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 220, 29, 4),
                  fontSize: 26,
                ),
              ),

              TextSpan(
                text: "📌 Technique: If all numbers in a sum end with zeros, ignore an equal number of zeros from each number and add the remaining digits. Then, restore the ignored zeros to the end of the answer.\n\n"

                    "🧩 Example 1: 280 + 3600 = (28 + 360) with one zero removed = 388. Add the zero back: 3880\n\n"

                    "🧩 Example 2: 4300 + 72300 = (43 + 723) with two zeros removed = 766. Add the two zeros back: 76600\n\n"

                    "💡 Tip: This technique works best when all numbers have at least one zero at the end.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )



            ],
          ),
        ),
      ),
    ),

    AdvancedTile_mental(
      title: '-',
      body:  Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 228, 204),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Mental subtraction tricks\n\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 28)),
              TextSpan(text: 'Subtraction using addition\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Turn subtraction into an addition problem. Ask: \"What number, when added to the smaller number, equals the larger number?\"\n\n"

                    "🧩 Example 1: 18 - 13. Think: \"13 + ? = 18.\" Answer: 5\n\n"

                    "🧩 Example 2: 83 - 45. Think: \"45 + ? = 83.\" Answer: 38\n\n"

                    "❗ Handling Negative Numbers: If subtracting from a smaller number, the answer is negative. For 18 - 22, think: \"What added to 22 equals 18?\". Answer 4. Then add the negative sign to get -4.\n\n"

                    "💡 Tip: The order doesn't matter! 18 - 22 = -4 = -22 + 18.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


              TextSpan(
                text: 'Subtraction in Smaller Parts\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 220, 29, 4),
                  fontSize: 26,
                ),
              ),

              TextSpan(
                text: "📌 Break the subtraction into smaller, more manageable parts, then combine the results.\n\n"

                    "🧩 Example 1: 495 - 181 = (400 - 100) + (95 - 81) = 300 + 14 = 314\n\n"

                    "🧩 Example 2: 777 - 388 = (700 - 300) + (77 - 88) = 400 + (-11) = 389\n\n"

                    "💡 Practice and identify the most effective approach for each problem.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )

              ,

              TextSpan(text: 'Round *Before* You Subtract!\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Round numbers before subtracting, then adjust the result by adding back what you subtracted (or subtracting what you added) to round.\n\n"

                    "🧩 Example: 654 - 230 = 654 - 300 + 70 = 354 + 70 = 424 (We added 70 to 230, so add it back).\n\n"

                    "💡 Another way: 654 - 230 = 630 - 230 + 24 = 400 + 24 = 424 (We subtracted 24 from 654, so add it back).\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Ignoring trailing Zeros', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 If both numbers end in zeros, remove the same number of zeros, subtract, then add the zeros back to the result.\n\n"

                    "🧩 Example 1: 9300 - 500 = 93 - 5 (remove two zeros) = 88. Add two zeros: 8800\n\n"

                    "🧩 Example 2: 800 - 350 = 80 - 35 (remove one zero) = 45. Add one zero: 450\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )

              ,
            ],
          ),
        ),
      ),
    ),

    AdvancedTile_mental(
      title: 'x',
      body:  Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 228, 204),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Mental multiplication tricks\n\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 28)),
              TextSpan(text: 'What is multiplication?\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 100, 29, 4), fontSize: 26)),

              TextSpan(
                text: "💡 Multiplication: Repeated Addition Made Easy!\n\n"

                    "📌 Multiplication simplifies repeated addition (e.g., 4 x 5 is like adding 4 five times).\n\n"

                    "❗ Multiplying by 1 gives the same number (e.g., 7 x 1 = 7).\n\n"

                    "❗ Multiplying by 0 always gives zero (e.g., 7 x 0 = 0).\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),


              TextSpan(text: 'Ignoring trailing zeros\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),
              TextSpan(
                text: "📌 For numbers ending in zeros, multiply the non-zero parts, then add back the zeros.\n\n"

                    "🧩 Example 1: 60 x 400 = 6 x 4 (remove three zeros) = 24. Add three zeros: 24000\n\n"

                    "🧩 Example 2: 1200 x 30 = 12 x 3 (remove three zeros) = 36. Add three zeros: 36000\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Multiplication in smaller parts\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text:
                    "📌 To calculate 7 x 84, mentally compute 7 x 80 and 7 x 4 separately, then add the results: 560 + 28 = 588. \n\n"

                    "🧩 To solve 8 x 317, break it down into three simpler multiplications: 8 x 300, 8 x 10, and 8 x 7, then sum the results: 2400 + 80 + 56 = 2536. \n\n"

                    "🧩 To find 67% of 1400, note that 10% of 1400 is 140, so 60% is 140 x 6 = 840. "
                    "Similarly, 1% of 1400 is 14, so 7% is 14 x 7 = 98. Therefore, 67% of 1400 equals 840 + 98 = 938."
                    " Also you could deduct 3% of 1400 from 70% of it to get the result. Later in division tricks it is mentioned that 67% of 1400 is "
                    "equal to 67 of 14 that makes multiplication simpler.\n\n"

                    "📌 What is 1.1% of a number? It is the sum of 1% of that number and 0.1% of that number. \n\n"

                    "🧩 For example: What is 1.1% of 2300? Since 10% of 2300 is 230, then 1% is 23, and 0.1% is 2.3. Because 1.1% = 1% + 0.1%, we have 1.1% of 2300 = 23 + 2.3 = 25.3.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Multiplying a number by five\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Multiplying by 5 (Even Numbers): Divide the number by 2, then multiply by 10.\n\n"

                    "🧩 Example: 3846 x 5:  (3846 / 2) = 1923.  Then, 1923 x 10 = 19230.\n\n"

                    "📌 Multiplying by 5 (Odd Numbers): Subtract 1 from the number, divide by 2, add 0.5, then multiply by 10.\n\n"

                    "🧩 Example: 5 x 37: (37 - 1) = 36.  Then, (36 / 2) = 18. Add 0.5: 18 + 0.5 = 18.5. Finally, 18.5 x 10 = 185.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Using rounded numbers\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Round and Multiply: Round one number, multiply, then adjust for the rounding.\n\n"

                    "🧩 Example (Adding to Round): 8 x 76: Round 76 to 80. 8 x 80 = 640. We added 4 to 76, so subtract (8 x 4) = 32 from 640: 640 - 32 = 608. Therefore, 8 x 76 = 608.\n\n"

                    "📌 Multiplying by Breaking Down: Divide multiplication into smaller parts and summing the results.\n\n"

                    "🧩 Example (Breaking Down) Calculate 92 x 13 by computing 92 x 10 = 920 and 92 x 3 = 276 separately, then add: 920 + 276 = 1196.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Shifting the percentage\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Moving the Percent: In multiplication, you can transfer the percent sign between numbers to simplify calculations.\n\n"

                    "🧩 Example 1: 25 x 7% is the same as 7 x 25%. Since 25% is one-quarter, this is (1/4) x 7 = 1.75.\n\n"

                    "📌 When Shifting Doesn't Simplify: If moving the percent doesn't make the problem easier, "
                    "use other techniques.\n\n"

                    "🧩 Example 2: 23 x 7%: Moving the percent doesn't simplify this directly.  "
                    "Instead, calculate 25 x 7% (which we know is 1.75).  Then, subtract 2 x 7% or 2% of 7 from 1.75. "
                    "Since 1% of 7 is 0.07, then 2% of 7 is 0.14. Therefore, 23 x 7% = 1.75 - 0.14 = 1.61.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Rearranging Numerators in Fractional Multiplication\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Fractional Multiplication: When multiplying with fractions, the factors in the numerator can be rearranged, i.e., a x (b ÷ c) = b x (a ÷ c). This can sometimes simplify the calculation.\n\n"

                    "🧩 Example 1: (14 ÷ 50) x 5 can be rewritten as 14 x (5 ÷ 50), which is the same as 14 x 0.1 = 1.4.\n\n"

                    "🧩 Example 2: What is (3 ÷ 100) x 555? This can be expressed as 3 x (555 ÷ 100), or 3 x 5.55. This equals (3 x 5) + (3 x 0.55) = 15 + 1.65 = 16.65.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(
                text:

                    "📌 Multiplying by 9 (Algebraic Method) [2]: Rewrite 9 as (10 - 1). Then distribute. For example, 17 x 9 becomes 17 x (10 - 1) = (17 x 10) - (17 x 1).\n\n"

                    "🧩 Example: 17 x 9 = 17 x (10 - 1) = (17 x 10) - (17 x 1) = 170 - 17 = 153 [2].\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),

              TextSpan(text: 'Other multiplication tricks\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(text:
              " Explore More Multiplication Tricks: Search online for techniques like multiplying three-digit numbers by "
                  "11 or multiplying numbers by 9. You can also develop your own mental calculation methods! For example, \n\n"

              "📌 Multiplying by 9 (Finger Trick) [1]: Place both hands in front of you with fingers extended. To multiply 9 by a number (1-10), count from the left and fold down that number finger [1]. The fingers to the left of the folded finger represent the tens digit, and the fingers to the right represent the ones digit [1].\n\n"

                  "🧩 Example: 9 x 4: Fold down the fourth finger from the left [1]. You have 3 fingers to the left (30) and 6 fingers to the right (6), so 9 x 4 = 36 [1].\n\n"

                  "📌 Multiplying by 11 (Two-Digit Numbers) [1]: To multiply a two-digit number by 11, imagine a space between the two digits [1]. Then, add the two digits together [1]. Place that sum in the space [1].\n\n"

                  "🧩 Example: 23 x 11: Imagine 2 [_] 3. 2 + 3 = 5. Place the 5 in the space: 253 [1]. So, 23 x 11 = 253 [1].\n\n"

                  "📌 Multiplying by 4 (Double-Double) [1]: Double the number you're multiplying by 4, then double the result [1].\n\n"

                  "🧩 Example: 4 x 6: Double 6 to get 12 [1]. Double 12 to get 24 [1]. Therefore, 4 x 6 = 24 [1].\n\n"

                  , style: TextStyle( fontSize: 25, color: Colors.black)),

            ],
          ),
        ),
      ),
    ),

    AdvancedTile_mental(
      title: '÷',
      body:  Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 228, 204),
          //     border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Mental division tricks\n\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 28)),
              TextSpan(text: 'What is division?\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 110, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Dividing a number (the dividend) by another number (the divisor) is like counting how many times you can subtract the divisor from the dividend (and subsequent remainders) until you can't subtract anymore.\n\n"

                    "🧩 21 divided by 5: How many groups of 5 are in 21?  Subtract 5 from 21 (leaving 16), then subtract 5 from 16 (leaving 11), then 5 from 11 (leaving 6), then 5 from 6 (leaving 1). We subtracted 4 times, with a remainder of 1.  So, 21 divided by 5 equals 4 (the quotient).\n\n"

                    "📌 Division as Simplified Subtraction: Division simplifies repeated subtraction. In this section, we will explore some mental division tricks.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Ignoring trailing Zeros equally and restoring them at the end\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Dividing Numbers Ending in Zeros: If both the dividend and divisor end in zeros, you can ignore an equal number of trailing zeros in both numbers before dividing. There's no need to add zeros back to the result.\n\n"

                    "🧩 78000 ÷ 2000: Both numbers have three trailing zeros. Remove them: 78 ÷ 2 = 39. So, 78000 ÷ 2000 = 39.\n\n"

                    "🧩 3500 ÷ 50: Both numbers have at least one trailing zero. Remove one zero from each: 350 ÷ 5 = 70. The second zero in 3500 cannot be removed because there is no corresponding zero in the 50. Therefore, 3500 ÷ 50 = 70.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Division with subtraction\n ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Division as Repeated Subtraction (Recap): As mentioned earlier, dividing one number (the dividend) by another (the divisor) is equivalent to repeatedly subtracting the divisor from the dividend (and subsequent results) until the remaining value is less than the divisor. This final value is the remainder.\n\n"

                    "🧩 37 ÷ 11: The subtractions are 37 - 11 = 26, 26 - 11 = 15, and 15 - 11 = 4. We can't subtract 11 from 4. Since we subtracted three times, the quotient is 3, and the remainder is 4.\n\n"

                    "🧩 129 ÷ 38: The subtractions are 129 - 38 = 91, 91 - 38 = 53, and 53 - 38 = 15. We subtracted three times, so the quotient is 3, and the remainder is 15.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Simplifying division\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Simplifying Division Before Calculating: Check if you can simplify the dividend and divisor by dividing both by a common factor before performing the division. This can make the calculation easier.\n\n"

                    "🧩 68 ÷ 28: Divide both numbers by 2 to get 34 ÷ 14. There are two 14s in 34 (2 x 14 = 28), with a remainder of 6. So, the quotient of 68 ÷ 28 is 2. The remainder is (6 x 2) = 12, because we divided both original numbers by 2 initially.\n\n"

                    "🧩 4000 ÷ 1600: Remove two zeros from each number: 40 ÷ 16. Divide both by 8: 5 ÷ 2. The quotient is 2, with a remainder of 1. To find the original remainder, multiply by the factors we divided by: (1 x 8 x 100) = 800. Therefore, the quotient of 4000 ÷ 1600 is 2, and the remainder is 800.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Division into smaller parts\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Dividing into Smaller Parts (Dividend): You can sometimes simplify division by breaking the dividend into a sum of numbers that are easily divisible by the divisor. \n\n"

                    "🧩 78 ÷ 3: Rewrite 78 as 60 + 18. Then, 78 ÷ 3 = (60 ÷ 3) + (18 ÷ 3) = 20 + 6 = 26.\n\n"

                    "📌 Dividing into Smaller Parts (Divisor): If the divisor can be factored into two numbers, you can divide the dividend by one factor and then divide the result by the other factor.\n\n"

                    "🧩 126 ÷ 18: Factor 18 into 6 x 3. First, divide 126 by 3 to get 42. Then, divide 42 by 6 to get 7. Therefore, 126 ÷ 18 = 7.\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              )
              ,

              TextSpan(text: 'Division with multiplication\n', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(
                  255, 220, 29, 4), fontSize: 26)),

              TextSpan(
                text: "📌 Division as Multiplication by the Inverse: Dividing by a number is the same as multiplying by its inverse. For example, 5 divided by 0.25 (which is 25/100) is the same as 5 multiplied by 100/25, which equals 5 x 4 = 20.\n\n"

                    "🧩 Dividing by 5: Since 10 ÷ 2 = 5, dividing by 5 is the same as multiplying by 2/10 (the inverse of 5). This means you can multiply by 2 and then divide by 10. So, 85 ÷ 5 can be calculated as (85 x 2) ÷ 10 = 170 ÷ 10 = 17.\n\n"

                    "🧩 Dividing by 25: Since 100 ÷ 4 = 25, dividing by 25 is the same as multiplying by 4/100 (the inverse of 25). So, 235 ÷ 25 can be calculated as (235 x 4) ÷ 100 = 940 ÷ 100 = 9.4\n\n"

                    "🧩 Applying This: Based on these methods, how would you divide a number by 20 or 50?\n\n",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState(){
    super.initState();
    // Generating key for each item of items list
    expansionTile = List<GlobalKey<_Mental_calculation_explain_page>>.generate(items.length, (index) => GlobalKey());
  }

  void _changeFontSize(double fontSize) {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(

            image: DecorationImage(
            image: AssetImage('assets/images/back3.JPEG'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3), // Adjust opacity here (0.0 to 1.0)
          BlendMode.darken, // Use BlendMode to control how the color is applied
        ),
      ),
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
                                        topLeft:   Radius.circular(25),
                                        bottomRight: Radius.zero,
                                        topRight:Radius.zero
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
                                  title: Text(
                                    items[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:  selected==-1 ? 30:21,// size of icons +, -...

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
                    iconSize: 37,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Mental_calculation_page()),
                      );
                    },
                  ),

                  IconButton(
                    icon:  const Icon(Icons.home),
                    color:Colors.white,
                    iconSize: 37,
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

                                    // 1. Art of Memory
                                    TextSpan(
                                      text: '\nArt of Memory - Mental Math\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://artofmemory.com/blog/category/mental-math/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 2. Mathigon
                                    TextSpan(
                                      text: '\nMathigon - Mental Math\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://mathigon.org/mental-math');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 3. Cut-the-Knot
                                    TextSpan(
                                      text: '\nCut-the-Knot - Mental Math\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://www.cut-the-knot.org/arithmetic/mental/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 4. Brilliant
                                    TextSpan(
                                      text: '\nBrilliant - Mental Math Course\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://brilliant.org/courses/mental-math/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 5. Vedic Maths Academy
                                    TextSpan(
                                      text: '\nVEDIC Maths Academy\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://www.vedicmaths.org/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 6. Ofpad Math Tricks
                                    TextSpan(
                                      text: '\nMath Tricks - Ofpad\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://ofpad.com/math-tricks/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 7. Numberphile
                                    TextSpan(
                                      text: '\nNumberphile - Math Tricks\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://www.numberphile.com/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 8. Math Shortcut Tricks
                                    TextSpan(
                                      text: '\nMath Shortcut Tricks\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://www.math-shortcut-tricks.com/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 9. QuickMathTricks
                                    TextSpan(
                                      text: '\nQuickMathTricks\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://quickmathtricks.com/');
                                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to open link')),
                                            );
                                          }
                                        },
                                    ),

                                    // 10. Khan Academy Arithmetic
                                    TextSpan(
                                      text: '\nKhan Academy - Arithmetic\n\n',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse('https://www.khanacademy.org/math/arithmetic');
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


///////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////:://////////////////////////// Mental_calculation_practice_page
class Mental_calculation_practice_page extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Mental_calculation_practice_page> {
  final  ValueNotifier<int> notification_operationindex = ValueNotifier(-1); // <type> variable= initialisation
  final  ValueNotifier<List<String>> notificationlist = ValueNotifier(<String>[]);
  final  ValueNotifier<String> notificationtext = ValueNotifier("");
  final  ValueNotifier<int> notificationcolor = ValueNotifier(2); // for changing answer text-field color
  final  ValueNotifier<int> notificationcolor_remainder = ValueNotifier(2);
  bool _visible = false;
  bool calculator_visible = false;
  final FocusNode _focus_answer = FocusNode();
  final FocusNode _focus_answer_remainder = FocusNode();
  final FocusNode _focus_minimum = FocusNode();
  final FocusNode _focus_maximum = FocusNode();
  final FocusNode _focus_first_number = FocusNode();
  final FocusNode _focus_second_number = FocusNode();

  final TextEditingController _controller_answer = TextEditingController();
  final TextEditingController _controller_minimum = TextEditingController();
  final TextEditingController _controller_answer_remainder = TextEditingController();
  final TextEditingController _controller_maximum = TextEditingController();
  TextEditingController _controller_calc = TextEditingController();
  final TextEditingController _controller_first_number = TextEditingController(text: "");
  final TextEditingController _controller_second_number = TextEditingController(text: "");
  final List<bool> _selectedmathoperation = <bool>[false, false, false, true];


  int first_number =0;
  int second_number =0;
  String first_number_text ="";
  String second_number_text ="";
  String user_answer_text ="";
  String _answer_text1 ="";
  String _answer_text_remainder ="";
  List<String> dig =[];
  List<String> n_base_expand = [];
  List<String> remainder_answer = [];
  bool timer_enabled= false;
  int id = 2;
  String correct_answer = "4";
  String max_ = "1";
  Parser p=Parser();
  final List<bool> timer_box = <bool>[false];
  late bool timer_visible = false;
  static const List<Widget> math_oper = <Widget>[
    Text('Division'),
    Text('Multiplication'),
    Text('Subtraction'),
    Text('Addition'),
  ];
  int index = -1;

  final List<bool> random_interval_box = <bool>[false];
  late bool random_interval_visible = false;

  get digit1 => null;


  calculator_textfield_focus_(calculatorFocused) {
    setState(() {
      // if calculator_focused is focused _calculateor_textfield_focus will be true and
      // gets text of buttons
});
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
    _focus_answer.addListener(_onFocusChange);
    _focus_minimum.addListener(_onFocusChange);
    _focus_maximum.addListener(_onFocusChange);
    _focus_first_number.addListener(_onFocusChange);
    _focus_second_number.addListener(_onFocusChange);
    _focus_answer_remainder.addListener(_onFocusChange);

    first_number = (randomNumber(20, 200));
    second_number = (randomNumber(6, first_number-1));

    _controller_first_number.text = (first_number.toString());
    _controller_second_number.text = (second_number.toString());

    notification_operationindex.value = 3;

    super.initState();
  }

  @override
  void dispose() {
    _focus_first_number.removeListener(_onFocusChange);
    _focus_second_number.removeListener(_onFocusChange);
    _focus_answer.removeListener(_onFocusChange);
    _focus_minimum.removeListener(_onFocusChange);
    _focus_maximum.removeListener(_onFocusChange);

    _focus_first_number.dispose();
    _focus_second_number.dispose();
    _controller_answer.dispose();
    _controller_minimum.dispose();
    _controller_maximum.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    debugPrint("_focus_first_number.hasFocus ${_focus_first_number.hasFocus}");
    debugPrint("_focus_second_number.hasFocus ${_focus_second_number.hasFocus}");
    debugPrint("_focus_answer.hasFocus ${_focus_answer.hasFocus}");
    debugPrint("_focus_minimum.hasFocus ${_focus_minimum.hasFocus}");
    debugPrint("_focus_maximum.hasFocus ${_focus_maximum.hasFocus}");
    debugPrint("_focus_answer_remainder.hasFocus ${_focus_minimum.hasFocus}");

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
  List<bool> random_interval = <bool>[false];

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    final screenWidth = MediaQuery.of(context).size.width;
    return MultiProvider(

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
                    const SizedBox(height: 30),

                    SizedBox(height: 30,
                      child: Row(
                        children: [
                          IconButton(
                            icon:  const Icon(Icons.keyboard_return),
                            color:Colors.purple,
                            iconSize: 30,
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Mental_calculation_page()),
                              );
                            },
                          ),

                          IconButton(
                            icon:  const Icon(Icons.home),
                            color:Colors.purple,
                            iconSize: 30,
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
                                              text: "🧩 For a new exercise, press the One of the buttons  "
                                                  "\"Addition\", \"Subtraction\", \"Multiplication\" or \"Division\" and "
                                                  "answer based on the generated random numbers.\n\n",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "✅ To check if your answer is correct, press the \"Check\" button."
                                                  " To see the correct answer, press the \"Answer\" button.\n\n",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),

                                            TextSpan(
                                              text: "⏱️ Tap the clock icon in the top right corner to activate the timer. "
                                                  "The timer automatically resets each time you start a new practice, "
                                                  "displaying the time passed. Use the controls to manually stop, resume, "
                                                  "or reset the timer as needed.",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "🔢 A random number between 1 and 100 will be generated for each new practice. "
                                                  "If you want more challenging exercises, adjust the minimum and maximum values by "
                                                  "clicking on the icon next to ⏱️.\n\n",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "🛠️ You can change the given random numbers manually and "
                                                  "answer questions based on your custom inputs.\n\n",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),

                                            TextSpan(
                                              text: "⚙️ You can close the timer and random number range windows "
                                                  "without losing your settings to make the screen more readable. However, "
                                                  "if you close the app, your settings will be reset.\n\n",
                                              style: TextStyle(fontSize: 20, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "🎓 When you're first learning, it's not necessary to use a"
                                                  " timer. Once you're comfortable with the concepts, you can use "
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

                    const SizedBox(height: 5,),

                    Consumer<MyModel>( //            <--- MyModel Consumer
                        builder: (context, myModel, child) {
                          return Visibility(visible: timer_visible,
                            child : SizedBox(height: 30,
                                child: Timerbox(timer_changed: timer_CallBack)),
                          );}
                    ),

                    const SizedBox(height: 2,),

                    Visibility(visible: random_interval_visible,
                      child : SizedBox(height: 28,
                        child: Row(
                          children: [

                            Container( //  '  عدد تصادفی for
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255,50, 87, 86),
                                //     border: Border.all(color: Colors.black, width: 1.0),
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
                                //  selectedBorderColor: Colors.red,
                                selectedColor: Colors.red,
                                fillColor: Colors.lightBlueAccent,
                                color: Colors.red,
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                                    child: Text('random number',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70,
                                        fontSize: 16,// double
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Flexible(
                              child:  TextField(focusNode: _focus_minimum,
                                readOnly: true, showCursor: true,   cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
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
                              child:  TextField(focusNode: _focus_maximum,
                                readOnly: true, showCursor: true,  cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                textAlign: TextAlign.left,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),
                    const Text('Try to answer the following exercises mentally',
                      style: TextStyle(
                        color: Colors.white,
                        //   fontWeight: FontWeight.bold,
                        fontSize: 16,// double

                      ),
                    ),
                    const SizedBox(height: 5,),

                    SizedBox(
                      width: screenWidth,
                      child: Consumer<MyModel>(
                        builder: (context, myModel, child) {
                          return Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 51, 117, 115),
                              border: Border.all(color: Colors.black, width: 1.0),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final buttonWidth = (screenWidth ) / 4.5;

                                  return ToggleButtons(
                                    direction: Axis.horizontal,
                                    onPressed: (index) {
                                      myModel.timer_selected[0]
                                          ? () {
                                        myModel.resetTimer();
                                        myModel.startTimer();
                                        myModel.timerTextStartBtn = 'stop';

                                        setState(() {
                                          for (int buttonIndex = 0;
                                          buttonIndex < _selectedmathoperation.length;
                                          buttonIndex++) {
                                            _selectedmathoperation[buttonIndex] =
                                            (buttonIndex == index);
                                          }

                                          notification_operationindex.value = index;
                                          notificationtext.value = "";
                                          notificationlist.value = [];
                                          notificationcolor.value = 3;
                                          notificationcolor_remainder.value = 3;
                                          myModel.timer_start_ispressed[0] = true;
                                        });
                                      }()
                                          : () {
                                        setState(() {
                                          for (int buttonIndex = 0;
                                          buttonIndex < _selectedmathoperation.length;
                                          buttonIndex++) {
                                            _selectedmathoperation[buttonIndex] =
                                            (buttonIndex == index);
                                          }

                                          notification_operationindex.value = index;
                                          notificationtext.value = "";
                                          notificationlist.value = [];
                                          notificationcolor.value = 3;
                                          notificationcolor_remainder.value = 3;
                                        });
                                      }();

                                      _controller_answer.text = "";
                                      _controller_answer_remainder.text = "";
                                      if (random_interval[0]) {
                                        if ((_controller_minimum.text == "") ||
                                            (_controller_maximum.text == "")) {
                                          first_number = (randomNumber(20, 200));
                                          second_number = (randomNumber(6, first_number - 1));
                                        } else {
                                          first_number = (randomNumber(
                                              int.parse(number_toenglish(_controller_minimum.text)),
                                              int.parse(
                                                  number_toenglish(_controller_maximum.text))));
                                          second_number = (randomNumber(
                                              int.parse(number_toenglish(_controller_minimum.text)),
                                              first_number));
                                        }

                                        _controller_first_number.text = (first_number.toString());
                                        _controller_second_number.text =
                                        (second_number.toString());
                                      } else {
                                        first_number = (randomNumber(20, 200));
                                        second_number = (randomNumber(6, first_number - 1));

                                        _controller_first_number.text = (first_number.toString());
                                        _controller_second_number.text =
                                        (second_number.toString());
                                      }
                                    },
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    selectedColor: Colors.white,
                                    fillColor: Colors.lightBlueAccent,
                                    disabledColor: Colors.yellow[200],
                                    color: Colors.white,
                                    constraints: BoxConstraints(
                                      minHeight: 40.0,
                                      minWidth: buttonWidth,
                                    ),
                                    isSelected: _selectedmathoperation,
                                    children: math_oper,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    const SizedBox(height: 4),

                    SizedBox(height:40,
                      child: Row(
                        children:  [
                          Flexible(
                            child:  TextField(focusNode: _focus_first_number, readOnly: true, showCursor: true,
                                 cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 22, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  border : InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 221, 217, 218 ),
                                ),
                                controller: _controller_first_number,
                                onChanged: (text) {
                                  setState(() {});
                                }
                            ),
                          ),

                          const SizedBox(width: 10),

                           Text(notification_operationindex.value == 0 ?'÷' :
                           notification_operationindex.value == 2 ? '-' :
                           notification_operationindex.value == 1 ? '×' :
                             '+',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,// double

                            ),
                          ),
                          const SizedBox(width: 10),

                          Flexible(
                            child:  TextField(focusNode: _focus_second_number, readOnly: true, showCursor: true,
                                 cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 22.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  border : InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 221, 217, 218 ),
                                ),
                                controller: _controller_second_number,
                                onChanged: (text) {
                                  setState(() {});
                                }
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    SizedBox(height:40,
                      child: notification_operationindex.value != 0 ? Row(
                        children:  [

                          const Text('Answer?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,// double

                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible( child: ValueListenableBuilder<int>(valueListenable: notificationcolor,
                            builder: (context, value, widget) { return
                              TextField(focusNode: _focus_answer,
                                  readOnly: true,  cursorColor: Colors.black,
                                  showCursor: true,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(6,1,8,11),
                                    filled: true, border : InputBorder.none,
                                    fillColor:   (value== 0) ? const Color.fromARGB(255, 253, 14, 42) :
                                    (value== 1) ? const Color.fromARGB(255, 43, 163, 16) :
                                    const Color.fromARGB(255, 221, 217, 218),
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
                      )
                          :
                      Row(
                        children:  [

                          const Text('Answer?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,// double

                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible( child: ValueListenableBuilder<int>(valueListenable: notificationcolor,
                            builder: (context, value, widget) { return
                              TextField(focusNode: _focus_answer,
                                  readOnly: true,  cursorColor: Colors.black,
                                  showCursor: true,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    hintText: 'quotient',
                                    hintStyle: const TextStyle(fontSize: 18),
                                    contentPadding: const EdgeInsets.fromLTRB(6,1,8,12),
                                    filled: true, border : InputBorder.none,
                                    fillColor:   (value== 0) ? const Color.fromARGB(255, 253, 14, 42) :
                                    (value== 1) ? const Color.fromARGB(255, 43, 163, 16) :
                                    const Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_answer,
                                  onChanged: (text) {
                                    setState(() {});
                                  }
                              );
                            },
                          )
                          ),

                          const SizedBox(width: 6),

                          Flexible( child: ValueListenableBuilder<int>(valueListenable: notificationcolor_remainder,
                            builder: (context, value, widget) { return
                              TextField(focusNode: _focus_answer_remainder,
                                  readOnly: true,  cursorColor: Colors.black,
                                  showCursor: true,
                                  onTap: () {
                                    if (!_visible) {
                                      show_keboard();
                                    }
                                  },
                                  autofocus: false,
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    hintText: 'Remainder',
                                    hintStyle: const TextStyle(fontSize: 19),
                                    contentPadding: const EdgeInsets.fromLTRB(6,1,8,12),
                                    filled: true, border : InputBorder.none,
                                    fillColor:   (value== 0) ? const Color.fromARGB(255, 253, 14, 42) :
                                    (value== 1) ? const Color.fromARGB(255, 43, 163, 16) :
                                    const Color.fromARGB(255, 221, 217, 218),
                                  ),
                                  controller: _controller_answer_remainder,
                                  onChanged: (text) {
                                    setState(() {});
                                  }
                              );
                            },
                          )
                          ),


                        ],

                      )
                    ),

                    const SizedBox(height: 4),

                Consumer<MyModel>( //            <--- MyModel Consumer
                    builder: (context, myModel, child) {
                      return SizedBox(height: 40,
                      child: Row(
                        children: [
                          Flexible(
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255,50, 87, 86),
                                minimumSize: const Size(330, 45), //////// HERE
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
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                                show_answer(id, timer_enabled),
                                _controller_answer.text.isNotEmpty ? myModel.stopTimer() : null,                              },
                              child: const Text(
                                'Check',
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                    //      SizedBox(height: 250,
                    //           child: MyStatefulWidget()),

                    Padding( // box for first two line of answer
                      padding: const EdgeInsets.fromLTRB(20,10,0,10),
                      child: SizedBox(height:60,
                        child: ValueListenableBuilder<String>(valueListenable: notificationtext,
                            builder: (context, value, widget) {
                              if(1==1){
                                return Align(alignment: Alignment.centerLeft,
                                  child: Text(value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:  20,// double

                                    ),
                                 //   textAlign: TextAlign.end,
                                  ),
                                );
                              }else {
                                //  return  MyStatefulWidget( value:value); // Text("$value");
                                return
                                  // displaying list items in different box size that will be modified automatically
                                  const Text("Sideloading");
                              }
                            }
                        ),
                      ),
                    ),

                    // box for the correct answer
                    //      SizedBox(height: calculator_visible ?  135 : 220, child:
                    ValueListenableBuilder<List<String>>(valueListenable: notificationlist,
                        builder: (context, value, widget) {
                          if(1!=1){
                            return Text("Loading");
                          }else {
                            //  return  MyStatefulWidget( value:value); // Text("$value");
                            return
                              // displaying list items in different box size that will be modified automatically
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Align(alignment: Alignment.center,
                                    child: Container(color: const Color.fromARGB(
                                        255, 1, 61, 59),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          spacing: 10, // space between row items
                                          runSpacing: 5,
                                          children: value.map((e) => Container(
                                            margin: const EdgeInsets.all(0),

                                            child:  Padding(  padding:
                                            const EdgeInsets.fromLTRB(0,0,0,0),

                                              child:Text(e,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22, // double

                                                ),
                                                textAlign: TextAlign.left,
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

                    const SizedBox(height: 10,),

                    Visibility(visible: _visible,
                      child: CustomKeyboard(
                        onTextInput: (myText) {
                          _insertText(_focus_first_number.hasFocus ? _controller_first_number :
                          _focus_second_number.hasFocus ? _controller_second_number:
                          _focus_answer_remainder.hasFocus ? _controller_answer_remainder :
                              _focus_answer.hasFocus ? _controller_answer :
                          _focus_minimum.hasFocus ? _controller_minimum :
                          _focus_maximum.hasFocus ? _controller_maximum :
                          _controller_calc , myText);
                        },
                        onBackspace_: () {_focus_first_number.hasFocus ? _backspace(_controller_first_number) :
                        _focus_second_number.hasFocus ? _backspace(_controller_second_number) :
                        _focus_answer.hasFocus ? _backspace(_controller_answer) :
                        _focus_answer_remainder.hasFocus ? _backspace(_controller_answer_remainder) :
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
                    )
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
    String _result = number_toenglish(_controller_calc.text);
    Expression exp = p.parse(_result);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);
    String toFarsi = (eval.toStringAsFixed(0));
    _controller_calc.text = toFarsi ;
  }

  String number_toenglish(String number) {
    String numbertoenglish = number.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('۱', '1').replaceAll('۲', '2')
        .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5').replaceAll('۶', '6').replaceAll('۷', '7')
        .replaceAll('۸', '8').replaceAll('۹', '9').replaceAll('۰', '0');
    return numbertoenglish;
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
    first_number_text =number_toenglish(_controller_first_number.text);
    second_number_text= number_toenglish(_controller_second_number.text);

    // removing zeros at the start of number
    int y = 0;
    while (first_number_text[y] == "0") {
      y = y + 1;
    }
    int j = first_number_text.length;
    first_number_text = first_number_text.substring(y,j);


    // after initializing first and second number check if text inputs are removed:
    if ((_controller_first_number.text == "") || (_controller_second_number.text == "") ||
        (_controller_answer.text == "")) {
      showAlertDialog_empty_input(context);
    }
    else if ((notification_operationindex.value == -1) &
    (int.parse(first_number_text) < int.parse(first_number_text))) {
      showAlertDialog_empty_input(context);
    }

    else {
        String text1 = "The answer is not correct";
      String text2 = "Correct answer:";
      String text3 = "Very good, your answer is correct!";

      // add operation
      if (notification_operationindex.value == 3) {
        _answer_text1 = (( int.parse(first_number_text) +
            int.parse(second_number_text)).toString());

        if (_answer_text1 == _controller_answer.text) {
          {
            if (id == 1) { // بررسی
              notificationtext.value =text3;
              notificationlist.value = [];
              notificationcolor.value = 1;

            }
            else if (id == 0) { // پاسخ
              notificationtext.value =
              "Very good, your answer is correct!";
              notificationlist.value = [
                " $_answer_text1 "
              ];
              notificationcolor.value = 1;

            }
          }
        }
        else if (_answer_text1 != _controller_answer.text)
        {
          if (id == 1) { // بررسی
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 0;

          }
          else if (id == 0) { // پاسخ
            notificationtext.value =text2;
            notificationlist.value = [
              " $_answer_text1"
            ];
            notificationcolor.value = 0;

          }
        }
      }


      else if (notification_operationindex.value == 2) {
        _answer_text1 = (( int.parse(first_number_text) -
            int.parse(second_number_text)).toString());

        if (_answer_text1 == _controller_answer.text) {
          {
            if (id == 1) { // بررسی
              notificationtext.value =text3;
              notificationlist.value = [];
              notificationcolor.value = 1;

            }
            else if (id == 0) { // پاسخ
              notificationtext.value =
              "Very good, your answer is correct!";
              notificationlist.value = [
                " $_answer_text1"
              ];
              notificationcolor.value = 1;

            }
          }
        }
        else if (_answer_text1 != _controller_answer.text)
        {
          if (id == 1) { // بررسی
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 0;

          }
          else if (id == 0) { // پاسخ
            notificationtext.value =text2;
            notificationlist.value = [
              " $_answer_text1"
            ];
            notificationcolor.value = 0;

          }
        }
      }


     else if (notification_operationindex.value == 1) {
        _answer_text1 = (( int.parse(first_number_text) *
            int.parse(second_number_text)).toString());

        if (_answer_text1 == _controller_answer.text) {
          {
            if (id == 1) { // بررسی
              notificationtext.value =text3;
              notificationlist.value = [];
              notificationcolor.value = 1;

            }
            else if (id == 0) { // پاسخ
              notificationtext.value =
              "Very good, your answer is correct!";
              notificationlist.value = [
                " $_answer_text1"
              ];
              notificationcolor.value = 1;

            }
          }
        }
        else if (_answer_text1 != _controller_answer.text)
        {
          if (id == 1) { // بررسی
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 0;

          }
          else if (id == 0) { // پاسخ
            notificationtext.value =text2;
            notificationlist.value = [
              " $_answer_text1"
            ];
            notificationcolor.value = 0;

          }
        }
      }

    // If the operation is division:
      else  if (notification_operationindex.value == 0) {
         remainder_answer = []; // removing previous answers

         // finding right answers
        _answer_text1 = (( int.parse(first_number_text) ~/
            int.parse(second_number_text)).toString());
        _answer_text_remainder = (( int.parse(first_number_text) %
            int.parse(second_number_text)).toString());
        remainder_answer.add(_answer_text_remainder);


         // Both quotient and remainder answers are correct (if a remainder is zero it can be written or left empty)
        if ((_answer_text1 == _controller_answer.text) &
        ((remainder_answer[0] == _controller_answer_remainder.text) ||
        ((remainder_answer[0] == ("0")) & (_controller_answer_remainder.text.isEmpty))))
        {
          if (id == 1) {
            notificationtext.value =
            "Very good, your answer is correct!";
            notificationlist.value = [];
            notificationcolor.value = 1;
            notificationcolor_remainder.value = 1;
          }
          else if (id == 0) {
            notificationtext.value =
            "Very good, your answer is correct!";
            notificationlist.value = [
              "The quotient is \n$_answer_text1  \n "
                  "and the remainder is\n    ${remainder_answer[0]}  "
            ];
            notificationcolor.value = 1;
            notificationcolor_remainder.value = 1;
          }
        }

        // Quotient answer is wrong but the remainder is correct (if a remainder is zero it can be written or left empty)
        else if ((_answer_text1 != _controller_answer.text) &
        ((remainder_answer[0] == _controller_answer_remainder.text) ||
            ((remainder_answer[0] == ("0")) & (_controller_answer_remainder.text.isEmpty))))
        {
          if (id == 1) {
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 0;
            notificationcolor_remainder.value = 1;
          }
          else if (id == 0) {
            notificationtext.value =text2;
            notificationlist.value = [
              "The quotient is\n    $_answer_text1  \n "
                  "and the remainder is\n    ${remainder_answer[0]}  "
            ];
            notificationcolor.value = 0;
            notificationcolor_remainder.value = 1;
          }
        }


        // Quotient answer is correct but the remainder is wrong (if a remainder is zero it can be written or left empty)
        else if ((_answer_text1 == _controller_answer.text) &
        !((remainder_answer[0] == _controller_answer_remainder.text) ||
            ((remainder_answer[0] == ("0")) & (_controller_answer_remainder.text.isEmpty))))
        {
          if (id == 1) {
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 1;
            notificationcolor_remainder.value = 0;
          }
          else if (id == 0) {
            notificationtext.value =text2;
            notificationlist.value = [
              " The quotient is\n    $_answer_text1  \n "
                  "and the remainder is\n    ${remainder_answer[0]}  "
            ];
            notificationcolor.value = 1;
            notificationcolor_remainder.value = 0;
          }
        }

        // Both quotient and remainder answers are wrong (if a remainder is zero it can be written or left empty)
        else if ((_answer_text1 != _controller_answer.text) &
        !((remainder_answer[0] == _controller_answer_remainder.text) ||
            ((remainder_answer[0] == ("0")) & (_controller_answer_remainder.text.isEmpty))))
        {
          if (id == 1) {
            notificationtext.value =text1;
            notificationlist.value = [];
            notificationcolor.value = 0;
            notificationcolor_remainder.value = 0;
          }
          else if (id == 0) {
            notificationtext.value =text2;
            notificationlist.value = [
              "The quotient is\n    $_answer_text1  \n "
                  "and the remainder is\n    ${remainder_answer[0]}  "
            ];
            notificationcolor.value = 0;
            notificationcolor_remainder.value = 0;
          }
        }
      }
    } //else of input errors
  }
}

