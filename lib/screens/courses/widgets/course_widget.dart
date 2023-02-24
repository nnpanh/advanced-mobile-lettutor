import 'package:flutter/material.dart';
import 'package:lettutor/utils/default_style.dart';

import '../../../const/export_const.dart';
import '../../../model/course_model.dart';

class CourseWidget extends StatefulWidget {
  const CourseWidget({super.key, required this.courseData});

  final CourseModel courseData;

  @override
  State<CourseWidget> createState() => CourseWidgetState();
}

class CourseWidgetState extends State<CourseWidget> {
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
              style: bodyLarge(context)?.copyWith(
                  height: ConstValue.descriptionTextScale,
                  color: CustomColor.greyTextColor),
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
              style: bodyLarge(context)
                  ?.copyWith(height: ConstValue.descriptionTextScale),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
