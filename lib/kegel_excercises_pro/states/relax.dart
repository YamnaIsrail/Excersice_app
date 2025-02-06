import 'package:flutter/material.dart';
import 'dart:async';

class RelaxScreen extends StatefulWidget {
  final int day;
  final VoidCallback? navigateToNext;
  final VoidCallback? navigateToPrevious;

  const RelaxScreen({Key? key, required this.day, this.navigateToNext, this.navigateToPrevious}) : super(key: key);

  @override
  _RelaxScreenState createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
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

  void goBack() {
    _timer?.cancel();
    if (widget.navigateToPrevious != null) {
      widget.navigateToPrevious!();
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
            Text("RELAX", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("$countdown", style: TextStyle(fontSize: 32)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: goBack, child: Text("Previous")),
                ElevatedButton(onPressed: skipTimer, child: Text("Skip"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
