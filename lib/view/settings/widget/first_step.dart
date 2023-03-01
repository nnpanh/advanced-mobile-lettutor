import 'package:flutter/material.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: const Text('Content for Step 1'));
  }
}
//https://educity.app/flutter/how-to-pick-an-image-from-gallery-and-display-it-in-flutter
