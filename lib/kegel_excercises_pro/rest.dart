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

  void _togglePlayPause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B0B4D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TAKE A REST",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(220.0, 220.0),
                  painter: CircleProgressPainter(progress: (5 - _counter) / 5),
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
                        _counter += 20;
                      });
                    },
                    child: Text("+20s"),
                  ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _togglePlayPause,
                  child: Text(_isPaused ? "RESUME" : "PAUSE"),
                ),
              ],
            ),
            SizedBox(height: 20),
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