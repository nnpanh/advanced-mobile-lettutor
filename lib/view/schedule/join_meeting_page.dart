import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/elevated_button.dart';

import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';

class ChatData {
  final String content;
  final bool isChatGPTAnswer;

  ChatData(this.content, this.isChatGPTAnswer);
}

class JoinMeetingPage extends StatefulWidget {
  const JoinMeetingPage({super.key, required this.upcomingClass});
  final BookingInfo upcomingClass;

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  //Join meeting
  late BookingInfo upcomingClass = widget.upcomingClass;
  late DateTime endTime;
  bool canJoinMeeting = false;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.fromMillisecondsSinceEpoch(
        upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
    conversations.add(ChatData("Enter your prompt to generate", true));
  }

  void onEnd() {
    setState(() {
      canJoinMeeting = true;
    });
  }

  void _joinMeeting() async {
    final String meetingToken =
        upcomingClass.studentMeetingLink?.split('token=')[1] ?? '';
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
        resizeToAvoidBottomInset: true,
        appBar:
            appBarDefault(AppLocalizations.of(context)!.joinMeeting, context),
        body: Center(
            child: Column(
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
            onPressedChatBubble(context, size);
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
        ));
  }

  void onPressedChatBubble(BuildContext context, Size size) {
    Navigator.pushNamed(context, MyRouter.home);
  }
}
