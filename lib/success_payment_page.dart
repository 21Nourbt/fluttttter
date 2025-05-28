// // // // // // // success_payment_page.dart

// // // // // // import 'package:flutter/material.dart';

// // // // // // class SuccessPaymentPage extends StatelessWidget {
// // // // // //   const SuccessPaymentPage({super.key});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: Colors.white,
// // // // // //       appBar: AppBar(
// // // // // //         title: const Text('Payment Successful'),
// // // // // //         backgroundColor: Colors.green,
// // // // // //       ),
// // // // // //       body: Center(
// // // // // //         child: Padding(
// // // // // //           padding: const EdgeInsets.all(24.0),
// // // // // //           child: Column(
// // // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // // //             children: [
// // // // // //               const Icon(Icons.check_circle, size: 100, color: Colors.green),
// // // // // //               const SizedBox(height: 24),
// // // // // //               const Text(
// // // // // //                 'Your payment was successful!',
// // // // // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // // // //                 textAlign: TextAlign.center,
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),
// // // // // //               const Text(
// // // // // //                 'Thank you for your reservation.\nYou can now enjoy your workspace.',
// // // // // //                 style: TextStyle(fontSize: 16),
// // // // // //                 textAlign: TextAlign.center,
// // // // // //               ),
// // // // // //               const SizedBox(height: 32),
// // // // // //               ElevatedButton(
// // // // // //                 onPressed: () {
// // // // // //                   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
// // // // // //                 },
// // // // // //                 style: ElevatedButton.styleFrom(
// // // // // //                   backgroundColor: Colors.green,
// // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
// // // // // //                 ),
// // // // // //                 child: const Text('Go to Home'),
// // // // // //               )
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // lib/success_payment_page.dart

// // // // // import 'package:flutter/material.dart';

// // // // // class SuccessPaymentPage extends StatelessWidget {
// // // // //   /// Add this field so the router can inject the query-param
// // // // //   final String? paymentRef;

