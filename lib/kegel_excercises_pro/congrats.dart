import 'package:excercise_app/kegel_excercises_pro/kegelDaysUnlocked_hive.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

import '../kegel_excercise_home.dart';

class CongratsScreen extends StatefulWidget {
  final int day;
  const CongratsScreen({Key? key, required this.day}) : super(key: key);

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int unlockedDay= KegelStorage.unlockedDay;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.shade100,
                      ),
                      child: Center(
                        child: Text(
                          "👍", // Thumbs up emoji
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Congrats",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text("3 times a day to achieve the best results"),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        int currentDay = widget.day;
                        if(unlockedDay== currentDay)
                          KegelStorage.setUnlockedDay(unlockedDay + 1); // Unlock the next day

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => KegelExercisesScreen()),
                      );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Continue", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => KegelExercisesScreen()),
                        );
                      },
                      child: Text("DO IT AGAIN", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Stack Confetti behind the thumb
          Positioned.fill(
            left: 100,
            bottom: 300,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 2 * pi,  // Circular blast direction (right)
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 100,
                minBlastForce: 5.0,
                maxBlastForce: 10.0,
                gravity: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}