
import 'package:flutter/material.dart';

class insertText { void call(TextEditingController _controller, String myText ){
  final textSelection = _controller.selection;
  _controller.text = _controller.text + myText;

  // textSelection is used for cursor being at the end of line
  _controller.selection = textSelection.copyWith(
    baseOffset: _controller.text.length,
    extentOffset: _controller.text.length,
  );

/* above method is replaced instead of below method

  final text = _controller.text;
  final textSelection = _controller.selection;
  final newText = text.replaceRange(
    textSelection.start,
    textSelection.end,
    myText,);
  final myTextLength = myText.length;
  _controller.text = newText;
  _controller.selection = textSelection.copyWith(
    baseOffset: textSelection.start + myTextLength,
    extentOffset: textSelection.start + myTextLength,
  );*/

}
}


//////////////////////////////////////////////////////////////////////////////////////
class backspace { void call(TextEditingController _controller ){
  final text = _controller.text;
  final textSelection = _controller.selection;
  final selectionLength = textSelection.end - textSelection.start;

  // There is a selection.
  if (selectionLength > 0) {
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start,
      extentOffset: textSelection.start,
    );
    return;
  }

  // The cursor is at the beginning.
  if (textSelection.start == 0) {
    return;
  }

  // Delete the previous character
  final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
  final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
  final newStart = textSelection.start - offset;
  final newEnd = textSelection.start;
  final newText = text.replaceRange(
    newStart,
    newEnd,
    '',
  );
  _controller.text = newText;
  _controller.selection = textSelection.copyWith(
    baseOffset: newStart,
    extentOffset: newStart,
  );
}


// To prevent being crashed check if the previous character was a UFT-16 surrogate (emoji)
bool _isUtf16Surrogate(int value) {
  return value & 0xF800 == 0xD800;}}


//////////////////////////////////////////////////////////////////////////////////////
class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace_,
    required this.callbackFunction,
    required this.calculator_callbackFunction,
    this.flex = 1,
  }) : super(key: key);

  final int flex;
  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace_;
  final VoidCallback callbackFunction;
  final VoidCallback calculator_callbackFunction;

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);
  void _backspaceHandler() => widget.onBackspace_.call();

  void is_keyboard_on() {
    setState(() {
      _keyboard_on = !_keyboard_on;
    });
  }

  bool _keyboard_on = true;
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: const Color.fromARGB(255, 24, 66, 113),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            buildRowOne(),
            buildRowTwo(),
            buildRowThree(),
          ],
        ),
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '6',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '7',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '8',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '9',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '0',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          // SizedBox(width : 20),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 67, 98, 142),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: const Size(135, 50), //////// HERE
              ), // here we call calculator_callbackFunction that calls show_keboard_calculator
              onPressed: () {_keyboard_on ? {widget.calculator_callbackFunction(),
              } : is_keyboard_on();},

              child: const Text('Calculator',
                style: TextStyle(color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,// double

                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 67, 98, 142),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: const Size(100, 50), //////// HERE
              ),
              onPressed: () {widget.callbackFunction(); },
              child: const Text('Ok',
                style: TextStyle(color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,// double

                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 195, 75, 92),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: const Size(65, 60), //////// HERE
              ),
              onPressed: () {widget.onBackspace_.call(); },
              child: const Icon(Icons.backspace),
            ),
          ),

          /*     Instead of a new class and call here the above method is used
     Padding(
            padding: const EdgeInsets.all(4.0),
            child: BackspaceKey(onBackspace: _backspaceHandler,
              // BackspaceKey is a class that needs void onBackspace to use that here is fed by calling
              // widget.onBackspace_ via _backspaceHandler that gets _backspace(a controller) in another class
            ),
          ),*/
        ],
      ),
    );
  }
}

