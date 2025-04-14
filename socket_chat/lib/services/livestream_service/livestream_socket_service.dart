import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef SocketCallback = void Function(dynamic data);

class LivestreamSocketService {
  static final LivestreamSocketService instance = LivestreamSocketService._internal();
  factory LivestreamSocketService() => instance;
  LivestreamSocketService._internal();

  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://192.168.102.42:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
  }

  void on(String event, SocketCallback callback) => socket.on(event, callback);
  void emit(String event, dynamic data) => socket.emit(event, data);
  void dispose() => socket.dispose();
}