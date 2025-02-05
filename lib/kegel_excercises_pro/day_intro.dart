import 'package:flutter/material.dart';
import 'excercise_page.dart';
class ExcerciseDayScreen extends StatelessWidget {
  final int day;
  final int duration; // Dynamic duration (in minutes)

  const ExcerciseDayScreen({super.key, required this.day, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff647BCD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KEGEL EXERCISES",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Day $day",
              style: TextStyle(
                  color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "$duration min",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExerciseScreen(day: day,)),
                );
              },
              child: Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}