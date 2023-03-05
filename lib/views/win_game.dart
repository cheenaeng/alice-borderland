import 'package:flutter/material.dart';

class WinGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fireworks.webp"),
            fit: BoxFit.cover,
          ),
        )),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Text('You win',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 55,
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
