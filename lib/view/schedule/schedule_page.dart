import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/dialogs/base_dialog/confirm_dialog.dart';
import 'package:lettutor/view/schedule/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

import '../../config/router.dart';
import '../../config/router_arguments.dart';
import '../../const/const_value.dart';
import '../../data/repositories/booking_repository.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final lessonList = [];
  bool _hasFetch = false;

  //Pagination
  bool _loading = true;
  final int perPage = 5;
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.asset(ImagesPath.calendar,
                            fit: BoxFit.contain)),
                    Expanded(
                      flex: 3,
                      child: Text(AppLocalizations.of(context)!.hereIsAList,
                          style: bodyLarge(context)
                              ?.copyWith(color: Colors.black45)
                          // ?.copyWith(color: Colors.white, fontSize: 18),
                          ),
                    ),
                  ],
                )),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(AppLocalizations.of(context)!.mySchedule,
                        style: headLineMedium(context)?.copyWith(
                          fontSize: 30,
                        )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRouter.analysis);
                          },
                          icon: const Icon(Icons.bar_chart),
                          color: Colors.blue,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRouter.learningHistory);
                          },
                          icon: const Icon(Icons.history),
                          color: Colors.blue,
                          iconSize: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _hasFetch
                ? lessonList.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: lessonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return LessonCard(
                                    lessonData: lessonList[index],
                                    isHistoryCard: false,
                                    leftButton:
                                        AppLocalizations.of(context)!.cancel,
                                    rightButton: AppLocalizations.of(context)!
                                        .goToMeeting,
                                    leftButtonCallback: () {
                                      onPressedCancel(context, size);
                                    },
                                    rightButtonCallback: () {
                                      onPressedGoToMeeting();
                                    },
                                    iconButtonCallback: () {
                                      onPressedLeaveNote(context, size);
                                    },
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
                                  callApiGetListSchedules(number,
                                      BookingRepository(), authProvider);
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
                    height: size.height * 0.5,
                    child: const Center(child: CircularProgressIndicator()),
                  )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: NavigationIndex.schedulePage,
        context: context,
      ),
    );
  }

  void onPressedCancel(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            content: null,
            title: AppLocalizations.of(context)!.cancelLesson,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.doYouWantToCancel),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.leaveReasonWhyCancel,
                    ),
                  ),
                ),
              ],
            ),
            size: size,
            onRightButton: () {
              Navigator.of(context).pop();
            },
            onLeftButton: () {
              Navigator.of(context).pop();
            },
            leftButton: AppLocalizations.of(context)!.cancel,
            rightButton: AppLocalizations.of(context)!.confirm,
            hasLeftButton: true,
          );
        });
  }

  void onPressedLeaveNote(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            content: null,
            title: AppLocalizations.of(context)!.sendNote,
            widget: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.leaveANote,
                ),
              ),
            ),
            size: size,
            onRightButton: () {
              Navigator.of(context).pop();
            },
            onLeftButton: () {
              Navigator.of(context).pop();
            },
            leftButton: AppLocalizations.of(context)!.cancel,
            rightButton: AppLocalizations.of(context)!.send,
            hasLeftButton: true,
          );
        });
  }

  void onPressedGoToMeeting() {
    Navigator.of(context).pushNamed(MyRouter.joinMeeting,
        arguments: BookingInfoArguments(upcomingLesson: lessonList.first));
  }

  Future<void> callApiGetListSchedules(int page,
      BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getIncomingLessons(
        accessToken: authProvider.token?.access?.token ?? "",
        page: page,
        perPage: 20,
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
    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.insert(0, value);
      }
    }

    setState(() {
      _hasFetch = true;
    });
  }
}
