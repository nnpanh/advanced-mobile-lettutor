import 'package:flutter/material.dart';
import 'package:lettutor/screens/common_widgets/chip_button.dart';
import 'package:lettutor/screens/schedule/widgets/lesson_card.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../const/custom_color.dart';
import '../../utils/default_style.dart';
import '../../utils/utils.dart';
import '../tutors/widgets/tutor_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final lessonList = generateLessons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 36),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue, CustomColor.originalBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Lesson',
                      style: bodyLargeBold(context)
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              getDateString(DateTime.now(), TimeFormat.getDateAndTime),
                              style: bodyLarge(context)?.copyWith(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                              child: Container(
                                // alignment: Alignment.centerLeft,
                                child: ChipButton(callback: () {  }, title: '  Join  ', hasIcon: false, chipType: ButtonType.filledWhiteButton,

                          ),
                              ))
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                          onPressed: (){},
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
                          lessonData: lessonList[index], isHistoryCard: false, leftButton: 'Cancel', rightButton: 'Go to meeting', leftButtonCallback: () {  }, rightButtonCallback: () {  },);
                      })),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: NavigationIndex.schedulePage, context: context,),
    );
  }
}
