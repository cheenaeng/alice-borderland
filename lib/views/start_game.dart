import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'win_game.dart';
import '../main.dart';

class CustomMaxValueInputFormatter extends TextInputFormatter {
  final double maxInputValue;

  CustomMaxValueInputFormatter({required this.maxInputValue});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (maxInputValue != null) {
      final double? value = double.tryParse(newValue.text);
      if (value == null) {
        return TextEditingValue(
          text: truncated,
          selection: newSelection,
        );
      }
      if (value > maxInputValue) {
        truncated = maxInputValue.toString();
      }
    }
    return TextEditingValue(text: truncated, selection: newSelection);
  }
}

class NumberInput extends StatefulWidget {
  @override
  State<NumberInput> createState() => _NumberInput();
}

class _NumberInput extends State<NumberInput> {
  TextEditingController myinput = TextEditingController();
  @override
  void initState() {
    myinput.text = "0"; //innitail value of text field
    super.initState();
  }

  @override
  void dispose() {
    myinput.dispose();
    super.dispose();
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = myinput.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (double.tryParse(text) == null) {
      return 'Not a number';
    }
    // return null if the text is valid
    return null;
  }

  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            TextField(
                inputFormatters: [
                  CustomMaxValueInputFormatter(maxInputValue: 100),
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
                ],
                onChanged: (text) => setState(() => text),
                controller: myinput,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    errorText: _errorText,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 15, color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
                  shadowColor: MaterialStateProperty.all(
                    Colors.grey.withOpacity(0.5),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WinGame()));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class TimerStart extends StatefulWidget {
  @override
  State<TimerStart> createState() => _TimerStart();
}

class _TimerStart extends State<TimerStart> {
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 30);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      }
      if (seconds == 0) {
        navigatorKey.currentState?.pushNamed('/win');
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return SizedBox(
        child: Text(
      seconds,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 100),
    ));
  }
}

class GameStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gray-bg.jpg"),
            fit: BoxFit.cover,
          ),
        )),
        Column(
          children: [
            SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Text('Game Start',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontFamily: 'CloisterBlack')),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Column(
                      children: [TimerStart(), NumberInput()],
                    )))
          ],
        ),
      ]),
    );
  }
}
