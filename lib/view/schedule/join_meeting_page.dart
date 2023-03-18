import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import '../common_widgets/dialogs/base_dialog/bottom_sheet_dialog.dart';


class JoinMeetingPage extends StatefulWidget {
  const JoinMeetingPage({super.key});

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarDefault(MyRouter.joinMeeting, context),
      body: Center(
        child: Image.asset(ImagesPath.video)
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () { onPressedTime(context, size); },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.message, color: Colors.white,),
      ),
    );
  }
  void onPressedTime(BuildContext context, Size size) {
    List<String> options = [];
    for (var i = 0; i<10; i++) {
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
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
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
        const Divider(height: 1,),
        MessageBar(
          onSend: (_) => print(_),
        ),
      ],
    );

    showBottomDialog(context, 'ChatGPT', child);
  }
}
