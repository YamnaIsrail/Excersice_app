import 'package:excercise_app/kegel_excercises_pro/kegelDaysUnlocked_hive.dart';
import 'package:excercise_app/kegel_questionaire_flow/kegel_screen1.dart';
import 'package:flutter/material.dart';
import 'kegel_excercises_pro/day_intro.dart';

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 152,
              width: 393,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Kegel Exercises',
                    style: TextStyle(
                      fontFamily: 'Roboto', // Default Material font
                      fontWeight: FontWeight.w600, // Similar to Semi-Bold
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image.asset(
                      "assets/kegel/flower2.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IntroScreen()));
            },
            child: Align(
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
                      title: Text(
                        'Exercise Tips',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.lightbulb,
                        color: Colors.yellow,
                        size: 19,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntroScreen()));
                        },
                        icon: Icon(
                          Icons.keyboard_double_arrow_right,
                          size: 19,
                          color: Colors.blueAccent,
                        ),
                      )),
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ExerciseDayTile(
                    day: index + 1,
                    duration: (4 + (index ~/ 5) * 2) // Increases every 5 days
                    );
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
  final int duration;
  const ExerciseDayTile({super.key, required this.day, required this.duration});

  @override
  Widget build(BuildContext context) {
    int unlockedDay = KegelStorage.unlockedDay; // Get unlocked day from Hive
    bool isUnlocked = day <= unlockedDay; // Unlock days <= current unlocked day
    bool isLatestUnlockedDay = day == unlockedDay;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress line
        Column(
          children: [
            // Circle indicator for each day
            Container(
              height: 20,
              width: 20,
              child: Icon(
                Icons.circle,
                color: Colors.white,
                size: 14,
              ),
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.pink : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              height:
                  isLatestUnlockedDay ? 110 : 60, // Line height between days
              width: 2,
              color: isUnlocked
                  ? Colors.pink
                  : Colors.grey, // Yellow for unlocked days
            ),
          ],
        ),
        SizedBox(width: 5),

        // The exercise details
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ListTile(
                  title: Text('Day $day'),
                  subtitle: Text('$duration min'),
                  trailing: isUnlocked
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExcerciseDayScreen(
                                    duration: duration, day: day),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        )
                      : const Icon(Icons.lock),
                ),
                if (isLatestUnlockedDay)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width *
                        0.5, // 70% of the screen width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExcerciseDayScreen(
                                  duration: duration, day: day),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEB1D98),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity,
                            50), // Full width with minimum height
                      ),
                      child: ListTile(
                        title: Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600, // Similar to Semi-Bold
                            fontSize: 18,
                          ),
                        ),
                        leading: Icon(Icons.play_arrow_sharp, color: Colors.white, size: 18,),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
