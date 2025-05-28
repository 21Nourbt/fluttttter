import 'dart:convert';
import 'package:http/http.dart' as http;

class UserSubscriptionService {
  static const String baseUrl = 'http://localhost:8000'; // your backend server

  static Future<Map<String, dynamic>> createUserSubscription({
    required String subId,
    required String startDate,
    required double amount,
    // required String description,
  }) async {
    final url = Uri.parse('$baseUrl/ELACO/subcription/payment');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'subId': subId,
          'start_date': startDate,
          'amount': amount * 1000,
          // 'description': description,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData['result'],
        };
      } else if (response.statusCode == 210) {
        return {
          'success': false,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
