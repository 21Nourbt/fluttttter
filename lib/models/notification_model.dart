class NotificationModel {
  final String id;
  final String title;
  final String content;
  final DateTime sentDate;
  final String sentTime;
  final int points;
  final String status;
  final String userId;
  final String senderId;
  final Sender? sender; // For populated sender (optional)

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.sentDate,
    required this.sentTime,
    required this.points,
    required this.status,
    required this.userId,
    required this.senderId,
    this.sender,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      title: json['title'] ?? '',
      content: json['content'],
      sentDate: DateTime.parse(json['sentDate']),
      sentTime: json['sentTime'],
      points: json['points'] ?? 0,
      status: json['status'],
      userId: json['user_id'],
      senderId: json['sender_id'],
      sender: json['sender_id'] != null && json['sender_id'] is Map
          ? Sender.fromJson(json['sender_id'])
          : null,
    );
  }
}

class Sender {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
