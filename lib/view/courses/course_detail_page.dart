import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/view/courses/widgets/chapter_card.dart';
import 'package:readmore/readmore.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../model/course_model.dart';
import '../../utils/default_style.dart';
import '../../utils/utils.dart';
import '../common_widgets/elevated_button.dart';


class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.courseModel});
  // final CourseModel courseModel;
//
//   @override
//   State<CourseDetailPage> createState() => _CourseDetailPageState();
// }
//
// class _CourseDetailPageState extends State<CourseDetailPage> {
  final CourseModel courseModel;

  // @override
  // void initState() {
  //   courseData = widget.courseModel;
  //   super.initState();
  // }

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
                Image(
                  width: double.maxFinite,
                  height: size.width * .75 - 32,
                  fit: BoxFit.fill,
                  image: NetworkImage(courseModel.illustrateUrl ??
                      "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    "${courseModel.title}",
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale),
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
                    margin: const EdgeInsets.fromLTRB(24,16,24,16),
                    child: CustomElevatedButton(
                        title: 'Discover',
                        buttonType: ButtonType.filledButton,
                        callback: () {
                          // Navigator.pushNamed(context, MyRouter.bookTutor,
                          //     arguments:
                          // TutorDetailArguments(courseModel: tutorData));
                        },
                        radius: 50),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child:
                  Text('Overview', style: headLineSmall(context)?.copyWith(
                      fontSize: 20
                  )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.question_mark_rounded, color: Colors.blue,),
                      const SizedBox(width: 12,),
                      Text("Why take this course",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(CourseOverView.takenReason,
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
                      const Icon(Icons.question_mark_rounded, color: Colors.blue,),
                      const SizedBox(width: 12,),
                      Text("What will you be able to do",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(CourseOverView.achievement,
                          style: bodyLarge(context),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child:
                      Text('Experience Level', style: headLineSmall(context)?.copyWith(
                        fontSize: 20
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.group_add, color: Colors.blue,),
                      const SizedBox(width: 12,),
                      Text("${courseModel.level}",
                      style: bodyLargeBold(context)?.copyWith(
                          height: ConstValue.courseNameTextScale)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Course Length', style: headLineSmall(context)?.copyWith(
                    fontSize: 20
                  )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.topic, color: Colors.blue,),
                      const SizedBox(width: 12,),
                      Text("${courseModel.chapterTitles.length} Topics",
                          style: bodyLargeBold(context)?.copyWith(
                              height: ConstValue.courseNameTextScale)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('List of Topic',
                      style: headLineSmall(context)?.copyWith(
                        fontSize: 20
                      )),
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
                          itemCount: courseModel.chapterTitles.length,
                          itemBuilder: (BuildContext context, int index) {
                            String title = "${index+1}. ${courseModel.chapterTitles[index]}";
                            return ChapterCard(title: title,clickAction: (){

                            },);
                          })),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text('Suggested Tutors',
                      style: headLineSmall(context)?.copyWith(
                          fontSize: 20
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: LimitedBox(
                    maxHeight: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseModel.suggestedTutor.length,
                      itemBuilder: (BuildContext context, int index) {
                        var course = courseModel.suggestedTutor[index];
                        return LimitedBox(
                          maxWidth: double.maxFinite,
                          maxHeight: double.maxFinite,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "•  $course   ",
                                    style: bodyLarge(context)?.copyWith(
                                        fontSize: 16,
                                        height: ConstValue.courseNameTextScale),
                                  ),
                                  TextSpan(
                                      text: 'More info',
                                      style: bodyLarge(context)
                                          ?.copyWith(color: Colors.blueAccent),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {

                                          Navigator.pushNamed(
                                              context, MyRouter.tutorDetail, arguments: TutorDetailArguments(tutorModel: testTutor()));
                                        })
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
