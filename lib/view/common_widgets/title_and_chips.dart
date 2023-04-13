import 'package:flutter/material.dart';

import '../../const/const_value.dart';
import 'chip_button.dart';
import 'default_style.dart';

class TitleAndChips extends StatefulWidget {
  const TitleAndChips({super.key, required this.input, required this.title});
  final String title;
  final String input;

  @override
  State<TitleAndChips> createState() => _TitleAndChipsState();
}

class _TitleAndChipsState extends State<TitleAndChips> {
  late List<String> options;

  @override
  void initState() {
    super.initState();
    options = widget.input.split(',');
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(widget.title, style: headLineSmall(context)),
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
