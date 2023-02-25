import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/model/lesson_model.dart';
import 'package:lettutor/utils/default_style.dart';

import '../../../config/router.dart';
import '../../../config/router_arguments.dart';
import '../../../const/export_const.dart';
import '../../../model/tutor_model.dart';
import '../../../utils/utils.dart';
import '../../common_widgets/chip_button.dart';

class LessonCard extends StatefulWidget {
  const LessonCard({super.key, required this.lessonData, required this.isHistoryCard, required this.leftButton, required this.rightButton, required this.leftButtonCallback, required this.rightButtonCallback});

  final LessonModel lessonData;
  final bool isHistoryCard;
  final String leftButton;
  final String rightButton;
  final VoidCallback leftButtonCallback;
  final VoidCallback rightButtonCallback;


  @override
  State<LessonCard> createState() => LessonCardState();
}

class LessonCardState extends State<LessonCard> {
  @override
  Widget build(BuildContext context){
  Size size = MediaQuery.of(context).size;

  return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16,16,16,8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.transparent,
                    foregroundImage: NetworkImage(widget.lessonData.tutorAvatarUrl ??
                        "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
                  ),
                ),
                Expanded(
                  flex: widget.isHistoryCard? 8:7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${widget.lessonData.tutorName}",
                      style: bodyLargeBold(context)?.copyWith(
                          fontSize:20),
                      overflow: TextOverflow.ellipsis,

                      maxLines: 2,
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.isHistoryCard,
                  child: Expanded(
                    flex:1,
                      child: IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.edit_note),
                    onPressed: () {  },
                  )),
                )
              ],
            ),
            Visibility(
              visible: widget.isHistoryCard,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                child: Text(displayNote(),
                  style: bodyLarge(context)?.copyWith(
                      color: CustomColor.greyTextColor),
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: RichText(text: TextSpan(children: [TextSpan(text: "Lesson date:  ",style: bodyLargeBold(context)),
                TextSpan(text: getDateString(widget.lessonData.lessonStart, TimeFormat.getDateNo),
                    style: bodyLarge(context))],
              ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: RichText(text: TextSpan(children: [TextSpan(text: "Start time:  ",style: bodyLargeBold(context)),
                TextSpan(text: getDateString(widget.lessonData.lessonStart, TimeFormat.getTime),
                    style: bodyLarge(context))],
              ),
            ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: RichText(text: TextSpan(children: [TextSpan(text: "End time:  ",style: bodyLargeBold(context)),
                TextSpan(text: getDateString(widget.lessonData.lessonEnd, TimeFormat.getTime),
                    style: bodyLarge(context))],
              ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Divider(thickness: 1, height: 1, indent: 8, endIndent: 8,),
            ),
            Row(
                children: [
                  Expanded(child: ListTile(title: Text(widget.leftButton, style:
                    bodyLargeBold(context)?.copyWith(color: Colors.red),textAlign: TextAlign.center,), onTap: widget.leftButtonCallback,)),
                  SizedBox(width: 0.5, height: size.height*.07, child: const ColoredBox(color: Colors.grey,),),
                  Expanded(child: ListTile(title: Text(widget.rightButton, style:
                  bodyLargeBold(context)?.copyWith(color: Colors.blue),textAlign: TextAlign.center,), onTap: widget.rightButtonCallback,)),
                ],
            )
          ],
        ),
      ),
    );
  }

  String displayNote(){
    String? notes = widget.lessonData.lessonNotes;
    if (notes==null) {
      return "This lesson has no notes.";
    } else {
      return "Notes: $notes";
    }
  }
}
