import 'package:flutter/material.dart';
import 'package:lettutor/utils/text_style.dart';

import '../../../model/export_model.dart';
import '../../../utils/utils.dart';
import '../../common_widgets/chip_button.dart';

class ReportDialogContent extends StatelessWidget {
  ReportDialogContent({super.key, required this.size});
  final Size size;
  final List<ReviewModel> listReview = generateReviewList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height * 0.5, // Change as per your requirement
        width: size.width * 0.8, // Change as per your requirement
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.report,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Help us know what's happening",
                  style: bodyLargeBold(context),
                ),
              ],
            ),
            ReportCheckList(),
            ChipButton(callback: () {}, title: 'Send')
          ],
        ));
  }
}

class ReportCheckList extends StatelessWidget {
  const ReportCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          value: null,
          onChanged: (bool? value) {},
        );
      },
    );
  }
}
