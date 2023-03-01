import 'package:flutter/material.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/utils/default_style.dart';

class SecondStep extends StatefulWidget {
  const SecondStep({super.key});

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
                'Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality.',
                style: bodyLarge(context)?.copyWith(
                    height: ConstValue.courseNameTextScale,
                    color: Colors.black45))),
        Row(children: [
          Image.asset(ImagesPath.logo, fit: BoxFit.contain),
          Expanded(child: Text('Hehe'))
        ])
      ],
    );
  }
}
