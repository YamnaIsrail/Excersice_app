import 'package:flutter/material.dart';
import 'dart:async';
import 'progress_circle.dart';

class RestScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final bool isAudio;

  RestScreen({required this.onContinue, required this.isAudio});

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int _counter = 5;
  int initialRestTime = 5;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_counter > 1) {
          setState(() {
            _counter--;
          });
        } else {
          _timer?.cancel();
          widget.onContinue(); // Continue after rest
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    int totalRestTime = initialRestTime; // Total rest time
    int timeSpentInRest = (totalRestTime - _counter).toInt(); // Time spent in rest
    double progress = timeSpentInRest / totalRestTime; // Calculate progress

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.06, 1.0],
            colors: [Color(0xff2B0B4D), Color(0xff141575)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: AnimatedOpacity(
                opacity:  1.0,
                duration: Duration(milliseconds: 300),
                child: Text(
                  "Take a Rest",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(220.0, 220.0),
                  painter: CircleProgressPainter(progress: progress),
                ),
                Container(
                  width: 2 * 110.0,
                  height: 2 * 110.0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      "$_counter",
                      style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_counter <= 5)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        initialRestTime += 20;
                        _counter += 20;
                      });
                    },
                    child: Text("+20s"),
                  ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onContinue();
                  },
                  child: Text("SKIP"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}