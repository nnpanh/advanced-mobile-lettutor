import 'package:flutter/material.dart';

import '../../const/export_const.dart';
import '../../utils/text_style.dart';

class ChipButton extends StatelessWidget {
  final String chipType;
  final VoidCallback callback;
  final String title;
  final IconData? icon;
  final bool hasIcon;

  const ChipButton(
      {super.key,
      required this.callback,
      required this.title,
      this.icon,
      required this.hasIcon,
      required this.chipType});

  @override
  Widget build(BuildContext context) {
    switch (chipType) {
      case ButtonType.outlinedButton:
        return outlinedChip(context);
      case ButtonType.filledButton:
        return filledChip(context);
      case ButtonType.confirmButton:
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
            child: confirmChip(context));
      default:
        return outlinedChip(context);
    }
  }

  ActionChip filledChip(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      avatar: hasIcon
          ? Icon(
              icon,
              size: 18,
              color: Colors.blue,
            )
          : null,
      label: Text(title),
      labelStyle: bodyLarge(context)?.copyWith(color: Colors.white),
      backgroundColor: Colors.blue,
      elevation: 1,
      onPressed: callback,
    );
  }

  ActionChip confirmChip(BuildContext context) {
    return ActionChip(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        avatar: hasIcon
            ? Icon(
          icon,
          size: 18,
          color: Colors.blue,
        )
            : null,
        label: Text(title),
        labelStyle: bodyLarge(context)?.copyWith(color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 0,
        onPressed: callback,
    );
  }


  ActionChip outlinedChip(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      shape: const StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blue,
      )),
      avatar: hasIcon
          ? Icon(
              icon,
              size: 18,
              color: Colors.blue,
            )
          : null,
      label: Text(title),
      labelStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
      backgroundColor: Colors.transparent,
      elevation: 1,
      onPressed: callback,
    );
  }
}
