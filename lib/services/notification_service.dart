import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:your_app/models/notification_model.dart'; // Correct path
// import 'package:your_app/constants/api_constants.dart';

import '../models/notification_model.dart'; // Your base URL file

class NotificationService {
  static const String baseUrl = 'http://localhost:8000/ELACO';
  static Future<List<NotificationModel>> getCurrentUserNotifications(
      String userId) async {
    final url = Uri.parse('$baseUrl/notification/$userId');

    try {
      final response = await http.get(url);
      print(response);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        final List<dynamic> notificationList = data['notifications'];

        return notificationList
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  static Future<bool> addNotification({
    required String title,
    required String content,
    required int points,
    required String userId,
    required String senderId,
  }) async {
    final url = Uri.parse('$baseUrl/notification');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "title": title,
          "content": content,
          "points": points,
          "user_id": userId,
          "sender_id": senderId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add notification');
      }
    } catch (e) {
      throw Exception('Error adding notification: $e');
    }
  }

  static Future<bool> addNotificationToAdmin({
    required String title,
    required String content,
    required int points,
    required String senderId,
  }) async {
    final url = Uri.parse('$baseUrl/notification/$senderId');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "title": title,
          "content": content,
          "points": points,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add notification to admin');
      }
    } catch (e) {
      throw Exception('Error adding notification to admin: $e');
    }
  }
}
