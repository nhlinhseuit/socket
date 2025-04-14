import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final int index;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.index,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormatted =
        "${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}:${message.time.second.toString().padLeft(2, '0')}";

    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe ? Colors.green[100] : Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "#${index + 1} | ${message.from} @ $timeFormatted\n${message.content}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
