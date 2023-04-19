import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/data/repositories/booking_repository.dart';
import 'package:lettutor/data/repositories/schedule_repository.dart';
import 'package:lettutor/model/schedule/schedule.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../const/const_value.dart';
import '../../utils/utils.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';
import '../common_widgets/elevated_button.dart';
import '../common_widgets/loading_overlay.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key, required this.tutorModel});

  final TutorModel tutorModel;

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  late TutorModel tutorData;
  late DateTime date;
  late int selectedOption;
  List<Schedule> options = [];
  bool fetchFirstDate = false;
  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    tutorData = widget.tutorModel;
    date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    if (!fetchFirstDate) {
      _callApiGetScheduleByDate(date, ScheduleRepository(), authProvider);
    }

    return Scaffold(
        appBar: appBarDefault(
            AppLocalizations.of(context)!.bookingDetails, context),
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
                  child: Text(AppLocalizations.of(context)!.appointment,
                      style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(AppLocalizations.of(context)!.bookingCanOnlyMade,
                      style: bodyLarge(context)?.copyWith(color: Colors.black45)
                      // ?.copyWith(color: Colors.white, fontSize: 18),
                      ),
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
                            lastDate:
                                DateTime.now().add(const Duration(days: 7)),
                            builder: (BuildContext context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dialogTheme: DialogTheme(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          16.0), // this is the border radius of the picker
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          dateTime.then((value) {
                            if (value != null) {
                              setState(() {
                                date = value.appliedFromTimeOfDay(
                                    const TimeOfDay(hour: 0, minute: 0));
                                _callApiGetScheduleByDate(
                                    date, ScheduleRepository(), authProvider);
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
                        title: options.isNotEmpty
                            ? options[selectedOption].getDisplayTime()
                            : AppLocalizations.of(context)!.noAvailableSchedule,
                        callback: () {
                          onPressedTime(context, size);
                        },
                        buttonType: ButtonType.outlinedButton,
                        radius: 15,
                        icon: Icons.timer_outlined),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(AppLocalizations.of(context)!.payment,
                      style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.priceLesson,
                          style: bodyLarge(context)?.copyWith(
                              height: ConstValue.courseNameTextScale),
                        ),
                        RichText(
                            text: TextSpan(
                                text: AppLocalizations.of(context)!
                                    .haveLessonLess,
                                style: bodyLarge(context)
                                    ?.copyWith(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .eWalletNotAvailable)),
                                    );
                                  }))
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text(AppLocalizations.of(context)!.notes,
                      style: headLineSmall(context)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextField(
                    maxLines: 5,
                    controller: _txtController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.leaveANote,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: CustomElevatedButton(
                        title: AppLocalizations.of(context)!.confirmBooking,
                        callback: () {
                          onPressedConfirm(BookingRepository(), authProvider);
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

  void onPressedConfirm(
      BookingRepository bookingRepository, AuthProvider authProvider) async {
    LoadingOverlay.of(context).show();
    try {
      await bookingRepository.bookLesson(
          accessToken: authProvider.token?.access?.token ?? "",
          scheduleDetailIds: [
            options[selectedOption].scheduleDetails!.first.id!
          ],
          notes: _txtController.text,
          onSuccess: (response) async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response)),
            );
            Navigator.of(context).pop();
          },
          onFail: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error.toString()}')),
            );
          });
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }

  void onPressedTime(BuildContext context, Size size) {
    Widget child = LimitedBox(
      maxHeight: size.height * 0.8, // Change as per your requirement
      maxWidth: size.width, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (BuildContext context, int index) {
          Widget? trailing;
          if (index == selectedOption) {
            trailing = const Icon(
              Icons.check,
              color: Colors.blue,
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                ListTile(
                  title: Text(options[index].getDisplayTime()),
                  trailing: trailing,
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedOption = index;
                    });
                  },
                ),
                const Divider(
                  height: 2,
                )
              ],
            ),
          );
        },
      ),
    );
    showBottomDialog(
        context, AppLocalizations.of(context)!.selectAFilter, child);
  }

  void _callApiGetScheduleByDate(DateTime inputTime,
      ScheduleRepository scheduleRepository, AuthProvider authProvider) async {
    int startTime = inputTime.millisecondsSinceEpoch;
    DateTime endDateTime = inputTime.add(const Duration(days: 1));
    endDateTime =
        DateTime(endDateTime.year, endDateTime.month, endDateTime.day);
    int endTime = endDateTime.millisecondsSinceEpoch;

    LoadingOverlay.of(context).show();

    try {
      await scheduleRepository.getScheduleById(
          accessToken: authProvider.token?.access?.token ?? "",
          startTime: startTime,
          endTime: endTime,
          tutorId: widget.tutorModel.userId ?? "",
          onSuccess: (response) async {
            List<Schedule> newList = [];
            for (var element in response) {
              if (element.isBooked == false) {
                newList.add(element);
              }
            }
            newList.sort((a, b) => (a.startTime!).compareTo((b.startTime!)));
            setState(() {
              options = newList;
              fetchFirstDate = true;
              selectedOption = 0;
            });
          },
          onFail: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error.toString()}')),
            );
          });
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }
}
