import 'package:flutter/material.dart';
import 'package:socket_chat/pages/chat/enter_chat_name.dart';
import 'package:socket_chat/pages/livestream/broadcaster_page.dart';
import 'package:socket_chat/pages/livestream/viewer_page.dart';
import 'package:socket_chat/widgets/item_card.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SOCKET')),
      body: ListView(
        children: [
          ItemCard(
            title: 'Socket Chat',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EnterChatName()),
              );
            },
          ),
          ItemCard(
            title: 'Socket Livestream Broadcaster',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BroadcasterPage()),
              );
            },
          ),
          ItemCard(
            title: 'Socket Livestream Viewer',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ViewerPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
