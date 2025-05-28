// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'dart:convert';
// // // // // // import '../models/subscription.dart';

// // // // // // class SubscriptionService {
// // // // // //   static const String baseUrl = 'http://localhost:8000/ELACO/subcription/gg';

// // // // // //   static Future<List<Subscription>> fetchMeetingRoomSubscriptions() async {
// // // // // //     const String roomType = 'meeting room'; // fixed value
// // // // // //     final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');

// // // // // //     final url = Uri.parse('$baseUrl/$safeRoomType');

// // // // // //     try {
// // // // // //       final response = await http.get(url);

// // // // // //       if (response.statusCode == 200) {
// // // // // //         final jsonResponse = json.decode(response.body);
// // // // // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // // // // //         List<Subscription> subscriptions = subscriptionsJson
// // // // // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // // // // //             .toList();

// // // // // //         return subscriptions;
// // // // // //       } else {
// // // // // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // // // // //       }
// // // // // //     } catch (error) {
// // // // // //       throw Exception('Error fetching subscriptions: $error');
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // import 'package:http/http.dart' as http;
// // // // // import 'dart:convert';
// // // // // import '../models/subscription.dart';

// // // // // class SubscriptionService {
// // // // //   // Base URL for your backend
// // // // //   static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';

// // // // //   /// Fetch subscriptions where roomType = "meeting room"
// // // // //   static Future<List<Subscription>> fetchMeetingRoomSubscriptions() async {
// // // // //     const String roomType = 'office'; // fixed value for now
// // // // //     // final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');

// // // // //     final url = Uri.parse('$_baseUrl/$roomType');

// // // // //     try {
// // // // //       final response = await http.get(url);

// // // // //       if (response.statusCode == 200) {
// // // // //         final jsonResponse = json.decode(response.body);
// // // // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // // // //         List<Subscription> subscriptions = subscriptionsJson
// // // // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // // // //             .toList();

// // // // //         return subscriptions;
// // // // //       } else {
// // // // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // // // //       }
// // // // //     } catch (error) {
// // // // //       throw Exception('Error fetching subscriptions: $error');
// // // // //     }
// // // // //   }

// // // // //   /// (Optional) If you want later: Fetch subscriptions for a dynamic roomType
// // // // //   static Future<List<Subscription>> fetchSubscriptionsByRoomType(String roomType) async {
// // // // //     // final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');

// // // // //     final url = Uri.parse('$_baseUrl/office');

// // // // //     try {
// // // // //       final response = await http.get(url);

// // // // //       if (response.statusCode == 200) {
// // // // //         final jsonResponse = json.decode(response.body);
// // // // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // // // //         List<Subscription> subscriptions = subscriptionsJson
// // // // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // // // //             .toList();

// // // // //         return subscriptions;
// // // // //       } else {
// // // // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // // // //       }
// // // // //     } catch (error) {
// // // // //       throw Exception('Error fetching subscriptions: $error');
// // // // //     }
// // // // //   }
// // // // // }

// // // // import 'package:http/http.dart' as http;
// // // // import 'dart:convert';
// // // // import '../models/subscription.dart';

// // // // class SubscriptionService {
// // // //   // Base URL for your backend
// // // //   static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';

// // // //   /// Fetch subscriptions where roomType = "meeting room"
// // // //   static Future<List<Subscription>> fetchMeetingRoomSubscriptions() async {
// // // //     const String roomType = 'meeting room'; // fixed value
// // // //     final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');

// // // //     final url = Uri.parse('$_baseUrl/$safeRoomType');

// // // //     try {
// // // //       final response = await http.get(url);

// // // //       if (response.statusCode == 200) {
// // // //         final jsonResponse = json.decode(response.body);
// // // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // // //         List<Subscription> subscriptions = subscriptionsJson
// // // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // // //             .toList();

// // // //         return subscriptions;
// // // //       } else {
// // // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // // //       }
// // // //     } catch (error) {
// // // //       throw Exception('Error fetching subscriptions: $error');
// // // //     }
// // // //   }

// // // //   /// (Optional) Fetch subscriptions for any dynamic roomType
// // // //   static Future<List<Subscription>> fetchSubscriptionsByRoomType(String roomType) async {
// // // //     final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');

// // // //     final url = Uri.parse('$_baseUrl/$safeRoomType');

// // // //     try {
// // // //       final response = await http.get(url);

