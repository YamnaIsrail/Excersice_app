import 'package:flutter/material.dart';
import 'dart:async';

class TenseScreen extends StatefulWidget {
  final int day;
  final VoidCallback? navigateToNext;

  const TenseScreen({Key? key, required this.day, this.navigateToNext}) : super(key: key);

  @override
  _TenseScreenState createState() => _TenseScreenState();
}

class _TenseScreenState extends State<TenseScreen> {
  int countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 1) {
        timer.cancel();
        if (widget.navigateToNext != null) {
          widget.navigateToNext!();
        }
      }
      setState(() {
        countdown--;
      });
    });
  }

  void skipTimer() {
    _timer?.cancel();
    if (widget.navigateToNext != null) {
      widget.navigateToNext!();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TENSE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("$countdown", style: TextStyle(fontSize: 32)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: skipTimer, child: Text("Skip"))
          ],
        ),
      ),
    );
  }
}

