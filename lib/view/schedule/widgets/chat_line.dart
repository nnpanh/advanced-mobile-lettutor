import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class ChatLine extends StatelessWidget {
  const ChatLine({super.key, required this.isGPTAnswer, required this.content});

  final String content;
  final bool isGPTAnswer;

  @override
  Widget build(BuildContext context) {
    if (isGPTAnswer) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BubbleSpecialThree(
          text: content,
          color: const Color(0xFFE8E8EE),
          tail: false,
          isSender: false,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BubbleSpecialThree(
          text: content,
          color: const Color(0xFF1B97F3),
          tail: false,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }
  }
}
