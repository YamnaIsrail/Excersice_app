import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';

import 'wait.dart';  // <-- Add this line for AnimationController
class RestScreen extends StatefulWidget {
  final int day;
  final int restDuration; // Dynamic rest duration
  const RestScreen({Key? key, required this.day, required this.restDuration}) : super(key: key);

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int restCountdown = 5;
  int initialRestTime = 5;

  @override
  void initState() {
    super.initState();
    restCountdown = widget.restDuration; // Set the rest duration dynamically
    initialRestTime = widget.restDuration;
    startRestTimer();
  }

  void startRestTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (restCountdown == 0) {
        timer.cancel();
        Navigator.pop(context);
      } else {
        setState(() {
          restCountdown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff2B0B4D)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("TAKE A REST", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600, color: Colors.white)),
              SizedBox(height: 20),
              CustomPaint(
                size: Size(220.0, 220.0),
                painter: CircleProgressPainter(
                    progress: (initialRestTime - restCountdown) / initialRestTime),
                child: Container(
                  width: 2 * 110.0,
                  height: 2 * 110.0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Text("$restCountdown", style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 20),


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6F50E5),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.7, // 70% of screen width
                      50), // Full width with minimum height

                ),
                onPressed: () {
                  setState(() {
                    restCountdown += 20;
                    initialRestTime  += 20;
                  });
                },
                child: Text("+ 20s"),
              ),
              TextButton(
                onPressed: () =>  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WaitWaitCountdownScreen(day: widget.day)),
                ),
                child: Text("SKIP", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CircleProgressPainter extends CustomPainter {
  final double progress;
  CircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    Paint progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    // Draw the circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    // Draw the progress arc
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      -pi / 2, // Start angle (top of the circle)
      sweepAngle, // Sweep angle based on the progress
      false, // Don't fill the arc, just stroke
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when progress changes
  }
}
