import 'package:flutter/material.dart';
import 'package:lettutor/data/repositories/booking_repository.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/dialogs/create_review_dialog.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
import 'package:lettutor/view/schedule/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../model/tutor/tutor_extracted_info.dart';
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
  final List<BookingInfo> lessonList = [];
  late int selectedFilter = 0;
  List<String> filterOptions = [
    'Last 1 month',
    'Last 3 months',
    'Last 6 months'
  ];
  bool _hasFetch = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (!_hasFetch) {
      callApiGetListSchedules(1, BookingRepository(), Provider.of<AuthProvider>(context));
    }
    return !_hasFetch? const LoadingFilled():Scaffold(
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
                        BookingInfo lesson = lessonList[index];
                        return LessonCard(
                          lessonData: lesson,
                          isHistoryCard: true,
                          leftButton: 'Report',
                          rightButton: 'Add a review',
                          leftButtonCallback: () {
                            onPressedReport(size, lesson.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name, context);
                          },
                          rightButtonCallback: () {
                            CreateReviewArguments reviewArguments =
                            CreateReviewArguments(lesson.id, lesson.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.id, 5, "");

                            onPressedCreateReview(
                                size,
                                context,
                                reviewArguments,
                                lesson.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name,
                              lesson.scheduleDetailInfo?.scheduleInfo?.date
                            );
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
      maxHeight: size.height * 0.8, // Change as per your requirement
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


  Future<void> callApiGetListSchedules(int page, BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getLearningHistory(
        accessToken: authProvider.token?.access?.token??"",
        page: page,
        perPage: 20,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response) async {
          _filterListScheduleFromApi(response);
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  void _filterListScheduleFromApi(List<BookingInfo> listBooking) {
    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.add(value);
      }
    }
    setState(() {
      _hasFetch = true;
    });
  }
}
