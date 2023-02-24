import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../../utils/default_style.dart';

class TitleAndChips extends StatelessWidget {
  const TitleAndChips({super.key, required this.options, required this.title});
  final List<String> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<String> test = [
      'Hehe',
      'Hehe',
      'Hehe',
      'Hehe',
      'Hehe',
      'Hehe',
      'Hehe',
      'Hehe',
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(title, style: headLineSmall(context)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: ChipsChoice<int>.single(
                    value: 0,
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: test,
                      value: (i, v) => i,
                      label: (i, v) => v,
                      // tooltip: (i, v) => v,
                    ),
                    wrapped: true,
                    // choiceCheckmark: true,
                    choiceStyle: C2ChipStyle.outlined(
                      color: Colors.blue,
                      backgroundColor: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    onChanged: (value) {}),
              ),
            ],
          ),
        )
      ],
    );
  }
}
