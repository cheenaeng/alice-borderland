import 'package:flutter/material.dart';
import 'package:namer_app/views/holding_room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PreGameLayoutPlayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: HeadingName(),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          ))
        ],
      ),
    );
  }
}

class RoomFieldStatefulWidget extends StatefulWidget {
  const RoomFieldStatefulWidget({super.key});

  @override
  State<RoomFieldStatefulWidget> createState() => _RoomFieldStatefulWidget();
}

class _RoomFieldStatefulWidget extends State<RoomFieldStatefulWidget> {
  late TextEditingController _controller;

  void _printLatestValue() {
    print(_controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // String? get _errorText {
  //   // at any time, we can get the text from _controller.value.text
  //   final text = _controller.value.text;
  //   // Note: you can do your own custom validation here
  //   if (text.length < 4) {
  //     return 'Too short';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 200,
            child: TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  // errorText: _errorText,
                  filled: true,
                  fillColor: Colors.white,
                  border: UnderlineInputBorder(),
                  hintText: 'Enter roomcode'),
              controller: _controller,

              // onSubmitted: (String value) async {
              //   await showDialog<void>(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: const Text('Thanks!'),
              //         content: Text(
              //             'You typed "$value", which has length ${value.characters.length}.'),
              //         actions: <Widget>[
              //           TextButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             child: const Text('OK'),
              //           ),
              //         ],
              //       );
              //     },
              //   );
              // },
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        )
      ],
    );
  }
}

class HeadingName extends StatefulWidget {
  @override
  State<HeadingName> createState() => _HeadingNameState();
}

class _HeadingNameState extends State<HeadingName> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _userName;

  // _getUserName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _userName = await prefs.getString('userName') ?? '';
  // }

  @override
  void initState() {
    super.initState();
    _userName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('userName') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userName,
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: [
                Text('Player: ${snapshot.data}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        fontFamily: 'CloisterBlack')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                      child: Text('[GAME START]',
                          style: TextStyle(
                            fontSize: 36,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              )
                            ],
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                      child: Text('DIFFICULTY',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      child: Image.asset('assets/king-of-diamonds-card.png',
                          fit: BoxFit.cover, width: 100, height: 150)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: RoomFieldStatefulWidget()),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 200,
                    child: TextButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black87),
                        shadowColor: MaterialStateProperty.all(
                          Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HoldingRoom()));
                      },
                      child: Text(
                        'Join Room',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
