import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/utils/text_style.dart';

import '../../const/custom_color.dart';
import '../../model/tutor_model.dart';

class TutorWidget extends StatefulWidget {
  const TutorWidget({super.key, required this.tutorData});

  final TutorModel tutorData;

  @override
  State<TutorWidget> createState() => TutorWidgetState();
}

class TutorWidgetState extends State<TutorWidget> {
  // late TutorModel tutorState;
  //
  // @override
  // void initState() {
  //   tutorState = widget.initData;
  //   super.initState();
  // }

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
                    foregroundImage: NetworkImage(widget.tutorData.avatarUrl ??
                        "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          "${widget.tutorData.name}",
                          style: bodyLargeBold(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "${widget.tutorData.nationality}",
                          style: bodyLarge(context)?.copyWith(
                            color: Colors.black38
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: RatingBar(
                          ignoreGestures: true,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemSize: 18,
                          onRatingUpdate: (double value) {  },
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
                            empty: const Icon(Icons.star_border, color: Colors.amber),
                            half: const Icon(Icons.star_half, color: Colors.amber),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: widget.tutorData.isFavorite
                      ? const Icon(Icons.favorite_outline, color: Colors.blue)
                      : const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: () {
                    //Todo: Truyen function click vao day, chi render lai dung trai tim
                  },
                ),
              ],
            ),
            Container(
              height: getDescriptionHeight(context),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                "${widget.tutorData.description}",
                style: bodyLarge(context)?.copyWith(height: 1.25),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              // padding: const EdgeInsets.all(16),
              child: ActionChip(
                padding: const EdgeInsets.fromLTRB(8,4,8,4),
                shape: const StadiumBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    )),
                avatar: const Icon(Icons.calendar_month,size: 18, color: Colors.blue,),
                label: const Text('Book'),
                labelStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
                backgroundColor: Colors.transparent,
                elevation: 1,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  double getDescriptionHeight(BuildContext context) {
    double textHeight =
        Theme.of(context).textTheme.bodyLarge?.fontSize?.toDouble() ?? 14;
    return textHeight * 1.25 * 5 + 16 * 2;
  }
}