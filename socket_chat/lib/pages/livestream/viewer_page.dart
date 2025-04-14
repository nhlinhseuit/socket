import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_chat/services/livestream_service/signaling_service.dart';

class ViewerPage extends StatefulWidget {
  const ViewerPage({super.key});

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _remoteRenderer.initialize();
    SignalingService.instance.initViewer(_remoteRenderer);
  }

  @override
  void dispose() {
    _remoteRenderer.dispose();
    SignalingService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viewer')),
      body: RTCVideoView(_remoteRenderer),
    );
  }
}
