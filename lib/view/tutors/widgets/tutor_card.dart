import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../../config/router.dart';
import '../../../config/router_arguments.dart';
import '../../../const/export_const.dart';
import '../../../utils/utils.dart';
import '../../common_widgets/chip_button.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({super.key, required this.tutorData, required this.isFavor, required this.onClickFavorite});

  final TutorModel tutorData;
  final bool isFavor;
  final VoidCallback onClickFavorite;

  @override
  State<TutorCard> createState() => TutorCardState();
}

class TutorCardState extends State<TutorCard> {
  late bool isFavored;

  @override
  void initState() {
    super.initState();
    isFavored = widget.isFavor;
  }


  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.transparent,
                    foregroundImage: NetworkImage(widget.tutorData.avatar ?? ""),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                        // horizontal: 16, vertical: 12),
                        child: Text(
                          "${widget.tutorData.name}",
                          style: bodyLargeBold(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "${widget.tutorData.country}",
                          // "${widget.tutorData.nationality}",
                          style: bodyLarge(context)
                              ?.copyWith(color: CustomColor.greyTextColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: RatingBar(
                          ignoreGestures: true,
                          initialRating: widget.tutorData.rating??0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                          itemSize: 18,
                          onRatingUpdate: (double value) {},
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
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
                IconButton(
                  icon: !isFavored
                      ? const Icon(Icons.favorite_outline, color: Colors.blue)
                      : const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: () {
                    widget.onClickFavorite();
                    setState(() {
                      isFavored = !isFavored;
                    });
                  },
                ),
              ],
            ),
            Container(
              height: getDescriptionHeight(context),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                "${widget.tutorData.bio}",
                // "${widget.tutorData.description}",
                style: bodyLarge(context)
                    ?.copyWith(color: CustomColor.greyTextColor),
                textAlign: TextAlign.justify,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                // padding: const EdgeInsets.all(16),
                child: ChipButton(
                  title: 'Book',
                  icon: Icons.calendar_month,
                  hasIcon: true,
                  chipType: ButtonType.outlinedButton,
                  callback: () {
                    Navigator.pushNamed(context, MyRouter.tutorDetail,
                        arguments:
                            TutorDetailArguments(tutorModel: widget.tutorData));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
