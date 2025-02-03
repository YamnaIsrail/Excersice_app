import 'package:flutter/material.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What’s are the benefits?"),
        actions: [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('- Sex life\nImprove blood circulation, tighten your vagina, and increase lubrication.'),
            SizedBox(height: 10),
            Text('- Pregnancy\nPrevents urinary incontinence, reduces labor pain, and speeds up recovery.'),
          ],
        ),
      ),
    );
  }
}

