import 'package:flutter/material.dart';
import 'package:lettutor/utils/default_style.dart';

void showBottomDialog(BuildContext context, String title, Widget widget) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer, builder: (BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: headLineSmall(context),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 16,
              ),
              widget
            ],
          ),
    );
  },
  );
}