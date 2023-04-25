import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/elevated_button.dart';

import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';

class JoinMeetingPage extends StatefulWidget {
  const JoinMeetingPage({super.key, required this.upcomingClass});
  final BookingInfo upcomingClass;

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  late BookingInfo upcomingClass = widget.upcomingClass;
  late DateTime endTime;
  bool canJoinMeeting = false;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.fromMillisecondsSinceEpoch(upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
  }

  void onEnd() {
    setState(() {
      canJoinMeeting = true;
    });
  }

  void _joinMeeting() async {
    final String meetingToken = upcomingClass.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

      var options = JitsiMeetingOptions(
        roomNameOrUrl: room,
        serverUrl: "https://meet.lettutor.com",
        token: meetingToken,
        isAudioMuted: true,
        isAudioOnly: true,
        isVideoMuted: true,
      );

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(
          onOpened: () => debugPrint("onOpened"),
          onConferenceWillJoin: (url) {
            debugPrint("onConferenceWillJoin: url: $url");
          },
          onConferenceJoined: (url) {
            debugPrint("onConferenceJoined: url: $url");
          },
          onConferenceTerminated: (url, error) {
            debugPrint("onConferenceTerminated: url: $url, error: $error");
          },
          onClosed: () => debugPrint("onClosed"),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarDefault(AppLocalizations.of(context)!.joinMeeting, context),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(ImagesPath.video),
          CountdownTimer(
            onEnd: onEnd,
            endTime: endTime.millisecondsSinceEpoch,
            textStyle: bodyLargeBold(context)?.copyWith(color: Colors.blue),
            endWidget: CustomElevatedButton(
                title: AppLocalizations.of(context)!.joinMeeting,
                callback: () {
                  _joinMeeting();
                },
                buttonType: ButtonType.filledButton,
                radius: 10),
          ),
        ],
      )),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressedTime(context, size);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
      )
    );
  }

  void onPressedTime(BuildContext context, Size size) {
    List<String> options = [];
    for (var i = 0; i < 10; i++) {
      options.add('This is a kind of chat box');
    }

    Widget child = Column(
      children: [
        LimitedBox(
          maxHeight: size.height * 0.6, // Change as per your requirement
          maxWidth: size.width, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const BubbleSpecialThree(
                        text: 'Help me translate what the tutor just said.',
                        color: Color(0xFF1B97F3),
                        tail: false,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const BubbleSpecialThree(
                        text: "我要睡觉!",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(
          height: 1,
        ),
        MessageBar(
          onSend: (_) => print(_),
        ),
      ],
    );

    showBottomDialog(context, 'ChatGPT', child);
  }
}
