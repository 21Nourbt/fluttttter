import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://localhost:8000'; // Your server base

  // 🚀 Updated function
  static Future<Map<String, dynamic>?> getCheckoutSession({
    required double amount,
    // required String description,
    required String userId,
    required int points,
  }) async {
    try {
      final url =
          Uri.parse('$_baseUrl/ELACO/payment?userId=$userId&points=$points');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount * 1000,
          // 'description': description,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['result']; // ✅ returning only 'result' part
      } else {
        print('Failed to get checkout session: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error getting checkout session: $e');
      return null;
    }
  }
}
