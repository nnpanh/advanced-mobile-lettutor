import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/view/courses/widgets/chapter_card.dart';
import 'package:readmore/readmore.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../model/course/course_model.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/elevated_button.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.courseModel});

  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBarDefault(MyRouter.courseDetail, context),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  width: double.maxFinite,
                  height: size.width * .75 - 32,
                  fit: BoxFit.fill,
                  imageUrl: courseModel.imageUrl ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagesPath.error,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    "${courseModel.name}",
                    style: headLineSmall(context)
                        ?.copyWith(height: ConstValue.courseNameTextScale),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: ReadMoreText(
                    "${courseModel.description}",
                    trimLines: 4,
                    textAlign: TextAlign.justify,
                    style: bodyLarge(context)?.copyWith(
                      color: CustomColor.greyTextColor,
                    ),
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: ' Show less',
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    child: CustomElevatedButton(
                        title: 'Discover',
                        buttonType: ButtonType.filledButton,
                        callback: () {
                          Navigator.pushNamed(context, MyRouter.lessonDetail,
                              arguments: LessonDetailArguments(
                                  title:
                                      courseModel.topics?[0].name ?? "No title",
                                  pdfUrl: courseModel.topics?[0].nameFile ??
                                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'));
                        },
                        radius: 50),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Overview',
                      style: headLineSmall(context)?.copyWith(fontSize: 20)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Why take this course",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale))
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          courseModel.reason ?? CourseOverView.takenReason,
                          style: bodyLarge(context),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("What will you be able to do",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale))
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          courseModel.purpose ?? CourseOverView.achievement,
                          style: bodyLarge(context),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Experience Level',
                      style: headLineSmall(context)?.copyWith(fontSize: 20)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.group_add,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("${courseModel.level}",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Course Length',
                      style: headLineSmall(context)?.copyWith(fontSize: 20)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.topic,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("${courseModel.topics?.length} Topics",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('List of Topic',
                      style: headLineSmall(context)?.copyWith(fontSize: 20)),
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
                          itemCount: courseModel.topics?.length,
                          itemBuilder: (BuildContext context, int index) {
                            String title =
                                "${index + 1}. ${courseModel.topics?[index].name}";
                            return ChapterCard(
                              title: title,
                              clickAction: () {
                                Navigator.pushNamed(
                                    context, MyRouter.lessonDetail,
                                    arguments: LessonDetailArguments(
                                        title:
                                            courseModel.topics?[index].name ??
                                                "No title",
                                        pdfUrl: courseModel
                                                .topics?[index].nameFile ??
                                            'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'));
                              },
                            );
                          })),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Categories',
                      style: headLineSmall(context)?.copyWith(fontSize: 20)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: LimitedBox(
                    maxHeight: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseModel.categories?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var course = courseModel.categories?[index];
                        return LimitedBox(
                          maxWidth: double.maxFinite,
                          maxHeight: double.maxFinite,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "•  ${course?.title}   ",
                                style: bodyLarge(context)?.copyWith(
                                    fontSize: 16,
                                    height: ConstValue.courseNameTextScale),
                              ),
                              if (course?.description != null)
                                TextSpan(
                                    text: ' - ${course?.description}',
                                    style: bodyLarge(context))
                            ])),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
