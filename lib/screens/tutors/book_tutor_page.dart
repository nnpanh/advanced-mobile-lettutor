import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/tutors/widgets/report_dialog_content.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../model/tutor_model.dart';
import '../../utils/utils.dart';
import '../../utils/default_style.dart';
import '../common_widgets/dialogs/confirm_dialog.dart';
import '../common_widgets/elevated_button.dart';

class BookTutorPage extends StatefulWidget {
  const BookTutorPage({super.key, required this.tutorModel});
  final TutorModel tutorModel;

  @override
  State<BookTutorPage> createState() => _BookTutorPageState();
}

class _BookTutorPageState extends State<BookTutorPage> {
  late TutorModel tutorData;
  late String date;
  late String time;

  @override
  void initState() {
    tutorData = widget.tutorModel;
    date = "Tuesday, 20/11/2023";
    time = "01:30-02:30";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBar("Booking details", context),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white30,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text('Appointment', style: headLineSmall(context)),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomElevatedButton(
                        title: date,
                        callback: () {
                          Future<DateTime?> dateTime = showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );


                          dateTime.then((value) => {
                            if (value!=null){
                              setState(){
                                date = "Tuesday, ${value.day}/${value.month}/${value.year}";
                              }
                            }
                          });
                        },
                        buttonType: ButtonType.outlinedButton,
                        radius: 15,
                        icon: Icons.calendar_month),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomElevatedButton(
                        title: time,
                        callback: () {},
                        buttonType: ButtonType.outlinedButton,
                        radius: 15,
                        icon: Icons.timer_outlined),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('Payment', style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: 1 lesson",
                          style: bodyLarge(context)?.copyWith(
                              height: ConstValue.courseNameTextScale),
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'You have 1 lesson left',
                                style: bodyLarge(context)
                                    ?.copyWith(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //todo: push qua man setting profile -> my wallet
                                    Navigator.pushNamed(context, MyRouter.home);
                                  }))
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text('Notes', style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: const TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Leave a note for your tutor.',
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: CustomElevatedButton(
                        title: 'Confirm booking',
                        callback: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return ConfirmDialog(
                                  size: size,
                                  content: "Book this tutor successfully.",
                                  onClose: () {
                                    // Navigator.of(context).pop();
                                    popUntilHomeAndRefresh(context);
                                  },
                                );
                              });
                        },
                        buttonType: ButtonType.filledButton,
                        radius: 15),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onPressedReport(Size size, String? tutorName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WidgetDialog(
              title: "Report $tutorName",
              widget: ReportDialogContent(size: size));
                          onPressedConfirm(context, size);
                        },
                        buttonType: ButtonType.filledButton,
                        radius: 15),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onPressedConfirm(BuildContext context, Size size) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ConfirmDialog(
            size: size,
            content: "Book this tutor successfully.",
            onClose: () {
              Navigator.of(context).pop();
              // popUntilHomeAndRefresh(context);
            },
          );
        });
  }
}
