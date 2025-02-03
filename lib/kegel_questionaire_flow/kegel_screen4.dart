import 'package:flutter/material.dart';
class HowToDoKegelScreen extends StatelessWidget {
  const HowToDoKegelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to do Kegel?"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kegel requires a rhythmic contraction of pelvic floor muscles to strengthen them.'),
            const SizedBox(height: 20),
            Center(
              child: Image.asset('assets/pc_muscles.png', height: 150),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('How to find the pelvic floor muscles?'),
            ),
          ],
        ),
      ),
    );
  }
}
