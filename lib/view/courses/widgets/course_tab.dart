import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:lettutor/data/repositories/course_repository.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/providers/course_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
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
  bool _loading = true;
  final int perPage = 5;

  //Pagination
  int currentPage = 1;
  int maximumPage = 1;
  int numberOfShowPages = 0;

  List<CourseModel> courseList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    if (!_hasFetch || courseProvider.reloadFlag) {
      if (widget.tabType == "course") {
        callAPIGetCourseList(
            1, CourseRepository(), courseProvider, authProvider);
      } else if (widget.tabType == "ebook") {
        callAPIGetEbookList(
            1, CourseRepository(), courseProvider, authProvider);
      }
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _loading
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.5,
                    maxHeight: size.height,
                    minWidth: size.width * 0.5,
                    maxWidth: size.width,
                  ),
                  child: const LoadingFilled())
              : courseList.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: courseList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CourseCard(courseData: courseList[index]);
                      })
                  : Center(
                      child: Text(
                          style: headLineSmall(context), "No match result")),
          Container(
              padding: const EdgeInsets.all(16),
              child: (courseList.isNotEmpty)
                  ? Pagination(
                      paginateButtonStyles: paginationStyle(context),
                      prevButtonStyles: prevButtonStyles(context),
                      nextButtonStyles: nextButtonStyles(context),
                      onPageChange: (number) {
                        setState(() {
                          _loading = true;
                          currentPage = number;
                        });
                        //Call API
                        if (widget.tabType == "course") {
                          callAPIGetCourseList(number, CourseRepository(),
                              courseProvider, authProvider);
                        } else if (widget.tabType == "ebook") {
                          callAPIGetEbookList(number, CourseRepository(),
                              courseProvider, authProvider);
                        }
                      },
                      useGroup: false,
                      totalPage: maximumPage,
                      show: numberOfShowPages,
                      currentPage: currentPage,
                    )
                  : const SizedBox())
        ],
      ),
    );
  }

  void calculatePages(int totalItems) {
    maximumPage = (totalItems / perPage).ceil();
    numberOfShowPages = getShowPagesBasedOnPages(maximumPage);
  }

  Future<void> callAPIGetCourseList(int page, CourseRepository courseRepository,
      CourseProvider courseProvider, AuthProvider authProvider) async {
    //Stop reload
    courseProvider.setReloadFlag();

    await courseRepository.getCourseListWithPagination(
        accessToken: authProvider.token?.access?.token ?? "",
        search: courseProvider.searchKeys,
        page: page,
        size: perPage,
        onSuccess: (response, total) async {
          setState(() {
            courseList = response;
            _hasFetch = true;
            currentPage = page;
            calculatePages(total);
            _loading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  Future<void> callAPIGetEbookList(int page, CourseRepository courseRepository,
      CourseProvider courseProvider, AuthProvider authProvider) async {
    //Stop reload
    courseProvider.setReloadFlag();

    await courseRepository.getEbookListWithPagination(
        accessToken: authProvider.token?.access?.token ?? "",
        search: courseProvider.searchKeys,
        page: page,
        size: perPage,
        onSuccess: (response, total) async {
          setState(() {
            courseList = response;
            _hasFetch = true;
            currentPage = page;
            calculatePages(total);
            _loading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
