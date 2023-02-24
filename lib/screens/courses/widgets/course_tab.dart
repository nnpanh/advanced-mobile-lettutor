import 'package:flutter/material.dart';
import 'package:lettutor/utils/utils.dart';

import '../../../model/course_model.dart';
import 'course_card.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({super.key, required this.tabType});
  final String tabType;

  @override
  State<StatefulWidget> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  List<CourseModel> courseList = generateCourses();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: courseList.length,
        itemBuilder: (BuildContext context, int index) {
          return CourseCard(courseData: courseList[index]);
        });
  }
}
