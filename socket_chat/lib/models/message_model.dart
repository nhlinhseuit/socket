class Message {
  final String from;
  final String content;
  final DateTime time;

  Message({required this.from, required this.content, required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      from: json['from'],
      content: json['content'],
      time: DateTime.parse(json['time']),
    );
  }
}
