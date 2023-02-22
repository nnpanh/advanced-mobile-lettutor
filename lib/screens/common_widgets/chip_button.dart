import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

class ChipButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;

  const ChipButton({super.key, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      shape: const StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blue,
      )),
      avatar: const Icon(
        Icons.calendar_month,
        size: 18,
        color: Colors.blue,
      ),
      label: Text(title),
      labelStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
      backgroundColor: Colors.transparent,
      elevation: 1,
      onPressed: callback,
    );
  }
}