// style of number keys and their actions
class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    required this.text,
    required this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor:  const  Color.fromARGB(255, 67, 98, 142),
          onTap: () {
            onTextInput.call(text);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),
                color: const Color.fromARGB(255, 120, 90, 201)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,// double
                   
                ),
              ),
            ),),),),);
  }
}

// style of delete key and its action
class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    required this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 195, 75, 92),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            minimumSize: const Size(85, 60), //////// HERE
          ),
          onPressed: () {onBackspace.call(); },
          child: const Icon(Icons.backspace),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////
// adding calculator keyboard + a textfield
class Calculator_Keyboard extends StatefulWidget {
  Calculator_Keyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    required this.calculator_callbackFunction,
    required this.calculator_textfield_controller,
    required this.calculator_textfield_focus,
    this.flex = 1,
  }) : super(key : key);

  final int flex;
  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback calculator_callbackFunction;

  ValueChanged<TextEditingController>   calculator_textfield_controller;
  ValueChanged<bool>   calculator_textfield_focus;
  @override
  State<Calculator_Keyboard> createState() => _Calculator_KeyboardState();
}

class _Calculator_KeyboardState extends State<Calculator_Keyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);
  void _backspaceHandler() => widget.onBackspace.call();

  TextEditingController _controller_calculator = TextEditingController();
  FocusNode _focus_calculator = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus_calculator.addListener(_onFocusChange);
  }

  @override // to release the memory used when textfield is focused
  void dispose() {
    super.dispose();
    _focus_calculator.removeListener(_onFocusChange);
    _controller_calculator.dispose();
    _focus_calculator.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus_calc: ${_focus_calculator.hasFocus}");
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: const Color.fromARGB(255, 24, 66, 113),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            buildRowOne(),
            buildRowTwo(),
          ],
        ),
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey_cal(
            text: '+',
            onTextInput: _textInputHandler,
          ),
          TextKey_cal(
            text: '-',
            onTextInput: _textInputHandler,
          ),
          TextKey_cal(
            text: '×',
            onTextInput: _textInputHandler,
          ),
          TextKey_cal(
            text: '÷',
            onTextInput: _textInputHandler,
          ),
          TextKey_cal(
            text: '=',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }
  Expanded buildRowTwo() {
    return Expanded(
      child: Padding(

        padding: const EdgeInsets.fromLTRB(15, 3, 15, 6),
        child: Container( color: Colors.amber ,
          child: Focus(
            child:TextField(focusNode: _focus_calculator, readOnly: true, showCursor: true,
                cursorHeight: 30, cursorColor: Colors.black,
                onTap: () {
                },
                autofocus: false,
                style: const TextStyle(fontSize: 30.0, color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(contentPadding: EdgeInsets.all(9),
                  filled: true,border : InputBorder.none,
                  fillColor: Color.fromARGB(255, 246, 182, 58 ),
                ),
                controller: _controller_calculator,
                onChanged: (text) {
                  setState(() {});
                }
            ),

            onFocusChange: (hasFocus) {widget.calculator_textfield_controller(_controller_calculator);
            widget.calculator_textfield_focus(_focus_calculator.hasFocus);
            },
          ),
        ),
      ),
    );
  }
}


// style of number keys and their actions for calculator keys
class TextKey_cal extends StatelessWidget {
  const TextKey_cal({
    Key? key,
    required this.text,
    required this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;


  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          //  splashColor:  const  Color.fromARGB(255, 67, 98, 142),
          onTap: () {
            onTextInput.call(text);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),
                color: const Color.fromARGB(255, 120, 80, 201)),
            child: Text(text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,// double
                 
              ),
            ),),),),);
  }
}


//////////////////////////////////////////////////////////////////////////////
String convertToArabicNumber(String number) {
  String res = '';

  final arabics = ['٠', '١', '٢', '٣', '۴', '۵', '۶', '٧', '٨', '٩'];
  number.characters.forEach((element) {
    res += arabics[int.parse(element)];
  });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
  return res;
}

