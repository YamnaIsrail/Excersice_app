import 'package:excercise_app/kegel_questionaire_flow/kegel_screen1.dart';
import 'package:flutter/material.dart';


class KegelExercisesScreen extends StatelessWidget {
  const KegelExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(250, 152, 211, 1),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment(1, 0),
                end: Alignment(0, 1),
                colors: [
                  Color.fromRGBO(241, 65, 170, 0.48),
                  Color.fromRGBO(235, 29, 152, 0.11)
                ],
              ),
            ),
            width: double.maxFinite,


            child:  Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),

              height: 171,
              width: 393,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Kegel Exercises', style: TextStyle(
                    fontFamily: 'Roboto', // Default Material font
                    fontWeight: FontWeight.w600, // Similar to Semi-Bold
                    fontSize: 20, ),),
                  Image.asset("assets/kegel/flower.png",
                      height: 80,
                      width: 80,
                      color: Colors.pink)
                ],
              ),
            ),

          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.5),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffAED2F6), Color(0xffEBA5CF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                    title:  Text(
                      'Exercise Tips',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.lightbulb, color: Colors.yellow, size: 19,),
                    trailing: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen()));
                      },
                      icon: Icon(Icons.keyboard_double_arrow_right, size:19, color: Colors.blueAccent,),
                    )
                ),
              )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ExerciseDayTile(day: index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseDayTile extends StatelessWidget {
  final int day;
  const ExerciseDayTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    bool isUnlocked = day == 1; // Unlock only Day 1 for now

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Day $day'),
        subtitle: const Text('3 min'),
        trailing: isUnlocked
            ? ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DayScreen(day: day)),
            );
          },
          child: const Text('Start'),
        )
            : const Icon(Icons.lock),
      ),
    );
  }
}

class DayScreen extends StatelessWidget {
  final int day;
  const DayScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Day $day Exercise')),
      body: Center(
        child: Text(
          'Exercise for Day $day',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
