import 'package:flutter/material.dart';
import 'package:lettutor/view/schedule/join_meeting_page.dart';
import 'package:lettutor/view/schedule/widgets/chat_line.dart';

class ChatList extends StatefulWidget {
  const ChatList(
      {super.key, required this.conversations, required this.sendMessage});
  final List<ChatData> conversations;
  final Function sendMessage;

  @override
  State<ChatList> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  final TextEditingController _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * 0.6,
            maxWidth: size.width,
            minHeight: size.height * 0.3,
            minWidth: size.width,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.conversations.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatLine(
                content: widget.conversations[index].content,
                isGPTAnswer: widget.conversations[index].isChatGPTAnswer,
              );
            },
          ),
        ),
        const Divider(
          height: 1,
        ),
        Container(
            margin: const EdgeInsets.only(top: 12),
            child: TextField(
              controller: _txtController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  hintText: 'Type your message here',
                  suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: () {
                        widget.sendMessage(_txtController.text);
                        _txtController.clear();
                      })),
            )),
      ],
    );
  }
}
