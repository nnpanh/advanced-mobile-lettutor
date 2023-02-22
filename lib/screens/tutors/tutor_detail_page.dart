import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/screens/common_widgets/title_and_chips_schedule.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:readmore/readmore.dart';

import '../../const/const_value.dart';
import '../../model/tutor_model.dart';
import '../../utils/text_style.dart';
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
        appBar: appBar("Tutor's detail", context),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white30,
            padding: const EdgeInsets.fromLTRB(16, 16, 6, 16),
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
                          foregroundImage: NetworkImage(tutorData.avatarUrl ??
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
                            padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
                            child: Text(
                              "${tutorData.name}",
                              style: bodyLargeBold(context)?.copyWith(
                                  fontSize: 18,
                                  height: ConstValue.descriptionTextScale),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "${tutorData.nationality}",
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: ReadMoreText(
                    "${tutorData.description}",
                    trimLines: 4,
                    textAlign: TextAlign.justify,
                    style: bodyLarge(context)?.copyWith(
                        height: ConstValue.descriptionTextScale,
                        fontStyle: FontStyle.italic),
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
                              tutorData.isFavorite = !tutorData.isFavorite;
                            });
                          },
                          icon: tutorData.isFavorite
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                    options: tutorData.specialities, title: 'Languages'),
                TitleAndChips(
                    options: tutorData.specialities, title: 'Specialities'),
                TitleAndChipsSchedule(
                  size: size.width,
                  options: generateDayList(),
                  title: 'Available schedule',
                )
              ],
            ),
          ),
        ));
  }
}
