import 'package:flutter/material.dart';
import 'dart:async';
import 'congrats.dart';

class WaitWaitCountdownScreen extends StatefulWidget {
  final int day;
  const WaitWaitCountdownScreen({Key? key, required this.day}) : super(key: key);

  @override
  _WaitWaitCountdownScreenState createState() => _WaitWaitCountdownScreenState();
}

class _WaitWaitCountdownScreenState extends State<WaitWaitCountdownScreen> {
  int countdown = 3;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 1) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CongratsScreen(day: widget.day,)),
        );
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.06, 1.0],
            colors: [
              Color(0xFF795DEA),
              Color(0xFFBA63F5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,  // Align the top texts to start
          children: [
            // First Text: "Next" at the top of the page
            Padding(
              padding: EdgeInsets.only(top: 60.0), // Add padding to move it down slightly
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Second Text: "Tense and relax quickly"
            Text(
              "Tense and relax quickly",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30),

            // Expanded widget to center the countdown text
            Expanded(
              child: Center(
                child: Text(
                  "$countdown",  // Use the variable for countdown
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

