import 'package:flutter/material.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../../config/router.dart';
import '../../../const/export_const.dart';
import '../../../model/course_model.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key, required this.courseData});

  final CourseModel courseData;

  @override
  State<CourseCard> createState() => CourseCardState();
}

class CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(MyRouter.courseDetail,
              arguments: CourseDetailArguments(courseModel: widget.courseData));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: double.maxFinite,
              height: size.width * .75 - 32,
              fit: BoxFit.fill,
              image: NetworkImage(widget.courseData.illustrateUrl ??
                  "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "${widget.courseData.title}",
                style: headLineSmall(context)?.copyWith(
                    height: ConstValue.courseNameTextScale, fontSize: 20),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${widget.courseData.description}",
                style: bodyLarge(context)
                    ?.copyWith(color: CustomColor.greyTextColor),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                softWrap: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Text(
                "${widget.courseData.level}  •  ${widget.courseData.chapterTitles.length} Lessons",
                style: bodyLarge(context),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
