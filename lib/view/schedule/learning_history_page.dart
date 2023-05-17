import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:lettutor/data/repositories/booking_repository.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/view/common_widgets/dialogs/create_review_dialog.dart';
import 'package:lettutor/view/schedule/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

import '../common_widgets/default_style.dart';
import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';
import '../common_widgets/dialogs/report_dialog.dart';

class LearningHistoryPage extends StatefulWidget {
  const LearningHistoryPage({super.key});

  @override
  State<LearningHistoryPage> createState() => _LearningHistoryPageState();
}

class _LearningHistoryPageState extends State<LearningHistoryPage> {
  List<BookingInfo> lessonList = [];
  late int selectedFilter = 0;
  bool _hasFetch = false;

  //Pagination
  bool _loading = true;
  int perPage = 5;
  int currentPage = 1;
  int maximumPage = 1;
  int numberOfShowPages = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetch) {
      callApiGetListSchedules(1, BookingRepository(),
          Provider.of<AuthProvider>(context, listen: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);

    List<int> filterOptions = [5, 10, 20, 50, 100];

    return Scaffold(
      appBar: appBarWithCustomAction(
          AppLocalizations.of(context)!.learningHistory,
          context,
          IconButton(
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              onPressedFilter(context, size, filterOptions);
            },
          )),
      body: SingleChildScrollView(
        child: !_loading
            ? lessonList.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
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
                                leftButton:
                                    AppLocalizations.of(context)!.report,
                                rightButton:
                                    AppLocalizations.of(context)!.addAReview,
                                leftButtonCallback: () {
                                  onPressedReport(
                                      size,
                                      lesson.scheduleDetailInfo?.scheduleInfo
                                          ?.tutorInfo?.name,
                                      context,
                                      lesson.scheduleDetailInfo?.scheduleInfo
                                              ?.tutorInfo?.id ??
                                          "");
                                },
                                rightButtonCallback: () {
                                  CreateReviewArguments reviewArguments =
                                      CreateReviewArguments(
                                          lesson.id,
                                          lesson.scheduleDetailInfo
                                              ?.scheduleInfo?.tutorInfo?.id,
                                          5,
                                          "");

                                  onPressedCreateReview(
                                      size,
                                      context,
                                      reviewArguments,
                                      lesson.scheduleDetailInfo?.scheduleInfo
                                          ?.tutorInfo?.name,
                                      lesson.scheduleDetailInfo?.scheduleInfo
                                          ?.date);
                                },
                                iconButtonCallback: () {},
                              );
                            }),
                      ),
                      Container(
                          padding: const EdgeInsets.all(16),
                          child: Pagination(
                            paginateButtonStyles: paginationStyle(context),
                            prevButtonStyles: prevButtonStyles(context),
                            nextButtonStyles: nextButtonStyles(context),
                            onPageChange: (number) {
                              setState(() {
                                _loading = true;
                                currentPage = number;
                              });
                              //Call API
                              callApiGetListSchedules(
                                  number, BookingRepository(), authProvider);
                            },
                            useGroup: false,
                            totalPage: maximumPage,
                            show: numberOfShowPages,
                            currentPage: currentPage,
                          ))
                    ],
                  )
                : SizedBox(
                    height: size.height * 0.5,
                    child: Center(
                      child: Text("No booking found",
                          style: bodyLarge(context)
                              ?.copyWith(color: Colors.black45)),
                    ),
                  )
            : SizedBox(
                height: size.height * 0.7,
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  void onPressedFilter(
      BuildContext context, Size size, List<int> filterOptions) {
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
                  title: Text("${filterOptions[index]}"),
                  trailing: trailing,
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedFilter = index;
                      perPage = filterOptions[index];
                      _loading = true;
                      callApiGetListSchedules(1, BookingRepository(),
                          Provider.of<AuthProvider>(context, listen: false));
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
    showBottomDialog(
        context, AppLocalizations.of(context)!.selectAFilter, child, false);
  }

  Future<void> callApiGetListSchedules(int page,
      BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getLearningHistory(
        accessToken: authProvider.token?.access?.token ?? "",
        page: page,
        perPage: perPage,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response, total) async {
          _filterListScheduleFromApi(response);
          currentPage = page;
          maximumPage = (total / perPage).ceil();
          numberOfShowPages = getShowPagesBasedOnPages(maximumPage);
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  void _filterListScheduleFromApi(List<BookingInfo> listBooking) {
    lessonList = [];

    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.add(value);
      }
    }
    setState(() {
      _hasFetch = true;
      _loading = false;
    });
  }
}
