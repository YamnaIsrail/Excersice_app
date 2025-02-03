import 'package:flutter/material.dart';
import 'kegel_screen2.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 20),
            const Text('Hi', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            const Text('May I share some knowledge about Kegel with you?'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WhatIsKegelScreen()),
                );
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Not now'),
            ),
          ],
        ),
      ),
    );
  }
}

