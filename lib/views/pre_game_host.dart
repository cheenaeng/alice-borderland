import 'package:flutter/material.dart';
import 'package:namer_app/views/start_game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

Widget _animatedText() {
  return SizedBox(
    child: DefaultTextStyle(
      style: const TextStyle(
        fontSize: 36.0,
      ),
      child: Center(
        child: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(milliseconds: 0),
          animatedTexts: [
            ScaleAnimatedText('Start Game', scalingFactor: 0.2),
          ],
        ),
      ),
    ),
  );
}

class PreGameLayout extends StatelessWidget {
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
                      child: Text('ROOM CODE: ABCD',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
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
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      child: Text('2 people joined the room',
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                ),
                Stack(
                  children: [
                    _animatedText(),
                    SizedBox(
                      height: 50,
                      width: 1000,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameStartPage()));
                        },
                        child: Text(''),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
