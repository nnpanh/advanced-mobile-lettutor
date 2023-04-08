import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../const/export_const.dart';
import '../default_style.dart';
import '../elevated_button.dart';
import 'base_dialog/widget_dialog.dart';

class CreateReviewArguments {
  String? bookingId;
  String? userId;
  int? rating;
  String? content;

  CreateReviewArguments(this.bookingId, this.userId, this.rating, this.content);
}

void onPressedCreateReview(Size size,
    BuildContext context,
    CreateReviewArguments createReviewParams,
    String? tutorName,
    String? lessonDate) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return WidgetDialog(
            title: 'Create review',
            widget: CreateReviewDialogContent(
              size: size,
              createReviewArguments: createReviewParams,
              lessonDate: lessonDate,
              tutorName: tutorName,
            ));
      });
}

class CreateReviewDialogContent extends StatelessWidget {
  const CreateReviewDialogContent(
      {super.key,
      required this.size,
      required this.createReviewArguments,
      required this.lessonDate,
      required this.tutorName});
  final Size size;
  final CreateReviewArguments createReviewArguments;
  final String? lessonDate;
  final String? tutorName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width,
          alignment: Alignment.centerLeft,
          child: RichText(
              text: TextSpan(
                  style: bodyLarge(context)?.copyWith(fontSize: 16),
                  children: [
                TextSpan(text: "Rate "),
                TextSpan(
                    text: "$tutorName ",
                    style: bodyLargeBold(context)?.copyWith(fontSize: 16)),
                TextSpan(text: "after the lesson with him/her on $lessonDate"),
              ])),
        ),
        Container(
          width: size.width,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: RatingBar(
            initialRating: createReviewArguments.rating?.toDouble() ?? 5.0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            glow: false,
            itemPadding: const EdgeInsets.symmetric(horizontal: 3),
            itemSize: 36,
            onRatingUpdate: (double value) {},
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber),
              empty: const Icon(Icons.star_border, color: Colors.amber),
              half: const Icon(Icons.star_half, color: Colors.amber),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: const TextField(
            maxLines: 5,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Tell us how was the lesson..',
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomElevatedButton(
                      callback: () {
                        Navigator.of(context).pop();
                      },
                      title: 'Cancel',
                      radius: 0,
                      buttonType: ButtonType.outlinedButton,
                    ))),
            Expanded(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomElevatedButton(
                      callback: () {
                        Navigator.of(context).pop();
                      },
                      title: 'Send review',
                      radius: 30,
                      buttonType: ButtonType.filledButton,
                    ))),
          ],
        )
      ],
    );
  }
}
//
// class ReviewWidget extends StatelessWidget {
//   final ReviewModel reviewData;
//
//   const ReviewWidget({super.key, required this.reviewData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 4,
//           child: Container(
//             padding: EdgeInsets.fromLTRB(12, 0, 0, 16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${reviewData.userName}",
//                   style: bodyLargeBold(context),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 RatingBar(
//                   initialRating: reviewData.ratingScore ?? 0.0,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   glow: false,
//                   ignoreGestures: true,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 1),
//                   itemSize: 18,
//                   onRatingUpdate: (double value) {},
//                   ratingWidget: RatingWidget(
//                     full: const Icon(Icons.star, color: Colors.amber),
//                     empty: const Icon(Icons.star_border, color: Colors.amber),
//                     half: const Icon(Icons.star_half, color: Colors.amber),
//                   ),
//                 ),
//                 Text(
//                   "${reviewData.comment}",
//                   style: bodyLarge(context)?.copyWith(color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
