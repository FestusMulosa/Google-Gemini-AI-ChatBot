import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageBox extends StatefulWidget {
  String message;
  bool isSender;
  MessageBox({
    super.key,
    required this.message,
    this.isSender = true,
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
        text: widget.message,
        isSender: widget.isSender,
        color: const Color.fromARGB(255, 174, 222, 243),
        textStyle: const TextStyle(color: Colors.black));
  }
}
