import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform, exit;
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';
import 'custom_keyboard.dart';
import 'mental_calculation.dart';
// import 'number_history.dart';
// import 'package:myket_iap/myket_iap.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/screen1.png'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              //  fit: BoxFit.cover,
            )
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

              const Align(
                child: SizedBox(
                  height: 170,
                ),
              ),

              Center( // Wrap the Column in a Center widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Use center instead of stretch
                  children: [
                    SizedBox(
                      width: 300, // Set your desired button width here
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[600],
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
                          backgroundColor: Colors.deepPurple[600],
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


              IconButton(
                icon:  const Icon(Icons.data_saver_on),
                color:Colors.limeAccent,
                iconSize: 60,
                onPressed: (){
                  showAlertDialog(context);
                },
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
              '💪 Like muscles, the brain becomes more capable and efficient with exercise. One of the best mental exercises is learning and practicing mathematics. Mathematical skills keep the brain dynamic, improve logical thinking, and help us find better solutions to challenges by recognizing patterns.\n\n\n\n'
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
              'others to solve problems quickly. ',
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
      child: const Text("ok"),
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
          TextSpan(text:'Please fill in all fields.'
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

class Numeral_menu_page extends StatelessWidget {
  const Numeral_menu_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chortke.jpg'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              //  fit: BoxFit.cover,
            )
        ),


        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Math: Precise Ideas, Better Living. ',
                style: TextStyle(
                  color: Colors.tealAccent,

                  fontSize: 22.0,// double

                ),
              ),

              const Align(
                child: SizedBox(
                  height: 40,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.withOpacity(0.8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(330, 100), //////// HERE
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Numeralbase_explain_page()),
                  );
                },
                child: const Text('Numeric systems?',
                  style: TextStyle(

                    fontSize: 30.0,// double

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
                  backgroundColor: Colors.blueGrey.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(330, 100), //////// HERE
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Numeralbase_example_page()),
                  );
                },

                child: const Text(
                  'Examples',
                  style: TextStyle(

                    fontSize: 30.0,// double

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
                  backgroundColor: Colors.blueGrey.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(330, 100), //////// HERE
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Numeralbase_practice_page()),
                  );
                },

                child: const Text(
                  'Practice ',
                  style: TextStyle(

                    fontSize: 30.0,// double

                  ),
                ),
              ),

              const Align(
                child: SizedBox(
                  height: 70,
                ),
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon:  const Icon(Icons.keyboard_return),
                    color:Colors.lightBlue[100],
                    iconSize: 40,
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
      title: 'Decimal numeral system (base 10)',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          const Align(
            child: SizedBox(
              height: 55,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child:Image.asset('assets/images/att_numbase_ler_ten_4.PNG',fit: BoxFit.fill), flex:1),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child:Image.asset('assets/images/att_numbase_ler_ten_4.PNG',fit: BoxFit.fill), flex:1),
            ],
          ),
        ],),),

    AdvancedTile(
      title: 'Number systems with a base less than 10',
      body: Column(
          children: <Widget>[Image.asset('assets/images/att_numbase_ler_ten_4.PNG')]),
    ),

    AdvancedTile(
      title: 'Number systems with a base greater than 10۱۰',
      body: Column(
          children: <Widget>[Image.asset('assets/images/att_numbase_ler_ten_4.PNG')]),
    ),
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
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chortke.jpg'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              //  fit: BoxFit.cover,
            )
        ),

        child: Column(
          children: [
            SizedBox(height: 625,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child : Column(
                      children : <Widget>[
                        ListView.builder(

                          key: Key('builder ${selected.toString()}'), //attention
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top:  selected==-1 ? 120 :10),
                          shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.0),
                              child: Card( color:const Color.fromARGB(255, 21, 68, 67),
                                shadowColor: Color.fromARGB(255,50, 87, 86),
                                elevation: 0.0,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Color.fromARGB(255,50, 87, 86), width:2),
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
                                  // menu goes to selected that other opened widget
                                  onExpansionChanged: (newState){
                                    if(newState){
                                      setState(() {
                                        selected = index;
                                        _changeFontSize(22);
                                      });
                                    }
                                    else{
                                      setState(() {
                                        selected = -1; // items are numbered from zero, so no one of widgets would be opened
                                        _changeFontSize(35);
                                      });
                                    }
                                  },
                                  title: Center(
                                    child: Text(textAlign: TextAlign.right,
                                      items[index].title,
                                      style: TextStyle(
                                        color: Colors.white70,

                                        fontSize:  selected==-1 ? 30:21,// double

                                      ),
                                    ),
                                  ),
                                  children:  <Widget>[
                                    AspectRatio(aspectRatio: 1.0,
                                      child: ListView.builder(itemCount: 1, itemBuilder: (context, item){
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
            Row(mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  IconButton(
                    icon:  const Icon(Icons.keyboard_return),
                    color:Colors.lightBlue[100],
                    iconSize: 40,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                      );
                    },
                  ),

                  IconButton(
                    icon:  const Icon(Icons.home),
                    color:Colors.lightBlue[100],
                    iconSize: 40,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Homepage()),
                      );
                    },
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////:://////////////////////////// Numeralbase_example page

class Numeralbase_example_page extends StatelessWidget {
  const Numeralbase_example_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wepik.jpeg'),
              // color: const Color.fromRGBO(255, 255, 255, 0.5),
              fit: BoxFit.fill,
              //  fit: BoxFit.cover,
            )
        ),


        child: Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const Align(
                child: SizedBox(
                  height: 10,
                ),
              ),

              const Text(
                'Mathematics is about exploring patterns and making connections.\n\n'
                    'Does one have to be a genius to do mathematics? The answer is an emphatic NO.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal, // Adjust as needed
                  fontSize: 18.0, // Adjust as needed
                ),
              ),
              const Text(
                ' - Terence Tao',
                style: TextStyle(
                  color: Colors.tealAccent,

                  fontSize: 22.0,
                ),
              ),

              SizedBox(height: 540,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(5,5,5,5),
                      padding: const EdgeInsets.fromLTRB(12,10,0,10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 243, 235),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child : Column(
                            children : [
                              ListView.builder(
                                padding: EdgeInsets.only(left: 0.0, right: 13.0, bottom: 25.0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Column(
                                      children:
                                      <Widget>[Image.asset('assets/images/attached_numbase_examp_19.png')]

                                  );
                                },
                              )
                            ]
                        ),
                      )
                  ),
                ),
              ),

              //_createContents()

              Row(mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    IconButton(
                      icon:  const Icon(Icons.keyboard_return),
                      color:Colors.lightBlue[100],
                      iconSize: 40,
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                        );
                      },
                    ),

                    IconButton(
                      icon:  const Icon(Icons.home),
                      color:Colors.lightBlue[100],
                      iconSize: 40,
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
  int id = 2;
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
                    const SizedBox(height: 15),

                    SizedBox(height: 30,
                      child: Row(
                        children: [
                          IconButton(
                            icon:  const Icon(Icons.keyboard_return),
                            color:Colors.lightBlue[100],
                            iconSize: 25,
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Numeral_menu_page()),
                              );
                            },
                          ),

                          IconButton(
                            icon:  const Icon(Icons.home),
                            color:Colors.lightBlue[100],
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
                            color:Colors.lightBlue[100],
                            iconSize: 25,
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Homepage()),
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

                    const SizedBox(height: 2,),

                    Consumer<MyModel>( //            <--- MyModel Consumer
                        builder: (context, myModel, child) {
                          return Visibility(visible: timer_visible,
                            child : SizedBox(height: 32,
                                child: Timerbox(timer_changed: timer_CallBack)),
                          );}
                    ),

                    SizedBox(height: 2,),

                    Visibility(visible: random_interval_visible,
                      child : SizedBox(height: 28,
                        child: Row(
                          children: [
                            Flexible(
                              child:  TextField(focusNode: _focus_maximum,
                                readOnly: true, showCursor: true, cursorHeight: 22, cursorColor: Colors.black,
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
                                  hintStyle: TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  fillColor: Color.fromARGB(255, 246, 182, 58 ),
                                ),
                                textAlign: TextAlign.left,
                              ),
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
                                style: const TextStyle(fontSize: 26.0, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                controller: _controller_minimum,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(

                                  hintText: 'min',
                                  hintStyle: TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(6,1,8,11),
                                  fillColor: Color.fromARGB(255, 246, 182, 58 ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 5,),
                            Container( // for first toggle button
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
                                  Text('Random number',
                                    style: TextStyle(

                                      color: Colors.white70,
                                      fontSize: 18.0,// double

                                    ),
                                  ),
                                ],
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
                              myModel.Timer_text_start_btn ='stop',
                              myModel.timer_button_color_red= true,
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
                              _controller_from_base.text = "۱۰";

                              to_base_text= randomNumber(2,9).toString();
                              _controller_to_base.text = (to_base_text);

                            }
                            else {
                              main_number_text = (randomNumber(1, 100).toString());
                              _controller_main_number.text = main_number_text;

                              from_base_text= "10";
                              _controller_from_base.text = "۱۰";

                              to_base_text= randomNumber(2,9).toString();
                              _controller_to_base.text = (to_base_text);
                              //  main_number_text = from_base_text = to_base_text = user_answer_text = "";
                            }
                            }, // onPressed

                            child:  const Text(
                              "New practice",
                              style: TextStyle(

                                fontSize: 22.0,// double

                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 3),

                    SizedBox(height:40,
                      child: Row(
                        children:  [
                          Flexible(
                            child:  TextField(focusNode: _focus_main_number, readOnly: true, showCursor: true,
                                cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 36.0, color: Colors.black,
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

                          const SizedBox(width: 10),
                          const Text('Convert number',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 22.0,// double

                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    SizedBox(height:40,
                      child: Row(
                        children:  [
                          Flexible(
                            child:  TextField(focusNode: _focus_to_base , readOnly: true, showCursor: true,
                                cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 36.0, color: Colors.black,
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

                          const SizedBox(width: 10),

                          const Text('to base',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 22.0,// double

                            ),
                          ),

                          const SizedBox(width: 10),

                          Flexible(
                            child:  TextField(focusNode: _focus_from_base, readOnly: true, showCursor: true,
                                cursorHeight: 22, cursorColor: Colors.black,
                                onTap: () { if (!_visible) {
                                  show_keboard();
                                }
                                },
                                autofocus: false,
                                style: const TextStyle(fontSize: 36.0, color: Colors.black,
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

                          const SizedBox(width: 14),

                          const Text('from base',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 22.0,// double

                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    SizedBox(height:40,
                      child: Row(
                        children:  [
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
                                      fontSize: 36.0, color: Colors.black,
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

                          const SizedBox(width: 10),
                          const Text('Answer?',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 22.0,// double

                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 2),

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
                                        style: TextStyle(

                                          fontSize: 22.0,// double

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

                                          fontSize: 22.0,// double

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                    ),


                    Padding( // box for first two line of answer
                      padding: const EdgeInsets.fromLTRB(8.0,10,0,0),
                      child: SizedBox(height:60,
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
      String text2 = "in base";
      String text3 = "Your answer is correct. ";


      if ("random"== "random") {

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
        print("q $q");

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

        if (id == 0) {
          if (fromBase < 10) {
            _answer_text = (
                ' $digit1Print  (${_controller_from_base.text} $text2) =\n $digit1 (۱۰ $text2) ='
                    '\n $digit_ (${_controller_to_base.text} $text2) = ');
          } else  {
            _answer_text = (' $digit1Print (۱۰ $text2) = \n $digit_ (${(toBase.toString())} $text2) = ');
          } ;

        }
        else if (id == 1) {
          _answer_text =  (digit_ == (_controller_answer.text)) ? text3 : text1;
          notificationlist.value = [];

        }
      } // if of Random_numbers

      else { // of Random_numbers
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
              ' $digit1Print  ($fromBase $text2) =\n $digit1 (10 $text2) = \n $digit_ ($toBase $text2) = ');
        } else {
          _answer_text1 = (
              ' $digit1Print ($fromBase $text2) = $digit_ ($toBase $text2) = ');
        }

      } //else of Random_numbers
      if (id== 0) {
        notificationlist.value = plus_power;
      }

      notificationtext.value = _answer_text;

      // else if (id == 1)

    } //else of input errors
  }
}


/////////////////////////////////////////////////////////////// ChangeNotifier model for Timer class (methods)
// This model is used in main codes using provider + consumer, and in timer box using context.read

class MyModel with ChangeNotifier { //                        <--- MyModel

  Timer? countupTimer;
  Duration myDuration = Duration(days: 5);
  List<bool> timer_selected = <bool>[false];
  final List<bool> timer_start_ispressed = <bool>[false];
  String Timer_text_start_btn = 'start';
  bool timer_button_color_red = false; // if false the button color is blue else red
  String strDigits(int n) => n.toString().padLeft(2, '0');
  get days => strDigits(myDuration.inDays);
  get hours => strDigits(myDuration.inHours.remainder(24));
  get minutes => strDigits(myDuration.inMinutes.remainder(60));
  get seconds => strDigits(myDuration.inSeconds.remainder(60));
  get timeValue => // in English: '$hours:$minutes:$seconds'; in farsi:
  (int.parse(hours) > 0) ?
  '${(hours)}:${(minutes)}:${(seconds)}' :
  '${(minutes)}:${(seconds)}' ;


  /// Timer related methods ///
  startTimer() {
    countupTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountUp());
    timer_button_color_red = true;
    (Timer_text_start_btn =='start') ? {Timer_text_start_btn ='stop'}
        : (Timer_text_start_btn == 'continue') ? {Timer_text_start_btn ='stop'} :
    (Timer_text_start_btn =='stop') ? (Timer_text_start_btn = 'continue') :
    Timer_text_start_btn ='start' ;
    notifyListeners();
  }

  stopTimer() {
    countupTimer?.cancel();
    timer_button_color_red= false;
    (Timer_text_start_btn = 'continue');
    notifyListeners();
  }

  resetTimer() {
    myDuration = const Duration(days: 5);
    stopTimer();
    timer_button_color_red= true;
    Timer_text_start_btn ='start';
    notifyListeners();
  }

  void setCountUp() {
    const increaseSecondsBy = 1;
    final seconds = myDuration.inSeconds + increaseSecondsBy;
    myDuration = Duration(seconds: seconds);
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
    var readModelNotifiers = context.read<MyModel>();
    final myModel = Provider.of<MyModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 0, 14 ),
      body: SizedBox(height: 30,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: ToggleButtons(
                    isSelected: myModel.timer_selected,
                    onPressed: (int index) {
                      // Use myModel to access MyModel properties and methods
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
                      Text(
                        'Timer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0), // Add space between the first and second widgets
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 5.0),

                  child: ToggleButtons(
                    isSelected: myModel.timer_start_ispressed,
                    onPressed: (int index) {
                      setState(() {
                        // Toggle timer on/off *only if* the main timer toggle is ON
                        if (myModel.timer_selected[0]) {
                          if (myModel.Timer_text_start_btn == 'stop') { // **Corrected Property Name!**
                            myModel.stopTimer();
                          } else {
                            myModel.startTimer();
                          }
                        }
                        myModel.timer_start_ispressed[0] =
                        !myModel.timer_start_ispressed[0];
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedColor: Colors.red,
                    fillColor: myModel.timer_button_color_red // **Corrected Property Name!**
                        ? Colors.red
                        : const Color.fromARGB(255, 51, 85, 255),
                    color: Colors.yellow[400],
                    children: [
                      Text(
                        myModel.Timer_text_start_btn, // **Corrected Property Name!**
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0), // Add space between the second and third widgets
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0), // Small space on both sides
                  child: ElevatedButton(
                    onPressed: () {
                      readModelNotifiers.resetTimer();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all<Color>(const Color.fromARGB(255, 5, 132, 1)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    child: const Text(
                      'restart',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0), // Add space between the third and fourth widgets
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      readModelNotifiers.timeValue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )

      ),
    );
  }
}


