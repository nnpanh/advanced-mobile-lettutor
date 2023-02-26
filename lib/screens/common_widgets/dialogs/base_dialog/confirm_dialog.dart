import 'package:flutter/material.dart';
import 'package:lettutor/screens/common_widgets/elevated_button.dart';
import 'package:lettutor/utils/utils.dart';

import '../../../../const/const_value.dart';
import '../../../../utils/default_style.dart';
import '../../chip_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onRightButton;
  final VoidCallback onLeftButton;
  final String leftButton;
  final String rightButton;
  final bool hasLeftButton;
  final Size size;

  const ConfirmDialog(
      {super.key,
      required this.content,
      required this.size, required this.title, required this.onRightButton, required this.onLeftButton, required this.leftButton, required this.rightButton, required this.hasLeftButton});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black26,
          )
        ],
      ),
      content: SizedBox(
        width: size.width*0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getMaxLineHeightByLines(context,2),
              child: Text(
                content,
                softWrap: true,
                style: bodyLarge(context)
                    ?.copyWith(fontSize: 16,),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            // const SizedBox(height: 24,),
            Row(
              children: [
                Expanded(child: Visibility(
                  visible: hasLeftButton,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: CustomElevatedButton(callback: onLeftButton, title: leftButton, radius: 0, buttonType: ButtonType.outlinedButton,)),
                )),
                Expanded(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: CustomElevatedButton(callback: onRightButton, title: rightButton, radius: 30, buttonType: ButtonType.filledButton,))),
              ],
            )
          ],
        ),
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
