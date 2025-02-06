import 'package:excercise_app/kegel_excercises_pro/rest.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'wait.dart';

class BreathingApp extends StatefulWidget {
  final int totalDurationMinutes; // Accept total duration in minutes
  final int day; // Accept total duration in minutes

  BreathingApp({Key? key,
    required this.totalDurationMinutes,
    required this.day,
  }): super(key: key);



  @override
  _BreathingAppState createState() => _BreathingAppState();
}

class _BreathingAppState extends State<BreathingApp> with SingleTickerProviderStateMixin {
  int _counter = 5;
  Timer? _timer;
  String _state = "tense";
  int initialRestTime = 5;
  bool _isPaused = false;
  int _elapsedTime = 0; // To track the total elapsed time

  int totalDuration = 0; // Example: 10 minutes total duration (in seconds)
  late AnimationController _controller;
  late Animation<double> _animation;
  
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: pi * 2).animate(_controller);

    // Here we initialize the total duration by multiplying the passed totalDurationMinutes by 60 to get seconds
    totalDuration = widget.totalDurationMinutes * 60;
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }


  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_counter > 1) {
          setState(() {
            _counter--;
            _elapsedTime++;
          });
        } else {
          _nextState();
        }
      }

      // Check if the total duration is completed
      if (_elapsedTime >= totalDuration) {
        _timer?.cancel();
        _navigateToWaitWaitCountdownScreen(); // Navigate to the new screen when time is up
      }
    });
  }

  void _nextState() {
    setState(() {
      if (_state == "tense") {
        _state = "relax";
        _counter = 5;
      } else if (_state == "relax") {
        _state = "rest";
        _counter = 5;
        _isPaused = false;
      } else {
        _state = "tense";
        _counter = 5;
      }
    });
    _startCountdown();
  }

  void _navigateToWaitWaitCountdownScreen() {
    // Navigate to the new screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WaitWaitCountdownScreen(day:widget.day,)),
    );
  }

  void _togglePlayPause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _skipState(bool isForward) {
    setState(() {
      if (isForward) {
        _elapsedTime++; // Increment elapsed time for forward skips
        _nextState();
      } else {
        if (_state == "tense") {
          _state = "rest";
          _counter = 5;
        } else if (_state == "relax") {
          _state = "tense";
          _counter = 5;
        } else {
          _state = "relax";
          _counter = 5;
        }
      }
    });
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    int remainingTime =
        totalDuration - _elapsedTime; // Calculate remaining time

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: _state == "rest"
            ? BoxDecoration(color: Color(0xff2B0B4D))
            : BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.06, 1.0],
            colors: [Color(0xFF795DEA), Color(0xFFBA63F5)],
          ),
        ),
        child: Center(
          child: _state == "rest"
              ? _buildRestUI(remainingTime)
              : _buildTenseRelaxUI(remainingTime),
        ),
      ),
    );
  }
  Widget _buildTenseRelaxUI(int remainingTime) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: Size(250, 250),
              painter: BreathingCirclePainter(_animation.value),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _state.toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "$_counter",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Colors.white,
              onPressed: () => _skipState(false),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white54),
              child: IconButton(
                icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                color: Colors.white,
                onPressed: _togglePlayPause,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              color: Colors.white,
              onPressed: () => _skipState(true),
            ),
          ],
        ),
        SizedBox(height: 40),
        Text(
          "Remaining Time: ${remainingTime ~/ 60}:${remainingTime % 60}",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
  //
  // Widget _buildTenseRelaxUI(int remainingTime) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       AnimatedContainer(
  //         duration: Duration(seconds: 1),
  //         curve: Curves.easeInOut,
  //         decoration: BoxDecoration(
  //           color: Colors.white54,
  //           shape: BoxShape.circle,
  //         ),
  //         width: 250,
  //         height: 250,
  //         alignment: Alignment.center,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               _state.toUpperCase(),
  //               style: TextStyle(
  //                   fontSize: 30,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               "$_counter",
  //               style: TextStyle(
  //                   fontSize: 40,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.arrow_back_ios_rounded),
  //             color: Colors.white,
  //             onPressed: () => _skipState(false),
  //           ),
  //           Container(
  //             padding: EdgeInsets.all(5),
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle, color: Colors.white54),
  //             child: IconButton(
  //               icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
  //               color: Colors.white,
  //               onPressed: _togglePlayPause,
  //             ),
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.arrow_forward_ios_rounded),
  //             color: Colors.white,
  //             onPressed: () => _skipState(true),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 40),
  //       Text(
  //         "Remaining Time: ${remainingTime ~/ 60}:${remainingTime % 60}",
  //         style: TextStyle(fontSize: 16, color: Colors.white),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildRestUI(int remainingTime) {
    int totalRestTime = initialRestTime; // Total rest time
    int timeSpentInRest = totalRestTime - _counter; // Time spent in rest
    double progress = timeSpentInRest / totalRestTime; // Calculate progress

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "TAKE A REST",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(220.0, 220.0),
              painter: CircleProgressPainter(progress: progress)
            ),
            Container(
              width: 2 * 110.0,
              height: 2 * 110.0,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: Text(
                  "$_counter",
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
              onPressed: _nextState,
              child: Text("SKIP"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Remaining Time: ${remainingTime ~/ 60}:${remainingTime % 60}",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}

//custom Painter for Elliptical Expansion**
class BreathingCirclePainter extends CustomPainter {
  final double value;

  BreathingCirclePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white54..style = PaintingStyle.fill;

    // Dynamic width and height using sine and cosine for non-uniform expansion
    double width = 170 + 35 * sin(value); // Expands in X direction
    double height = 150 + 30 * cos(value); // Expands in Y direction

    // Draw ellipse
    canvas.drawOval(Rect.fromCenter(center: size.center(Offset.zero), width: width, height: height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
