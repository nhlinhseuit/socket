import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_chat/services/livestream_service/signaling_service.dart';

class BroadcasterPage extends StatefulWidget {
  const BroadcasterPage({super.key});

  @override
  State<BroadcasterPage> createState() => _BroadcasterPageState();
}

class _BroadcasterPageState extends State<BroadcasterPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    SignalingService.instance.initBroadcaster(_localRenderer);
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    SignalingService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Broadcaster')),
      body: RTCVideoView(_localRenderer),
    );
  }
}

