import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/screens/courses/widgets/chapter_card.dart';
import 'package:lettutor/screens/tutors/widgets/report_dialog_content.dart';
import 'package:readmore/readmore.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../model/course_model.dart';
import '../../utils/default_style.dart';
import '../common_widgets/dialogs/widget_dialog.dart';
import '../common_widgets/elevated_button.dart';
import '../common_widgets/title_and_chips.dart';


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
        appBar: appBar("Course Details", context),
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
                      height: ConstValue.descriptionTextScale,
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
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                )

              ],
            ),
          ),
        ));
  }

}
