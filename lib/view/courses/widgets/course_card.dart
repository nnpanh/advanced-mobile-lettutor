import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../../config/router.dart';
import '../../../const/export_const.dart';

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
            CachedNetworkImage(
              width: double.maxFinite,
              height: size.width * .75 - 32,
              fit: BoxFit.fill,
              imageUrl: widget.courseData.imageUrl ?? "",
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "${widget.courseData.name}",
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
                "${AppLocalizations.of(context)!.level} ${widget.courseData.level}  •  ${widget.courseData.topics?.length} ${AppLocalizations.of(context)!.lessons}",
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