// // // //       if (response.statusCode == 200) {
// // // //         final jsonResponse = json.decode(response.body);
// // // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // // //         List<Subscription> subscriptions = subscriptionsJson
// // // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // // //             .toList();

// // // //         return subscriptions;
// // // //       } else {
// // // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // // //       }
// // // //     } catch (error) {
// // // //       throw Exception('Error fetching subscriptions: $error');
// // // //     }
// // // //   }
// // // // }

// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import '../models/subscription.dart';

// // // class SubscriptionService {
// // //   static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';

// // //   /// Fetch subscriptions for "office"
// // //   static Future<List<Subscription>> fetchOfficeSubscriptions() async {
// // //     const String roomType = 'office'; // Fixed "office"

// // //     final url = Uri.parse('$_baseUrl/$roomType');

// // //     try {
// // //       final response = await http.get(url);

// // //       if (response.statusCode == 200) {
// // //         final jsonResponse = json.decode(response.body);
// // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // //         List<Subscription> subscriptions = subscriptionsJson
// // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // //             .toList();

// // //         return subscriptions;
// // //       } else {
// // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // //       }
// // //     } catch (error) {
// // //       throw Exception('Error fetching subscriptions: $error');
// // //     }
// // //   }

// // //   /// Optional: Fetch subscriptions dynamically (in case you add more)
// // //   static Future<List<Subscription>> fetchSubscriptionsByRoomType(String roomType) async {
// // //     final url = Uri.parse('$_baseUrl/$roomType'); // Direct roomType

// // //     try {
// // //       final response = await http.get(url);

// // //       if (response.statusCode == 200) {
// // //         final jsonResponse = json.decode(response.body);
// // //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// // //         List<Subscription> subscriptions = subscriptionsJson
// // //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// // //             .toList();

// // //         return subscriptions;
// // //       } else {
// // //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// // //       }
// // //     } catch (error) {
// // //       throw Exception('Error fetching subscriptions: $error');
// // //     }
// // //   }
// // // }

// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import '../models/subscription.dart';

// // class SubscriptionService {
// //   static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';

// //   /// ✅ This function should exist exactly like this:
// //   static Future<List<Subscription>> fetchMeetingRoomSubscriptions() async {
// //     const String roomType = 'office'; // Or whatever you want ("office", "workspace", etc.)

// //     final url = Uri.parse('$_baseUrl/$roomType');

// //     try {
// //       final response = await http.get(url);

// //       if (response.statusCode == 200) {
// //         final jsonResponse = json.decode(response.body);
// //         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

// //         List<Subscription> subscriptions = subscriptionsJson
// //             .map((jsonItem) => Subscription.fromJson(jsonItem))
// //             .toList();

// //         return subscriptions;
// //       } else {
// //         throw Exception('Failed to fetch subscriptions. Status code: ${response.statusCode}');
// //       }
// //     } catch (error) {
// //       throw Exception('Error fetching subscriptions: $error');
// //     }
// //   }
// // }

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/subscription.dart';

// class SubscriptionService {
//   static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';
//   // replace 192.168.1.5 with your local IP

//   static Future<List<Subscription>> fetchOfficeSubscriptions() async {
//     const String roomType = 'office';

//     final url = Uri.parse('$_baseUrl/$roomType');

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

//         List<Subscription> subscriptions = subscriptionsJson
//             .map((jsonItem) => Subscription.fromJson(jsonItem))
//             .toList();

//         return subscriptions;
//       } else {
//         throw Exception(
//             'Failed to fetch subscriptions. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw Exception('Error fetching subscriptions: $error');
//     }
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/subscription.dart';

class SubscriptionService {
  static const String _baseUrl = 'http://localhost:8000/ELACO/subcription/gg';
  // ⬆️ Replace 'localhost' with your actual IP if you're testing on a physical device

  /// Fetch subscriptions based on dynamic room type: "office", "meeting room", "openspace", etc.
  static Future<List<Subscription>> fetchSubscriptionsByRoomType(
      String roomType) async {
    // Convert to lowercase and encode spaces for URL safety
    final safeRoomType = roomType.toLowerCase().replaceAll(' ', '%20');
    final url = Uri.parse('$_baseUrl/$safeRoomType');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];

        // Map the JSON data to a list of Subscription objects
        return subscriptionsJson
            .map((jsonItem) => Subscription.fromJson(jsonItem))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch subscriptions. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching subscriptions: $error');
    }
  }
}
