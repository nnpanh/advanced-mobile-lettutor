import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/view/common_widgets/circle_network_image.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../../const/export_const.dart';
import '../../../utils/utils.dart';

class LessonCard extends StatefulWidget {
  const LessonCard(
      {super.key,
      required this.lessonData,
      required this.isHistoryCard,
      required this.leftButton,
      required this.rightButton,
      required this.leftButtonCallback,
      required this.rightButtonCallback,
      required this.iconButtonCallback});

  final BookingInfo lessonData;
  final bool isHistoryCard;
  final String leftButton;
  final String rightButton;
  final VoidCallback leftButtonCallback;
  final VoidCallback rightButtonCallback;
  final VoidCallback iconButtonCallback;

  @override
  State<LessonCard> createState() => LessonCardState();
}

class LessonCardState extends State<LessonCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: CircleNetworkImage(
                        url: widget.lessonData.scheduleDetailInfo?.scheduleInfo
                            ?.tutorInfo?.avatar,
                        size: 64.0)),
                Expanded(
                  flex: widget.isHistoryCard ? 8 : 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${widget.lessonData.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}",
                      style: bodyLargeBold(context)?.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.isHistoryCard,
                  child: Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Colors.blue,
                        icon: const Icon(Icons.edit_note),
                        onPressed: widget.iconButtonCallback,
                      )),
                )
              ],
            ),
            Visibility(
              visible: widget.isHistoryCard,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                child: Text(
                  displayNote(),
                  style: bodyLarge(context)
                      ?.copyWith(color: CustomColor.greyTextColor),
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.lessonDate}:  ",
                        style: bodyLargeBold(context)),
                    TextSpan(
                        text: formatDateStringFromApi(widget.lessonData
                            .scheduleDetailInfo?.scheduleInfo?.date!),
                        style: bodyLarge(context))
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.startTime}:  ",
                        style: bodyLargeBold(context)),
                    TextSpan(
                        text: widget.lessonData.scheduleDetailInfo?.scheduleInfo
                            ?.startTime,
                        style: bodyLarge(context))
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.endTime}:  ",
                        style: bodyLargeBold(context)),
                    TextSpan(
                        text: widget.lessonData.scheduleDetailInfo?.scheduleInfo
                            ?.endTime,
                        style: bodyLarge(context))
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Divider(
                thickness: 1,
                height: 1,
                indent: 8,
                endIndent: 8,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ListTile(
                  title: Text(
                    widget.leftButton,
                    style: bodyLargeBold(context)?.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  onTap: widget.leftButtonCallback,
                )),
                SizedBox(
                  width: 0.5,
                  height: size.height * .07,
                  child: const ColoredBox(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                    child: ListTile(
                  title: Text(
                    widget.rightButton,
                    style: bodyLargeBold(context)?.copyWith(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  onTap: widget.rightButtonCallback,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  String displayNote() {
    return widget.lessonData.scheduleDetailInfo?.bookingInfo?.first.classReview
            ?.overallComment ??
        AppLocalizations.of(context)!.hasNoReview;
    // } else {
    // return "Review from tutor: $notes";
    // }
  }
}
