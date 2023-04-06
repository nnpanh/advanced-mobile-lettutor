import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';
import 'package:lettutor/view/common_widgets/dialogs/report_dialog.dart';
import 'package:readmore/readmore.dart';

import '../../config/router.dart';
import '../../config/router_arguments.dart';
import '../../const/export_const.dart';
import '../../model/course_model.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/dialogs/show_reviews_dialog.dart';
import '../common_widgets/elevated_button.dart';
import '../common_widgets/title_and_chips.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key, required this.tutorModel});
  final TutorModel tutorModel;

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  late TutorModel tutorData;

  @override
  void initState() {
    tutorData = widget.tutorModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBarDefault(MyRouter.tutorDetail, context),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white30,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(16),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.transparent,
                          foregroundImage: NetworkImage(tutorData.avatar ??
                              "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Text(
                              "${tutorData.name}",
                              style: bodyLargeBold(context)?.copyWith(
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              // "${tutorData.nationality}",
                              "${tutorData.country}",
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.black38),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            child: RatingBar(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glow: false,
                              ignoreGestures: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              itemSize: 24,
                              onRatingUpdate: (double value) {},
                              ratingWidget: RatingWidget(
                                full:
                                    const Icon(Icons.star, color: Colors.amber),
                                empty: const Icon(Icons.star_border,
                                    color: Colors.amber),
                                half: const Icon(Icons.star_half,
                                    color: Colors.amber),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: ReadMoreText(
                    // "${tutorData.description}",
                    "${tutorData.bio}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              // tutorData.isFavorite = !tutorData.isFavorite;
                              //TODO: FAVORITE
                            });
                          },
                          icon: true
                              // icon: tutorData.isFavorite
                              ? const Icon(
                                  Icons.favorite_border,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                          padding: const EdgeInsets.all(8),
                        ),
                        Text('Favorite',
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.blue))
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            onPressedReport(size, tutorData.name, context);
                          },
                          icon: const Icon(
                            Icons.report_outlined,
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.all(8),
                        ),
                        Text('Report',
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.blue))
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            onPressedShowReviews(size, context);
                          },
                          icon: const Icon(
                            Icons.reviews_outlined,
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.all(8),
                        ),
                        Text('Reviews',
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.blue))
                      ],
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: const Image(
                        image: AssetImage(ImagesPath.youtube),
                        fit: BoxFit.fitWidth)),
                TitleAndChips(
                    // options: tutorData.specialities, title: 'Languages'),
                    options: [],
                    title: 'Languages'),
                TitleAndChips(options: [], title: 'Specialities'),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child:
                      Text('Suggested Courses', style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: LimitedBox(
                    maxHeight: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 0,
                      // itemCount: tutorData.suggestedCourses.length,
                      itemBuilder: (BuildContext context, int index) {
                        var course =
                            CourseModel(null, null, null, null, null, null);
                        return LimitedBox(
                          maxWidth: double.maxFinite,
                          maxHeight: double.maxFinite,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "•  ${course.title}   ",
                                style: bodyLarge(context)?.copyWith(
                                    fontSize: 16,
                                    height: ConstValue.courseNameTextScale),
                              ),
                              TextSpan(
                                  text: 'View',
                                  style: bodyLarge(context)
                                      ?.copyWith(color: Colors.blueAccent),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, MyRouter.courseDetail,
                                          arguments: CourseDetailArguments(
                                              courseModel: course));
                                    })
                            ])),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text('Interests', style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: ReadMoreText(
                    "${tutorData.interests}",
                    trimLines: 20,
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
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text('Teaching experience',
                      style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: ReadMoreText(
                    "${tutorData.experience}",
                    // "${tutorData.teachingExperience}",
                    trimLines: 20,
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
                    margin: const EdgeInsets.all(16),
                    child: CustomElevatedButton(
                        title: 'Book this tutor',
                        buttonType: ButtonType.filledButton,
                        callback: () {
                          Navigator.pushNamed(context, MyRouter.bookingDetail,
                              arguments:
                                  TutorDetailArguments(tutorModel: tutorData));
                        },
                        radius: 15),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