// // // // //   const SuccessPaymentPage({
// // // // //     Key? key,
// // // // //     this.paymentRef,
// // // // //   }) : super(key: key);

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       body: Center(
// // // // //         child: Padding(
// // // // //           padding: const EdgeInsets.all(24.0),
// // // // //           child: Column(
// // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // //             children: [
// // // // //               const Icon(Icons.check_circle, size: 100, color: Colors.green),
// // // // //               const SizedBox(height: 24),
// // // // //               const Text(
// // // // //                 'Your payment was successful!',
// // // // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // // //                 textAlign: TextAlign.center,
// // // // //               ),

// // // // //               // If you want to show the reference:
// // // // //               if (paymentRef != null) ...[
// // // // //                 const SizedBox(height: 16),
// // // // //                 Text(
// // // // //                   'Reference: $paymentRef',
// // // // //                   style: const TextStyle(fontSize: 16),
// // // // //                 ),
// // // // //               ],

// // // // //               const SizedBox(height: 32),
// // // // //               // ElevatedButton(
// // // // //               //   onPressed: () {
// // // // //               //     Navigator.pushNamedAndRemoveUntil(
// // // // //               //       context,
// // // // //               //       '/home',
// // // // //               //       (route) => false,
// // // // //               //     );
// // // // //               //   },
// // // // //               //   style: ElevatedButton.styleFrom(
// // // // //               //     backgroundColor: Colors.green,
// // // // //               //     padding:
// // // // //               //         const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
// // // // //               //   ),
// // // // //               //   child: const Text('Go to Home'),
// // // // //               // )
// // // // //               // ElevatedButton(
// // // // //               //   onPressed: () {
// // // // //               //     Navigator.of(context, rootNavigator: true)
// // // // //               //         .pushNamedAndRemoveUntil(
// // // // //               //       '/home',
// // // // //               //       (route) => false,
// // // // //               //     );
// // // // //               //   },
// // // // //               //   child: const Text('Go to Home'),
// // // // //               // ),

// // // // //               // inside SuccessPaymentPage’s “Go to Home” button:
// // // // //               // ElevatedButton(
// // // // //               //   onPressed: () {
// // // // //               //     Navigator.of(context, rootNavigator: true)
// // // // //               //         .pushNamedAndRemoveUntil('/home', (route) => false);
// // // // //               //   },
// // // // //               //   child: const Text('Go to Home'),
// // // // //               // ),

// // // // //               ElevatedButton(
// // // // //                 onPressed: () {
// // // // //                   // ← no rootNavigator here
// // // // //                   Navigator.of(context)
// // // // //                       .pushNamed('/home');
// // // // //                 },
// // // // //                 child: const Text('Go to Home'),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';

// // // // class SuccessPaymentPage extends StatelessWidget {
// // // //   final String? paymentRef;

// // // //   const SuccessPaymentPage({
// // // //     Key? key,
// // // //     this.paymentRef,
// // // //   }) : super(key: key);

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       body: Center(
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(24.0),
// // // //           child: Column(
// // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // //             children: [
// // // //               const Icon(Icons.check_circle, size: 100, color: Colors.green),
// // // //               const SizedBox(height: 24),
// // // //               const Text(
// // // //                 'Your payment was successful!',
// // // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // //                 textAlign: TextAlign.center,
// // // //               ),
// // // //               if (paymentRef != null) ...[
// // // //                 const SizedBox(height: 16),
// // // //                 Text(
// // // //                   'Reference: $paymentRef',
// // // //                   style: const TextStyle(fontSize: 16),
// // // //                 ),
// // // //               ],
// // // //               const SizedBox(height: 32),
// // // //               // ElevatedButton(
// // // //               //   onPressed: () {
// // // //               //     // Navigate to home and remove all previous routes (including WebView)
// // // //               //     Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
// // // //               //       '/home',
// // // //               //       (route) => false,
// // // //               //     );
// // // //               //   },
// // // //               //   style: ElevatedButton.styleFrom(
// // // //               //     backgroundColor: Colors.green,
// // // //               //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
// // // //               //   ),
// // // //               //   child: const Text('Go to Home'),
// // // //               // ),
// // // //               ElevatedButton(
// // // //                 onPressed: () {
// // // //                   // ← replace your existing Navigator call with this:
// // // //                   Navigator.of(context, rootNavigator: true)
// // // //                       .pushNamedAndRemoveUntil(
// // // //                     '/home',
// // // //                     (Route<dynamic> route) => false,
// // // //                   );
// // // //                 },
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: Colors.green,
// // // //                   padding:
// // // //                       const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
// // // //                 ),
// // // //                 child: const Text('Go to Home'),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';

// // // class SuccessPaymentPage extends StatelessWidget {
  
// // //   String? userId;
// // //   final String? paymentRef;
// // //   final String? subId;
// // //   final String? startDate;
// // //   final String? endDate;

// // //   const SuccessPaymentPage({
// // //     Key? key,
// // //     this.paymentRef,
// // //     this.subId,
// // //     this.startDate,
// // //     this.endDate,
// // //   }) : super(key: key);

// // //   void initState() {
// // //     super.initState();
// // //     // _generateTimeSlots();
// // //     _initializePreferences();
// // //     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
// // //     //   statusBarColor: Colors.transparent,
// // //     //   statusBarIconBrightness: Brightness.dark,
// // //     // ));
// // //     // print(widget.reservations);
// // //   }

// // //   // @override
// // //   // void dispose() {
// // //   //   _pageController.dispose();
// // //   //   super.dispose();
// // //   // }

// // //   Future<void> _initializePreferences() async {
// // //     setState(() => isLoading = true);
// // //     prefs = await SharedPreferences.getInstance();
// // //     final userJson = prefs.getString('user');

// // //     setState(() {
// // //       if(userJson!=null){
// // //         final UserMap=jsonDecode(userJson);
// // //         userId=UserMap['_id'];
// // //         print("idd $userId");
// // //       }


// // //       isLoading = false;
// // //     });
// // //     if (userId != null) {
// // //       await _fetchUserPoints();
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       body: Center(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(24.0),
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               const Icon(Icons.check_circle, size: 100, color: Colors.green),
// // //               const SizedBox(height: 24),
// // //               const Text(
// // //                 'Your payment was successful!',
// // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //               const SizedBox(height: 24),
// // //               if (paymentRef != null) ...[
// // //                 Text(
// // //                   'Payment Reference: $paymentRef',
// // //                   style: const TextStyle(fontSize: 16),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //               if (subId != null) ...[
// // //                 Text(
// // //                   'Subscription ID: $subId',
// // //                   style: const TextStyle(fontSize: 16),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //               if (startDate != null) ...[
// // //                 Text(
// // //                   'Start Date: $startDate',
// // //                   style: const TextStyle(fontSize: 16),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //               if (endDate != null) ...[
// // //                 Text(
// // //                   'End Date: $endDate',
// // //                   style: const TextStyle(fontSize: 16),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //               const SizedBox(height: 32),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context, rootNavigator: true)
// // //                       .pushNamedAndRemoveUntil(
// // //                     '/home',
// // //                     (Route<dynamic> route) => false,
// // //                   );
// // //                 },
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: Colors.green,
// // //                   padding:
// // //                       const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
// // //                 ),
// // //                 child: const Text('Go to Home'),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class SuccessPaymentPage extends StatefulWidget {
// //   final String? paymentRef;
// //   final String? subId;
// //   final String? startDate;
// //   final String? endDate;

// //   const SuccessPaymentPage({
// //     Key? key,
// //     this.paymentRef,
// //     this.subId,
// //     this.startDate,
// //     this.endDate,
// //   }) : super(key: key);

// //   @override
// //   State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
// // }

// // class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
// //   String? userId;
// //   bool isLoading = false;
// //   late SharedPreferences prefs;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializePreferences();
// //   }

// //   Future<void> _initializePreferences() async {
// //     setState(() => isLoading = true);
// //     prefs = await SharedPreferences.getInstance();
// //     final userJson = prefs.getString('user');

// //     if (userJson != null) {
// //       final userMap = jsonDecode(userJson);
// //       userId = userMap['_id'];
// //       print("User ID: $userId");
// //     }

// //     setState(() => isLoading = false);

// //     if (userId != null) {
// //       await _fetchUserPoints();
// //     }
// //   }

// //   Future<void> _fetchUserPoints() async {
// //     // implement your logic here
// //     print("Fetching user points for $userId");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : Center(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(24.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Icon(Icons.check_circle,
// //                         size: 100, color: Colors.green),
// //                     const SizedBox(height: 24),
// //                     const Text(
// //                       'Your payment was successful!',
// //                       style:
// //                           TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     const SizedBox(height: 24),
// //                     if (widget.paymentRef != null) ...[
// //                       Text(
// //                         'Payment Reference: ${widget.paymentRef}',
// //                         style: const TextStyle(fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 8),
// //                     ],
// //                     if (widget.subId != null) ...[
// //                       Text(
// //                         'Subscription ID: ${widget.subId}',
// //                         style: const TextStyle(fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 8),
// //                     ],
// //                     if (widget.startDate != null) ...[
// //                       Text(
// //                         'Start Date: ${widget.startDate}',
// //                         style: const TextStyle(fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 8),
// //                     ],
// //                     if (widget.endDate != null) ...[
// //                       Text(
// //                         'End Date: ${widget.endDate}',
// //                         style: const TextStyle(fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 8),
// //                     ],
// //                     const SizedBox(height: 32),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.of(context, rootNavigator: true)
// //                             .pushNamedAndRemoveUntil(
// //                           '/home',
// //                           (Route<dynamic> route) => false,
// //                         );
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.green,
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 32, vertical: 14),
// //                       ),
// //                       child: const Text('Go to Home'),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //     );
// //   }
// // }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class SuccessPaymentPage extends StatefulWidget {
//   final String? paymentRef;
//   final String? subId;
//   final String? startDate;
//   final String? endDate;

//   const SuccessPaymentPage({
//     Key? key,
//     this.paymentRef,
//     this.subId,
//     this.startDate,
//     this.endDate,
//   }) : super(key: key);

//   @override
//   State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
// }

// class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
//   String? userId;
//   bool isLoading = true;
//   String? verifyError;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAndVerify();
//   }

//   Future<void> _initializeAndVerify() async {
//     // 1️⃣ Load userId
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString('user');
//     if (userJson != null) {
//       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
//       userId = userMap['_id'] as String?;
//     }

//     // 2️⃣ Call your verify endpoint
//     if (userId != null && widget.paymentRef != null) {
//       await _callVerifyEndpoint();
//     }

//     setState(() => isLoading = false);
//   }

//   Future<void> _callVerifyEndpoint() async {
//     final paymentId = widget.paymentRef!;
//     final subId    = widget.subId;
//     final start    = widget.startDate;
//     final end      = widget.endDate;
//     final idUser   = userId;

//     final uri = Uri.parse(
//       'http://localhost:8000/ELACO/subcription/verify/' +
//       Uri.encodeComponent(paymentId) +
//       '?idUser=${Uri.encodeComponent(idUser!)}'
//       '&subId=${Uri.encodeComponent(subId!)}'
//       '&start_date=${Uri.encodeComponent(start!)}'
//       '&end_date=${Uri.encodeComponent(end!)}'
//     );

//     try {
//       final response = await http.get(uri);
//       if (response.statusCode != 200) {
//         throw Exception('HTTP ${response.statusCode}: ${response.body}');
//       }
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       if (data['status'] != 'success') {
//         throw Exception(data['message'] ?? 'Verification failed');
//       }
//       // ✅ verified successfully
//       print('✅ Subscription verified: $data');
//     } catch (e) {
//       print('⚠️ verify error: $e');
//       verifyError = e.toString();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.check_circle, size: 100, color: Colors.green),
//               const SizedBox(height: 24),
//               const Text(
//                 'Your payment was successful!',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               if (widget.paymentRef != null) ...[
//                 Text('Payment Reference: ${widget.paymentRef}',
//                     style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//               ],
//               if (widget.subId != null) ...[
//                 Text('Subscription ID: ${widget.subId}',
//                     style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//               ],
//               if (widget.startDate != null) ...[
//                 Text('Start Date: ${widget.startDate}',
//                     style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//               ],
//               if (widget.endDate != null) ...[
//                 Text('End Date: ${widget.endDate}',
//                     style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//               ],
//               if (verifyError != null) ...[
//                 const SizedBox(height: 16),
//                 Text(
//                   'Verification error:\n$verifyError',
//                   style: const TextStyle(fontSize: 14, color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context, rootNavigator: true)
//                       .pushNamedAndRemoveUntil('/home', (r) => false);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//                 ),
//                 child: const Text('Go to Home'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SuccessPaymentPage extends StatefulWidget {
  final String? paymentRef;
  final String? subId;
  final String? startDate;
  final String? endDate;

  const SuccessPaymentPage({
    Key? key,
    this.paymentRef,
    this.subId,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage>
    with TickerProviderStateMixin {
  String? userId;
  bool isLoading = true;
  String? verifyError;
  
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeAndVerify();
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _initializeAndVerify() async {
    // 1️⃣ Load userId
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      userId = userMap['_id'] as String?;
    }

    // 2️⃣ Call your verify endpoint
    if (userId != null && widget.paymentRef != null) {
      await _callVerifyEndpoint();
    }

    setState(() => isLoading = false);
    
    // Start animations after loading
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
  }

  Future<void> _callVerifyEndpoint() async {
    final paymentId = widget.paymentRef!;
    final subId = widget.subId;
    final start = widget.startDate;
    final end = widget.endDate;
    final idUser = userId;

    final uri = Uri.parse(
      'http://localhost:8000/ELACO/subcription/verify/' +
          Uri.encodeComponent(paymentId) +
          '?idUser=${Uri.encodeComponent(idUser!)}'
              '&subId=${Uri.encodeComponent(subId!)}'
              '&start_date=${Uri.encodeComponent(start!)}'
              '&end_date=${Uri.encodeComponent(end!)}');

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Verification failed');
      }
      // ✅ verified successfully
      print('✅ Subscription verified: $data');
    } catch (e) {
      print('⚠️ verify error: $e');
      verifyError = e.toString();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
              ],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon with Animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        size: 70,
                        color: Color(0xFF10b981),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Success Message
                  SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        const Text(
                          'Payment Successful!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your subscription is now active',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Payment Details Card
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        // backdropFilter: null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10b981).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.receipt_long,
                                  color: Color(0xFF10b981),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Payment Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1f2937),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          if (widget.paymentRef != null)
                            _buildDetailRow('Payment Reference', widget.paymentRef!),
                          
                          if (widget.subId != null)
                            _buildDetailRow('Subscription ID', widget.subId!),
                          
                          if (widget.startDate != null)
                            _buildDetailRow('Start Date', _formatDate(widget.startDate!)),
                          
                          if (widget.endDate != null)
                            _buildDetailRow('End Date', _formatDate(widget.endDate!)),
                          
                          if (verifyError != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFfef2f2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFfecaca),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Color(0xFFdc2626),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Verification Notice',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFdc2626),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          verifyError!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF7f1d1d),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Success Message Footer
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.celebration,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Welcome to your premium experience!',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.95),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF6b7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1f2937),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}