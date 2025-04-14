import 'package:flutter/material.dart';
import '../../models/message_model.dart';
import '../../widgets/message_bubble.dart';
import '../../services/chat_service/chat_socket_service.dart';

class ChatPage extends StatefulWidget {
  final String username;
  const ChatPage({super.key, required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final msgController = TextEditingController();
  final List<Message> messages = [];

  @override
  @override
  void initState() {
    super.initState();
    ChatSocketService.connectAndListen(
      username: widget.username,
      onMessage: (msg) => setState(() => messages.add(msg)),
    );
  }

  void _sendMessage() {
    final text = msgController.text.trim();
    if (text.isNotEmpty) {
      ChatSocketService.sendMessage(text);
      msgController.clear();
    }
  }

  @override
  void dispose() {
    ChatSocketService.disconnect(); // rất quan trọng!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat - ${widget.username}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final msg = messages[i];
                final isMe = msg.from == widget.username;
                return MessageBubble(message: msg, index: i, isMe: isMe);
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                    controller: msgController,
                    decoration:
                        const InputDecoration(hintText: 'Nhập tin nhắn')),
              ),
              IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
