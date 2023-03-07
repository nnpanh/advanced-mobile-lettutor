import 'package:flutter/material.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '* ',
          style: bodyLargeBold(context)?.copyWith(color: Colors.red)),
      TextSpan(text: label, style: bodyLargeBold(context)),
    ]));
  }
}
