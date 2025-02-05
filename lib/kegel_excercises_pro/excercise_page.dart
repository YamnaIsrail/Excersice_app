import 'package:excercise_app/kegel_excercises_pro/rest.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  final int day;
  const ExerciseScreen({Key? key, required this.day}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int countdown = 3;
  bool isTensing = true;
  bool isPaused = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        if (countdown == 0) {
          timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RestScreen(day: widget.day)),
          );
        } else {
          setState(() {
            countdown--;
          });
        }
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void navigateToNext() {
    setState(() {
      isTensing = !isTensing;
      countdown = 3; // Reset countdown for the next state
    });
  }

  void navigateToPrevious() {
    setState(() {
      isTensing = !isTensing;
      countdown = 3; // Reset countdown for the previous state
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white54,
                  ),
                  child: Column(
                    children: [
                      Text(
                        isTensing ? "TENSE" : "RELAX",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "$countdown",
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous Button
                  if (!isTensing)
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 40),
                      onPressed: navigateToPrevious,
                    ),
                  if (isTensing) Icon(Icons.arrow_back_ios,
                          color: Colors.transparent,
                          size: 40),

                  // Pause/Continue Button
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                        ),
                        child: IconButton(
                          icon: Icon(
                            isPaused ? Icons.play_arrow : Icons.pause,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: togglePause,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 40),
                    onPressed: () {
                      if (isTensing) {
                        navigateToNext();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RestScreen(day: widget.day)),
                        );
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
