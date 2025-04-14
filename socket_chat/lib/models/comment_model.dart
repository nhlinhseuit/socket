class Comment {
  final String username;
  final String content;
  final DateTime time;

  Comment({
    required this.username,
    required this.content,
    required this.time,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      username: json['username'],
      content: json['content'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'content': content,
        'time': time.toIso8601String(),
      };
}
