import 'package:flutter/material.dart';

import '../../../const/const_value.dart';
import '../../../utils/text_style.dart';
import '../chip_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  final VoidCallback onClose;
  final Size size;

  const ConfirmDialog(
      {super.key,
      required this.content,
      required this.onClose,
      required this.size});

  @override
  Widget build(BuildContext context) {
    var maxLines = 3;

    return AlertDialog(
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Announcement',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.black26,
          )
        ],
      ),
      content: SizedBox(
        width: size.width * 0.8,
        height: 16 * maxLines * ConstValue.descriptionTextScale,
        child: Text(
          content,
          style: bodyLarge(context)
              ?.copyWith(fontSize: 16, height: ConstValue.descriptionTextScale),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: <Widget>[
        ChipButton(
          callback: onClose,
          title: 'Close',
          hasIcon: false,
          icon: null,
          chipType: ButtonType.filledButton,
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
