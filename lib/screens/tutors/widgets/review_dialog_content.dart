import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../const/export_const.dart';
import '../../../model/review_model.dart';
import '../../../utils/default_style.dart';
import '../../../utils/utils.dart';

class ReviewDialogContent extends StatelessWidget {
  ReviewDialogContent({super.key, required this.size});
  final Size size;
  final List<ReviewModel> listReview = generateReviewList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.5, // Change as per your requirement
      width: size.width * 0.8, // Change as per your requirement
      child: ListView.builder(
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
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewData;

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
              foregroundImage: NetworkImage(reviewData.avatarUrl ??
                  "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reviewData.userName}",
                  style: bodyLargeBold(context)
                      ?.copyWith(height: ConstValue.descriptionTextScale),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                RatingBar(
                  initialRating: reviewData.ratingScore ?? 0.0,
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
                  "${reviewData.comment}",
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
