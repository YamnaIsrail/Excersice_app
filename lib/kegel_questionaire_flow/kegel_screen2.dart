import 'package:flutter/material.dart';

import 'kegel_screen4.dart';
import 'kegel_screen3.dart';

class WhatIsKegelScreen extends StatelessWidget {
  const WhatIsKegelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What's Kegel?"),
        actions: [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kegel is a form of exercise that strengthens your pelvic floor muscles, which support your uterus and bladder.',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BenefitsScreen()),
                );
              },
              child: const Text('What are the benefits?'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HowToDoKegelScreen()),
                );
              },
              child: const Text('How to do Kegel?'),
            ),
          ],
        ),
      ),
    );
  }
}
