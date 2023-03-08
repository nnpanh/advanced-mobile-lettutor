import 'package:flutter/material.dart';
import 'package:lettutor/model/lesson_model.dart';
import 'package:lettutor/model/review_model.dart';
import 'package:lettutor/view/common_widgets/dialogs/create_review_dialog.dart';
import 'package:lettutor/view/schedule/widgets/lesson_card.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../utils/utils.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';
import '../common_widgets/dialogs/report_dialog.dart';

class LearningHistoryPage extends StatefulWidget {
  const LearningHistoryPage({super.key});

  @override
  State<LearningHistoryPage> createState() => _LearningHistoryPageState();
}

class _LearningHistoryPageState extends State<LearningHistoryPage> {
  late List<LessonModel> lessonList;
  late int selectedFilter = 0;
  List<String> filterOptions = [
    'Last 1 month',
    'Last 3 months',
    'Last 6 months'
  ];

  @override
  void initState() {
    lessonList = generateLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWithCustomAction(
          MyRouter.learningHistory,
          context,
          IconButton(
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              onPressedFilter(context, size);
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(filterOptions[selectedFilter],
                      style: headLineSmall(context)?.copyWith()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: LimitedBox(
                  maxHeight: double.maxFinite,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: lessonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        LessonModel lesson = lessonList[index];
                        return LessonCard(
                          lessonData: lesson,
                          isHistoryCard: true,
                          leftButton: 'Report',
                          rightButton: 'Add a review',
                          leftButtonCallback: () {
                            onPressedReport(size, lesson.tutorName, context);
                          },
                          rightButtonCallback: () {
                            ReviewModel newReview = ReviewModel(
                                lesson.tutorName,
                                lesson.tutorAvatarUrl,
                                "",
                                5,
                                DateTime.now());
                            onPressedCreateReview(
                                size,
                                context,
                                newReview,
                                getDateString(lesson.lessonStart,
                                    TimeFormat.getDateOnly));
                          },
                          iconButtonCallback: () {},
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

  void onPressedFilter(BuildContext context, Size size) {
    Widget child = LimitedBox(
      maxHeight: size.height * 0.5, // Change as per your requirement
      maxWidth: size.width, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filterOptions.length,
        itemBuilder: (BuildContext context, int index) {
          Widget? trailing;
          if (index == selectedFilter) {
            trailing = const Icon(
              Icons.check,
              color: Colors.blue,
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                ListTile(
                  title: Text(filterOptions[index]),
                  trailing: trailing,
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedFilter = index;
                    });
                  },
                ),
                const Divider(
                  height: 2,
                )
              ],
            ),
          );
        },
      ),
    );
    showBottomDialog(context, 'Select a filter', child);
  }
}
