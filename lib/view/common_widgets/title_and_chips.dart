import 'package:flutter/material.dart';

import '../../const/const_value.dart';
import '../../utils/default_style.dart';
import 'chip_button.dart';

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
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Wrap(
                    children: options
                        .map((item) => Container(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChipButton(
                                callback: () {},
                                title: item,
                                hasIcon: false,
                                chipType: ButtonType.outlinedButton,
                              ),
                            ))
                        .toList()
                        .cast<Widget>(),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
