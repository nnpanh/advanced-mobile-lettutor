import 'package:flutter/material.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({super.key});

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: const Text(
        'You have pushed the button this many times:',
      ),
    );
  }
}
