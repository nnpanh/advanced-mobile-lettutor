import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';

import '../default_style.dart';
import 'base_dialog/widget_dialog.dart';

void onPressedShowReviews(Size size, BuildContext context, List<TutorFeedback> listReview) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return WidgetDialog(
            title: 'Reviews', widget: ReviewDialogContent(size: size, listReview: listReview));
      });
}

class ReviewDialogContent extends StatelessWidget {
  const ReviewDialogContent({super.key, required this.size, required this.listReview});
  final Size size;
  final List<TutorFeedback> listReview;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.6, // Change as per your requirement
      width: size.width, // Change as per your requirement
      child: listReview.isNotEmpty? ListView.builder(
        shrinkWrap: true,
        itemCount: listReview.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: ReviewWidget(
              reviewData: listReview[index],
            ),
          );
        },
      ): Center(child: Text("This tutor has no reviews", style: bodyLargeBold(context))),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final TutorFeedback reviewData;

  const ReviewWidget({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black54,
              foregroundColor: Colors.transparent,
              foregroundImage: NetworkImage(reviewData.firstInfo?.avatar ??
                  "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reviewData.firstInfo?.name}",
                  style: bodyLargeBold(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                RatingBar(
                  initialRating: reviewData.rating?.toDouble() ?? 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glow: false,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                  itemSize: 18,
                  onRatingUpdate: (double value) {},
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.amber),
                    empty: const Icon(Icons.star_border, color: Colors.amber),
                    half: const Icon(Icons.star_half, color: Colors.amber),
                  ),
                ),
                Text(
                  "${reviewData.content}",
                  style: bodyLarge(context)?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
