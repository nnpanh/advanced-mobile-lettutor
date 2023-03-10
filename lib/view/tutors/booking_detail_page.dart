import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../../model/tutor_model.dart';
import '../../utils/default_style.dart';
import '../../utils/utils.dart';
import '../common_widgets/dialogs/base_dialog/confirm_dialog.dart';
import '../common_widgets/elevated_button.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key, required this.tutorModel});

  final TutorModel tutorModel;

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  late TutorModel tutorData;
  late DateTime date;
  late String time;

  @override
  void initState() {
    tutorData = widget.tutorModel;
    date = DateTime.now();
    time = "01:30-02:30";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBarDefault(MyRouter.bookingDetail, context),
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
                        title: getDateString(date, TimeFormat.getDateNo),
                        callback: () {
                          Future<DateTime?> dateTime = showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 14)),
                            builder: (BuildContext context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dialogTheme: DialogTheme(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0), // this is the border radius of the picker
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          dateTime.then((value) {
                            if (value!=null){
                              setState(() {
                                date = value;
                              });
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
        builder: (BuildContext context) {
          return ConfirmDialog(
            size: size,
            content: "Book this tutor successfully.",
            title: 'Announcement',
            onLeftButton: () {},
            onRightButton: () {
              Navigator.of(context).pop();
            },
            leftButton: '',
            rightButton: 'Confirm',
            hasLeftButton: false,
          );
        });
  }
}
