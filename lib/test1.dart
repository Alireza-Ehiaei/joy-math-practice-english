import 'package:flutter/material.dart';

const List<Widget> fruits = <Widget>[
  Text('Apple'),
  Text('Banana'),
  Text('Orange')
];

const List<Widget> vegetables = <Widget>[
  Text('Tomatoes'),
  Text('Potatoes'),
  Text('Carrots')
];

const List<Widget> icons = <Widget>[
  Icon(Icons.sunny),
  Icon(Icons.cloud),
  Icon(Icons.ac_unit),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'ToggleButtons Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //  title: _title,
      home: ToggleButtonsSample(title: _title),
    );
  }
}

class ToggleButtonsSample extends StatefulWidget {
  const ToggleButtonsSample({super.key, required this.title});

  final String title;

  @override
  State<ToggleButtonsSample> createState() => _ToggleButtonsSampleState();
}

class _ToggleButtonsSampleState extends State<ToggleButtonsSample> {
  final List<bool> _selectedFruits = <bool>[true, false, false];
  final List<bool> _selectedVegetables = <bool>[false, true, false];
  final List<bool> _selectedWeather = <bool>[false, false, true];
  final List<bool> _selectedaction = <bool>[false, false, false];
  final List<bool> isSelected = <bool>[false, false, false];
  final List<bool> areSelected = <bool>[false, false, false];
  final List<bool> timer_selected = <bool>[false];

  bool vertical = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ToggleButtons with a single selection.
              Text('Single-select', style: theme.textTheme.titleSmall),
              const SizedBox(height: 5),
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                child: ToggleButtons(
                  direction: vertical ? Axis.vertical : Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
          // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedFruits.length; i++) {
                        _selectedFruits[i] = (i == index);
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.red[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedFruits,
                  children: fruits,
                ),
              ),

              const SizedBox(height: 20),


              // ToggleButtons with a multiple selection.
              Text('Multi-select', style: theme.textTheme.titleSmall),
              const SizedBox(height: 5),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  // All buttons are selectable.
                  setState(() {
                    _selectedVegetables[index] = !_selectedVegetables[index];
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.green[700],
                selectedColor: Colors.white,
                fillColor: Colors.green[200],
                color: Colors.green[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: _selectedVegetables,
                children: vegetables,
              ),
              const SizedBox(height: 20),

              // ToggleButtons with icons only.
              Text('Icon-only', style: theme.textTheme.titleSmall),
              const SizedBox(height: 5),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedWeather.length; i++) {
                      _selectedWeather[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.blue[700],
                selectedColor: Colors.white,
                fillColor: Colors.blue[200],
                color: Colors.blue[400],
                isSelected: _selectedWeather,
                children: icons,
              ),

              const SizedBox(height: 20),

              Text('No selection impossible', style: theme.textTheme.titleSmall),

              // Here is an implementation that requires mutually exclusive selection while
              // requiring at least one selection.
              ToggleButtons(
                isSelected: _selectedaction,
                onPressed: (int index) {
                  setState(() {_selectedaction[3] = false;
                    for (int buttonIndex = 0; buttonIndex < _selectedaction.length; buttonIndex++) {
                      if (buttonIndex == index) {print("index $index");
                        _selectedaction[buttonIndex] = true;
                      } else {
                        _selectedaction[buttonIndex] = false;
                      }
                    }
                  });
                },
                children: const <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.call),
                  Icon(Icons.cake),
                ],
              ),

              const SizedBox(height: 20),
              Text('No selection possible', style: theme.textTheme.titleSmall),
              // Here is an implementation that requires mutually exclusive selection
              // for none of the buttons to be selected.
              ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = !isSelected[buttonIndex];
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                children: const <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.call),
                  Icon(Icons.cake),
                ],
              ),

              const SizedBox(height: 20),

              Text('Multi selection possible with at least one selected', style: theme.textTheme.titleSmall),

              // An implementation that allows for multiple buttons to be simultaneously selected,
              // while requiring at least one selection.
              ToggleButtons(
                isSelected: areSelected,
                onPressed: (int index) {
                  int count = 0;
                  for (final bool value in areSelected) {
                    if (value) {
                      count += 1;
                    }
                  }
                  if (areSelected[index] && count < 2) {
                    return;
                  }
                  setState(() {
                    areSelected[index] = !areSelected[index];
                  });
                },
                children: const <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.call),
                  Icon(Icons.cake),
                ],
              ),

              ToggleButtons(
                isSelected: timer_selected,
                onPressed: (int index) {
                  setState(() {
                    timer_selected[index] = !timer_selected[index];
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.blue[700],
                selectedColor: Colors.red,
                fillColor: Colors.blue[200],
                color: Colors.yellow[400],
                children: const <Widget>[
                  Icon(Icons.lock_clock),
                ],
              ),
            ],

          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            // When the button is pressed, ToggleButtons direction is changed.
            vertical = !vertical;
          });
        },
        icon: const Icon(Icons.screen_rotation_outlined),
        label: Text(vertical ? 'Horizontal' : 'Vertical'),
      ),
    );
  }
}
