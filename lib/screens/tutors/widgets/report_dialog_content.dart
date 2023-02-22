import 'package:flutter/material.dart';
import 'package:lettutor/utils/text_style.dart';

import '../../../model/export_model.dart';
import '../../../utils/utils.dart';
import '../../common_widgets/chip_button.dart';

class ReportModel {
  bool isChecked = false;
  final String content;

  ReportModel(this.content, this.isChecked);
}

class ReportDialogContent extends StatefulWidget {
  const ReportDialogContent({super.key, required this.size});
  final Size size;

  @override
  State<ReportDialogContent> createState() => ReportDialogContentState();
}

class ReportDialogContentState extends State<ReportDialogContent> {
  late List<ReportModel> listReport;

  @override
  void initState() {
    listReport = [
      ReportModel("This tutor is pretending to be someone else/This tutor profile is fake.", false),
      ReportModel("This tutor' courses is from someone else.", false),
      ReportModel("This tutor is harassing/annoying me.", false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.report,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Help us know what's happening",
                style: bodyLargeBold(context),
              ),
            ],
          ),
        ),
        ReportCheckList(report: listReport[0],onChanged: () {
          setState(() {
            onPressed(0);
          });
          },),
        ReportCheckList(report: listReport[1],onChanged: () {
          setState(() {
            onPressed(1);
          });
        },),
        ReportCheckList(report: listReport[2],onChanged: () {
          setState(() {
            onPressed(2);
          });
        },),
        ChipButton(callback: () {}, title: 'Send', hasIcon: false, icon: null,)
      ],
    );
  }

  void onPressed(int index) {
    var selected = listReport[index];
    listReport[index] = ReportModel(selected.content, !selected.isChecked);
    print(listReport[index].isChecked);
  }
}

class ReportCheckList extends StatelessWidget {
  const ReportCheckList({super.key, required this.report, required this.onChanged});
  final ReportModel report;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(report.content),
          value: report.isChecked,
          onChanged: (bool? value) {
            onChanged();
          },
        );
  }
}
