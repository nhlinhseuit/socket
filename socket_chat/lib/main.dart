import 'package:flutter/material.dart';
import 'package:socket_chat/pages/list_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Socket Chat',
      debugShowCheckedModeBanner: false,
      home: ListPage(),
    );
  }
}
