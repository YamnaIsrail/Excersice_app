import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';  // Add this import for Hive

import 'kegel_excercise_home.dart';
import 'kegel_excercises_pro/kegelDaysUnlocked_hive.dart';

void main() async{
  await Hive.initFlutter();  // This initializes Hive with the default path

  await KegelStorage.init(); // Ensure this is called before running the app

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: KegelExercisesScreen(),
    );
  }
}
