import 'package:flutter/material.dart';
import 'chat_page.dart';

class EnterChatName extends StatefulWidget {
  const EnterChatName({super.key});
  @override
  State<EnterChatName> createState() => _LoginPageState();
}

class _LoginPageState extends State<EnterChatName> {
  final nameController = TextEditingController();

  void _startChat() {
    final name = nameController.text.trim();
    if (name.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ChatPage(username: name)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhập tên người dùng')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Tên')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _startChat, child: const Text('Bắt đầu chat')),
          ],
        ),
      ),
    );
  }
}
