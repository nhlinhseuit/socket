import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:convert';

import 'package:socket_chat/services/livestream_service/livestream_socket_service.dart';

class SignalingService {
  static final SignalingService instance = SignalingService._internal();
  factory SignalingService() => instance;
  SignalingService._internal();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  Future<void> initBroadcaster(RTCVideoRenderer localRenderer) async {
    LivestreamSocketService.instance.connect();
    _localStream = await navigator.mediaDevices.getUserMedia({
      'video': true,
      'audio': true,
    });
    localRenderer.srcObject = _localStream;

    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(config);
    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _peerConnection!.onIceCandidate = (candidate) {
      LivestreamSocketService.instance.emit('ice-candidate', candidate.toMap());
    };

    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    LivestreamSocketService.instance.emit('offer', offer.toMap());

    LivestreamSocketService.instance.on('answer', (data) async {
      final sdp = RTCSessionDescription(data['sdp'], data['type']);
      await _peerConnection!.setRemoteDescription(sdp);
    });
  }

  Future<void> initViewer(RTCVideoRenderer remoteRenderer) async {
    LivestreamSocketService.instance.connect();

    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(config);
    _peerConnection!.onTrack = (event) {
      remoteRenderer.srcObject = event.streams.first;
    };

    _peerConnection!.onIceCandidate = (candidate) {
      LivestreamSocketService.instance.emit('ice-candidate', candidate.toMap());
    };

    LivestreamSocketService.instance.on('offer', (data) async {
      final sdp = RTCSessionDescription(data['sdp'], data['type']);
      await _peerConnection!.setRemoteDescription(sdp);
      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      LivestreamSocketService.instance.emit('answer', answer.toMap());
    });

    LivestreamSocketService.instance.on('ice-candidate', (data) async {
      final candidate = RTCIceCandidate(
        data['candidate'],
        data['sdpMid'],
        data['sdpMLineIndex'],
      );
      await _peerConnection!.addCandidate(candidate);
    });
  }

  void dispose() {
    _peerConnection?.close();
    LivestreamSocketService.instance.dispose();
  }
}