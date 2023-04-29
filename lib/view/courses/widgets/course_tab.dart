import 'package:flutter/material.dart';
import 'package:lettutor/data/repositories/course_repository.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
import 'package:provider/provider.dart';

import 'course_card.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({super.key, required this.tabType});
  final String tabType;

  @override
  State<StatefulWidget> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  bool _hasFetch = false;
  List<CourseModel> courseList = [];

  @override
  Widget build(BuildContext context) {
    if (!_hasFetch) {
    callAPIGetCourseList(1, CourseRepository(), Provider.of<AuthProvider>(context));
  }

  return !_hasFetch
      ? const LoadingFilled()
      : ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: courseList.length,
        itemBuilder: (BuildContext context, int index) {
          return CourseCard(courseData: courseList[index]);
        });
  }

  Future<void> callAPIGetCourseList(int page, CourseRepository courseRepository, AuthProvider authProvider) async {
    await courseRepository.getCourseListWithPagination(
        accessToken: authProvider.token?.access?.token??"",
        page: page,
        size: 10,
        onSuccess: (response) async {
          setState(() {
            courseList = response;
            _hasFetch = true;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

}
