import 'package:flutter/material.dart';

import '../../../const/const_value.dart';
import '../../../utils/default_style.dart';
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

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
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
        width: size.width*0.8,
        child: Text(
          content,
          softWrap: true,
          style: bodyLarge(context)
              ?.copyWith(fontSize: 16, height: ConstValue.descriptionTextScale,),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: ChipButton(
            callback: onClose,
            title: 'Close',
            hasIcon: false,
            icon: null,
            chipType: ButtonType.confirmButton,
          ),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
