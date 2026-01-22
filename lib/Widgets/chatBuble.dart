import 'package:chat_app/Models/Message.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 16,
            top: 16,
          ),
          child: Text(message.text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class StrangerChatBubble extends StatelessWidget {
  const StrangerChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xff016589),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 8,
            bottom: 16,
            top: 16,
          ),
          child: Text(message.text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
