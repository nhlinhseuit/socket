import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../models/message_model.dart';

class ChatSocketService {
  static late IO.Socket _socket;

  static void connectAndListen({
    required String username,
    required Function(Message) onMessage,
  }) {
    print('[SOCKET] connectAndListen!');

    _socket = IO.io('http://192.168.102.42:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      print('[SOCKET] Connected!');
      _socket.emit('join', username); // <- Đây là dòng phải có!
    });

    _socket.on('message', (data) {
      print('[SOCKET] Nhận tin nhắn: $data');
      onMessage(Message.fromJson(data));
    });
  }

  static void sendMessage(String content) {
    _socket.emit('message', {'content': content});
  }

  static void disconnect() => _socket.disconnect();
}
