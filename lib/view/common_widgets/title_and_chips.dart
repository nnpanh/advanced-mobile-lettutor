import 'package:flutter/material.dart';

import '../../const/const_value.dart';
import 'chip_button.dart';
import 'default_style.dart';

class TitleAndChips extends StatefulWidget {
  const TitleAndChips({super.key, required this.input, required this.title, required this.type});
  final String title;
  final String input;
  final String type;

  @override
  State<TitleAndChips> createState() => _TitleAndChipsState();
}

class _TitleAndChipsState extends State<TitleAndChips> {
  late List<String> options;

  @override
  void initState() {
    super.initState();
    options = widget.input.split(',');

    switch(widget.type) {
      case TutorDetailListType.languages:
        for (var i = 0; i < options.length; i++) {
          options[i] = options[i].toUpperCase();
        }
        break;
      case TutorDetailListType.specialities:
        for (var i = 0; i < options.length; i++) {
          options[i] = getNameByKey(options[i]);
        }
        break;
        default:

    }
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

  String getNameByKey(String input) {
    var result = "";
    for (var element in Specialities.specialities) {
      if (input == element.key) {
        result = element.name!;
        continue;
      }
    }
    if (result != "") return result;

    for (var element in Specialities.topics) {
      if (input == element.key) {
        result = element.name!;
        continue;
      }
    }
    if (result != "") {
      return result;
    } else {
      return input.replaceAll("-", " ");
    }
  }
}
