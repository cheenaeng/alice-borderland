import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../websocket.dart';
import 'pre_game_host.dart';
import 'pre_game_players.dart';

class GameButton extends StatelessWidget {
  final String gameLabel;
  final VoidCallback onButtonClick;

  GameButton(this.gameLabel, this.onButtonClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 20,
            color: Colors.white60,
          )),
          shadowColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black87),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () {
          onButtonClick();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => gameLabel == 'Start game'
                      ? PreGameLayout()
                      : PreGameLayoutPlayers()));
        },
        child: Text(gameLabel),
      ),
    );
  }
}

class UsernameStatefulWidget extends StatefulWidget {
  const UsernameStatefulWidget({super.key});

  @override
  State<UsernameStatefulWidget> createState() => _UsernameStatefulWidgetState();
}

class _UsernameStatefulWidgetState extends State<UsernameStatefulWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void btnStartGame() async {
    final prefs = await SharedPreferences.getInstance();

    //store name in local storage
    await prefs.setString('userName', _controller.text);
    _controller.clear();

    //route here

    //set connection here
    initConnection();
  }

  void btnJoinRoom() async {
    final prefs = await SharedPreferences.getInstance();

    //store name in local storage
    await prefs.setString('userName', _controller.text);
    _controller.clear();

    //route here
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 300,
            child: TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 15, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: 'Enter your name'),
              controller: _controller,
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "$value", which has length ${value.characters.length}.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameButton('Start game', btnStartGame),
              GameButton('Join Room', btnJoinRoom),
            ],
          ),
        )
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg-image.jpg"),
            fit: BoxFit.cover,
          ),
        )),
        Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Text('BorderLanders',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        fontFamily: 'CloisterBlack')),
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('KEY IN USERNAME HERE',
                              style: GoogleFonts.courierPrime(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        UsernameStatefulWidget(),
                      ],
                    )))
          ],
        ),
      ]),
    );
  }
}
