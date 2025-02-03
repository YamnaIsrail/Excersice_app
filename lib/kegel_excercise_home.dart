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
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children:  [
               Container(
                 height: 171,
                 width: 393,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Kegel Exercises', style: TextStyle(fontSize: 30),),
                     Icon(Icons.local_florist, size: 80, color: Colors.pink)
                   ],
                 ),
               ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title:  Text(
                      'Exercise Tips',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.lightbulb, color: Colors.yellow, size: 19,),
                    trailing: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen()));
                      },
                      icon: Icon(Icons.keyboard_double_arrow_right, size:19, color: Colors.blueAccent,),
                    )
                  )
                ),
              ],
            ),
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
