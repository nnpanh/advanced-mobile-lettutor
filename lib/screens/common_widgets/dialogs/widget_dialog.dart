import 'package:flutter/material.dart';

class WidgetDialog extends StatelessWidget {
  final String title;
  final Widget widget;

  const WidgetDialog({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
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
      content: widget,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
