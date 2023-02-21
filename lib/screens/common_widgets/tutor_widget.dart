import 'package:flutter/material.dart';

class TutorWidget extends StatefulWidget{
  const TutorWidget({super.key});

  @override
  State<TutorWidget> createState() => TutorWidgetState();

}

class TutorWidgetState extends State<TutorWidget> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('Hehe'),
    );
  }

}