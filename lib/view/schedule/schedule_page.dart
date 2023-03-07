import 'package:flutter/material.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/dialogs/base_dialog/confirm_dialog.dart';
import 'package:lettutor/view/schedule/widgets/lesson_card.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../utils/utils.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final lessonList = generateLessons();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Image.asset(ImagesPath.calendar, fit: BoxFit.contain)),
                    Expanded(
                      flex: 3,
                      child: Text(
                          "Here is a list of booked lessons. You can track when will the lesson starts, join the meeting or cancel before 2 hours",
                          style: bodyLarge(context)?.copyWith(
                            color: Colors.black45
                          )
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
                    flex:7,
                    child: Text('My schedule', style: headLineMedium(context)?.copyWith(
                      fontSize: 30,
                    )),
                  ),
                  Expanded(flex:3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, MyRouter.analysis);
                          },
                          icon: const Icon(Icons.bar_chart),
                          color: Colors.blue,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, MyRouter.learningHistory);
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
                        return LessonCard(
                          lessonData: lessonList[index],
                          isHistoryCard: false,
                          leftButton: 'Cancel',
                          rightButton: 'Go to meeting',
                          leftButtonCallback: () {
                            onPressedCancel(context, size);
                          },
                          rightButtonCallback: () {},
                          iconButtonCallback: () {
                            onPressedLeaveNote(context, size);
                          },
                        );
                      })),
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
            title: 'Cancel lesson',
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Do you want to cancel this lesson?'),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Leave the reason why you cancel this lesson..',
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
            leftButton: 'Cancel',
            rightButton: 'Confirm',
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
            title: 'Send note',
            widget: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const TextField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Leave a note for your tutor before the lesson..',
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
            leftButton: 'Cancel',
            rightButton: 'Send',
            hasLeftButton: true,
          );
        });
  }

  void onPressedGoToMeeting() {}
}
