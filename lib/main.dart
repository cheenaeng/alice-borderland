import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({required this.title, super.key});

//   // Fields in a Widget subclass are always marked "final".

//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56.0, // in logical pixels
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(color: Colors.blue[500]),
//       // Row is a horizontal, linear layout.
//       child: Row(
//         children: [
//           const IconButton(
//             icon: Icon(Icons.menu),
//             tooltip: 'Navigation menu',
//             onPressed: null, // null disables the button
//           ),
//           // Expanded expands its child
//           // to fill the available space.
//           Expanded(
//             child: title,
//           ),
//           const IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           ),
//         ],
//       ),
//     );r
//   }
// }

//start a websocket conection by pressing start game button

// once game created --> all

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Center(
        child: Text('Hello, world!'),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: TextField(
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 15, color: Colors.white),
                  borderRadius: BorderRadius.circular(50.0)),
              hintText: 'Find a good name'),
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
        ));
  }
}

class BaseLayout extends StatelessWidget {
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
                        fontSize: 60,
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
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GameButton('Start game', () {}),
                              GameButton('Join Room', () {}),
                            ],
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ]),
    );
  }
}

void btnStartGame() {
  //store name in local storage

  //create a new session with websocket

  //navigate to new page with room code
}

void btnJoinRoom() {
  //store name in local storage

  //navigate to page to join room
}

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
        onPressed: onButtonClick,
        child: Text(gameLabel),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Borderlanders',
      theme: ThemeData(
        fontFamily: 'CourierPrime',
      ),
      home: SafeArea(
        child: BaseLayout(),
      ),
    ),
  );
}
