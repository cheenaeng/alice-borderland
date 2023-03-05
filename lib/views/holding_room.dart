import 'package:flutter/material.dart';
import 'package:namer_app/views/start_game.dart';

class HoldingRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: SizedBox(
              child: Text(
                '[REGISTRATION COMPLETE]',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
          Expanded(
              child: Center(
            child: SizedBox(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      child: Text(
                        'THE GAME WILL START WHEN START BUTTON IS PUSHED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  )),
            ),
          )),
          Expanded(
              child: Padding(
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
                    MaterialPageRoute(builder: (context) => GameStartPage()));
              },
              child: Text(
                'Submit',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
