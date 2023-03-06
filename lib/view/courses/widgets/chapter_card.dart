import 'package:flutter/material.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

class ChapterCard extends StatelessWidget {
  const ChapterCard(
      {super.key, required this.title, required this.clickAction});
  final VoidCallback clickAction;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: Colors.white,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
            title: Text(
              title,
              style: bodyLarge(context),
            ),
            onTap: clickAction));
  }
}
