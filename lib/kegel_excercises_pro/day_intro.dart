import 'package:flutter/material.dart';
import 'excercise_page.dart';

class ExcerciseDayScreen extends StatelessWidget {
  final int day;
  final int duration; // Dynamic duration (in minutes)
  final int totalcount;

  const ExcerciseDayScreen({super.key, required this.day,required this.totalcount, required this.duration});

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
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width *
                  0.7, //
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize:  Size(
                     double.infinity, 50), // Full width with minimum height
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BreathingApp(
                      totalCount: totalcount,
                      totalDurationMinutes: duration,
                      day: day,))

                  );
                },
                child: Center(
                  child: ListTile(
                                        title: Text("Start", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    leading: Icon(Icons.play_arrow_sharp, color: Colors.black,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}