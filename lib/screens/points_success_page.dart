// // // // lib/screens/points_success_page.dart

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:http/http.dart' as http;

// // // class PointsSuccessPage extends StatefulWidget {
// // //   final String? userId;
// // //   final String? points;

// // //   const PointsSuccessPage({
// // //     Key? key,
// // //     this.userId,
// // //     this.points,
// // //   }) : super(key: key);

// // //   @override
// // //   _PointsSuccessPageState createState() => _PointsSuccessPageState();
// // // }

// // // class _PointsSuccessPageState extends State<PointsSuccessPage>
// // //     with TickerProviderStateMixin {
// // //   bool isLoading = true;
// // //   String? verifyError;

// // //   late AnimationController _scaleController;
// // //   late AnimationController _slideController;
// // //   late AnimationController _fadeController;

// // //   late Animation<double> _scaleAnimation;
// // //   late Animation<Offset> _slideAnimation;
// // //   late Animation<double> _fadeAnimation;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initAnimations();
// // //     _loadAndVerify();
// // //   }

// // //   void _initAnimations() {
// // //     _scaleController = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 800),
// // //     );
// // //     _slideController = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 1000),
// // //     );
// // //     _fadeController = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 1200),
// // //     );

// // //     _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
// // //       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
// // //     );
// // //     _slideAnimation = Tween<Offset>(
// // //       begin: const Offset(0, 0.3),
// // //       end: Offset.zero,
// // //     ).animate(
// // //       CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
// // //     );
// // //     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
// // //       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
// // //     );
// // //   }

// // //   Future<void> _loadAndVerify() async {
// // //     // 1) optionally reload userId from prefs (if you need it)
// // //     final prefs = await SharedPreferences.getInstance();
// // //     final stored = prefs.getString('user');
// // //     if (stored != null && widget.userId == null) {
// // //       final map = jsonDecode(stored);
// // //       widget.userId ??= map['_id'] as String?;
// // //     }

// // //     // 2) call your backend verify‐points endpoint
// // //     if (widget.userId != null && widget.points != null) {
// // //       try {
// // //         final uri = Uri.parse(
// // //           'http://localhost:8000/points/verify'
// // //           '?userId=${Uri.encodeComponent(widget.userId!)}'
// // //           '&points=${Uri.encodeComponent(widget.points!)}'
// // //         );
// // //         final resp = await http.get(uri);
// // //         if (resp.statusCode != 200) {
// // //           throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
// // //         }
// // //         final data = jsonDecode(resp.body);
// // //         if (data['status'] != 'success') {
// // //           throw Exception(data['message'] ?? 'Points verification failed');
// // //         }
// // //       } catch (e) {
// // //         verifyError = e.toString();
// // //       }
// // //     }

// // //     setState(() => isLoading = false);

// // //     // 3) run animations
// // //     _scaleController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _slideController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 300));
// // //     _fadeController.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _scaleController.dispose();
// // //     _slideController.dispose();
// // //     _fadeController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (isLoading) {
// // //       return Scaffold(
// // //         body: Container(
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //             ),
// // //           ),
// // //           child: const Center(
// // //             child: CircularProgressIndicator(
// // //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // //               strokeWidth: 3,
// // //             ),
// // //           ),
// // //         ),
// // //       );
// // //     }

// // //     return Scaffold(
// // //       body: Container(
// // //         decoration: const BoxDecoration(
// // //           gradient: LinearGradient(
// // //             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //           ),
// // //         ),
// // //         child: SafeArea(
// // //           child: Center(
// // //             child: SingleChildScrollView(
// // //               padding: const EdgeInsets.all(24),
// // //               child: Column(
// // //                 children: [
// // //                   // ✅ Success Icon
// // //                   ScaleTransition(
// // //                     scale: _scaleAnimation,
// // //                     child: Container(
// // //                       width: 120,
// // //                       height: 120,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         shape: BoxShape.circle,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             color: Colors.black.withOpacity(0.1),
// // //                             blurRadius: 20,
// // //                             offset: const Offset(0, 10),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.check_circle,
// // //                         size: 70,
// // //                         color: Color(0xFF10b981),
// // //                       ),
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 32),

// // //                   // 🎉 Messages
// // //                   SlideTransition(
// // //                     position: _slideAnimation,
// // //                     child: Column(
// // //                       children: const [
// // //                         Text(
// // //                           'Points Added!',
// // //                           textAlign: TextAlign.center,
// // //                           style: TextStyle(
// // //                             fontSize: 28,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.white,
// // //                           ),
// // //                         ),
// // //                         SizedBox(height: 12),
// // //                         Text(
// // //                           'Thank you! Your account has been credited.',
// // //                           textAlign: TextAlign.center,
// // //                           style: TextStyle(
// // //                             fontSize: 16,
// // //                             color: Colors.white70,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 40),

// // //                   // 📋 Details Card
// // //                   FadeTransition(
// // //                     opacity: _fadeAnimation,
// // //                     child: Container(
// // //                       padding: const EdgeInsets.all(24),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white.withOpacity(0.95),
// // //                         borderRadius: BorderRadius.circular(20),
// // //                       ),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const Row(
// // //                             children: [
// // //                               Icon(Icons.receipt_long, color: Color(0xFF10b981)),
// // //                               SizedBox(width: 8),
// // //                               Text(
// // //                                 'Details',
// // //                                 style: TextStyle(
// // //                                   fontSize: 18,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Color(0xFF1f2937),
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 20),
// // //                           if (widget.userId != null)
// // //                             _buildDetailRow('User ID', widget.userId!),
// // //                           if (widget.points != null)
// // //                             _buildDetailRow('Points', widget.points!),
// // //                           _buildDetailRow('Time', _formatDateTime(DateTime.now())),
// // //                           if (verifyError != null) ...[
// // //                             const SizedBox(height: 16),
// // //                             Text(
// // //                               'Verification issue: $verifyError',
// // //                               style: const TextStyle(
// // //                                 color: Colors.redAccent,
// // //                                 fontSize: 12,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 32),

// // //                   // 🔒 Footer reassurance
// // //                   FadeTransition(
// // //                     opacity: _fadeAnimation,
// // //                     child: Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 20, vertical: 16),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white24,
// // //                         borderRadius: BorderRadius.circular(15),
// // //                       ),
// // //                       child: Row(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: const [
// // //                           Icon(Icons.security, color: Colors.white),
// // //                           SizedBox(width: 8),
// // //                           Text(
// // //                             'Your data is safe and secure',
// // //                             style: TextStyle(color: Colors.white70),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDetailRow(String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(bottom: 12),
// // //       child: Row(
// // //         children: [
// // //           SizedBox(
// // //             width: 100,
// // //             child: Text(label,
// // //                 style: const TextStyle(
// // //                   fontSize: 14,
// // //                   color: Color(0xFF6b7280),
// // //                   fontWeight: FontWeight.w500,
// // //                 )),
// // //           ),
// // //           const SizedBox(width: 16),
// // //           Expanded(
// // //             child: Text(value,
// // //                 style: const TextStyle(
// // //                   fontSize: 14,
// // //                   color: Color(0xFF1f2937),
// // //                   fontWeight: FontWeight.w600,
// // //                 )),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   String _formatDateTime(DateTime dt) {
// // //     final y = dt.year.toString().padLeft(4, '0');
// // //     final m = dt.month.toString().padLeft(2, '0');
// // //     final d = dt.day.toString().padLeft(2, '0');
// // //     final hh = dt.hour.toString().padLeft(2, '0');
// // //     final mm = dt.minute.toString().padLeft(2, '0');
// // //     return '$hh:$mm  $d/$m/$y';
// // //   }
// // // }

// // // lib/screens/points_success_page.dart

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;

// // class PointsSuccessPage extends StatefulWidget {
// //   /// You can pass userId in the URL query, or let this page pull
// //   /// it from SharedPreferences if null.
// //   final String? userId;
// //   final String? points;

// //   const PointsSuccessPage({
// //     Key? key,
// //     this.userId,
// //     this.points,
// //   }) : super(key: key);

// //   @override
// //   _PointsSuccessPageState createState() => _PointsSuccessPageState();
// // }

// // class _PointsSuccessPageState extends State<PointsSuccessPage>
// //     with TickerProviderStateMixin {
// //   bool isLoading = true;
// //   String? verifyError;
// //   String? _userId;

// //   late AnimationController _scaleController;
// //   late AnimationController _slideController;
// //   late AnimationController _fadeController;

// //   late Animation<double> _scaleAnimation;
// //   late Animation<Offset> _slideAnimation;
// //   late Animation<double> _fadeAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialize local copy of userId
// //     _userId = widget.userId;
// //     _initAnimations();
// //     _loadAndVerify();
// //   }

// //   void _initAnimations() {
// //     _scaleController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 800),
// //     );
// //     _slideController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1000),
// //     );
// //     _fadeController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1200),
// //     );

// //     _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
// //       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
// //     );
// //     _slideAnimation = Tween<Offset>(
// //       begin: const Offset(0, 0.3),
// //       end: Offset.zero,
// //     ).animate(
// //       CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
// //     );
// //     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
// //       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
// //     );
// //   }

// //   Future<void> _loadAndVerify() async {
// //     // 1️⃣ If no userId passed, try reading it from prefs
// //     if (_userId == null) {
// //       final prefs = await SharedPreferences.getInstance();
// //       final stored = prefs.getString('user');
// //       if (stored != null) {
// //         final map = jsonDecode(stored) as Map<String, dynamic>;
// //         _userId = map['_id'] as String?;
// //       }
// //     }

// //     // 2️⃣ Call your backend verify‐points endpoint
// //     if (_userId != null && widget.points != null) {
// //       try {
// //         final uri = Uri.parse(
// //           'http://localhost:8000/points/verify'
// //           '?userId=${Uri.encodeComponent(_userId!)}'
// //           '&points=${Uri.encodeComponent(widget.points!)}',
// //         );
// //         final resp = await http.get(uri);
// //         if (resp.statusCode != 200) {
// //           throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
// //         }
// //         final data = jsonDecode(resp.body) as Map<String, dynamic>;
// //         if (data['status'] != 'success') {
// //           throw Exception(data['message'] ?? 'Points verification failed');
// //         }
// //       } catch (e) {
// //         verifyError = e.toString();
// //       }
// //     }

// //     // 3️⃣ Done loading, kick off animations
// //     setState(() => isLoading = false);
// //     _scaleController.forward();
// //     await Future.delayed(const Duration(milliseconds: 200));
// //     _slideController.forward();
// //     await Future.delayed(const Duration(milliseconds: 300));
// //     _fadeController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _scaleController.dispose();
// //     _slideController.dispose();
// //     _fadeController.dispose();
// //     super.dispose();
// //   }

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 12),
// //       child: Row(
// //         children: [
// //           SizedBox(
// //             width: 100,
// //             child: Text(label,
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   color: Color(0xFF6b7280),
// //                   fontWeight: FontWeight.w500,
// //                 )),
// //           ),
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: Text(value,
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   color: Color(0xFF1f2937),
// //                   fontWeight: FontWeight.w600,
// //                 )),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   String _formatDateTime(DateTime dt) {
// //     final h = dt.hour.toString().padLeft(2, '0');
// //     final m = dt.minute.toString().padLeft(2, '0');
// //     final d = dt.day.toString().padLeft(2, '0');
// //     final mo = dt.month.toString().padLeft(2, '0');
// //     final y = dt.year.toString();
// //     return '$h:$m  $d/$mo/$y';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (isLoading) {
// //       return Scaffold(
// //         body: Container(
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //             ),
// //           ),
// //           child: const Center(
// //             child: CircularProgressIndicator(
// //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// //               strokeWidth: 3,
// //             ),
// //           ),
// //         ),
// //       );
// //     }

// //     return Scaffold(
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Center(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(24),
// //               child: Column(
// //                 children: [
// //                   ScaleTransition(
// //                     scale: _scaleAnimation,
// //                     child: Container(
// //                       width: 120,
// //                       height: 120,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                               color: Colors.black.withOpacity(0.1),
// //                               blurRadius: 20,
// //                               offset: const Offset(0, 10)),
// //                         ],
// //                       ),
// //                       child: const Icon(
// //                         Icons.check_circle,
// //                         size: 70,
// //                         color: Color(0xFF10b981),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 32),
// //                   SlideTransition(
// //                     position: _slideAnimation,
// //                     child: Column(
// //                       children: const [
// //                         Text(
// //                           'Points Added!',
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         SizedBox(height: 12),
// //                         Text(
// //                           'Thank you! Your account has been credited.',
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             color: Colors.white70,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 40),
// //                   FadeTransition(
// //                     opacity: _fadeAnimation,
// //                     child: Container(
// //                       padding: const EdgeInsets.all(24),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.95),
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Row(
// //                             children: [
// //                               Icon(Icons.receipt_long,
// //                                   color: Color(0xFF10b981)),
// //                               SizedBox(width: 8),
// //                               Text(
// //                                 'Details',
// //                                 style: TextStyle(
// //                                   fontSize: 18,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Color(0xFF1f2937),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 20),
// //                           if (_userId != null)
// //                             _buildDetailRow('User ID', _userId!),
// //                           if (widget.points != null)
// //                             _buildDetailRow('Points', widget.points!),
// //                           _buildDetailRow('Time', _formatDateTime(DateTime.now())),
// //                           if (verifyError != null) ...[
// //                             const SizedBox(height: 16),
// //                             Text(
// //                               'Verification issue: $verifyError',
// //                               style: const TextStyle(
// //                                 color: Colors.redAccent,
// //                                 fontSize: 12,
// //                               ),
// //                             ),
// //                           ],
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 32),
// //                   FadeTransition(
// //                     opacity: _fadeAnimation,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 16),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white24,
// //                         borderRadius: BorderRadius.circular(15),
// //                       ),
// //                       child: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: const [
// //                           Icon(Icons.security, color: Colors.white),
// //                           SizedBox(width: 8),
// //                           Text(
// //                             'Your data is safe and secure',
// //                             style: TextStyle(color: Colors.white70),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // lib/screens/points_success_page.dart

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class PointsSuccessPage extends StatefulWidget {
//   /// These come from your redirect URL:
//   final String? paymentId;
//   final String? userId;
//   final String? points;

//   const PointsSuccessPage({
//     Key? key,
//     this.paymentId,
//     this.userId,
//     this.points,
//   }) : super(key: key);

//   @override
//   _PointsSuccessPageState createState() => _PointsSuccessPageState();
// }

// class _PointsSuccessPageState extends State<PointsSuccessPage>
//     with TickerProviderStateMixin {
//   bool isLoading = true;
//   String? verifyError;

//   // Local copies so we can fall back on SharedPreferences if needed:
//   late String? _paymentId;
//   late String? _userId;
//   late String? _points;

//   // Animations:
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late AnimationController _fadeController;

//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _paymentId = widget.paymentId;
//     _userId    = widget.userId;
//     _points    = widget.points;
//     _initAnimations();
//     _loadAndVerify();
//   }

//   void _initAnimations() {
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
//     );
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );
//   }

//   Future<void> _loadAndVerify() async {
//     // 1️⃣ If userId was not passed, load from prefs
//     if (_userId == null) {
//       final prefs = await SharedPreferences.getInstance();
//       final stored = prefs.getString('user');
//       if (stored != null) {
//         final map = jsonDecode(stored) as Map<String, dynamic>;
//         _userId = map['_id'] as String?;
//       }
//     }

//     // 2️⃣ Call your verify endpoint
//     if (_paymentId != null && _userId != null && _points != null) {
//       final uri = Uri.parse(
//         'http://localhost:8000/ELACO/verify/'
//         '${Uri.encodeComponent(_paymentId!)}'
//         '?userId=${Uri.encodeComponent(_userId!)}'
//         '&points=${Uri.encodeComponent(_points!)}',
//       );
//       try {
//         final resp = await http.get(uri);
//         if (resp.statusCode != 200) {
//           throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
//         }
//         final data = jsonDecode(resp.body) as Map<String, dynamic>;
//         if (data['status'] != 'success') {
//           throw Exception(data['message'] ?? 'Verify failed');
//         }
//         // success
//         print('✅ Points verified: $data');
//       } catch (e) {
//         verifyError = e.toString();
//       }
//     }

//     // 3️⃣ All done: show UI & play animations
//     setState(() => isLoading = false);
//     _scaleController.forward();
//     await Future.delayed(const Duration(milliseconds: 200));
//     _slideController.forward();
//     await Future.delayed(const Duration(milliseconds: 300));
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _scaleController.dispose();
//     _slideController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   String _formatDateTime(DateTime dt) {
//     final hh = dt.hour.toString().padLeft(2, '0');
//     final mm = dt.minute.toString().padLeft(2, '0');
//     final dd = dt.day.toString().padLeft(2, '0');
//     final mo = dt.month.toString().padLeft(2, '0');
//     final yy = dt.year.toString();
//     return '$hh:$mm  $dd/$mo/$yy';
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(label,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF6b7280),
//                   fontWeight: FontWeight.w500,
//                 )),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//             ),
//           ),
//           child: const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               strokeWidth: 3,
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 20,
//                               offset: const Offset(0, 10)),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.check_circle,
//                         size: 70,
//                         color: Color(0xFF10b981),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: Column(
//                       children: const [
//                         Text(
//                           'Points Added!',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Your account has been credited.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.95),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Row(
//                             children: [
//                               Icon(Icons.receipt_long,
//                                   color: Color(0xFF10b981)),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Details',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF1f2937),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           if (_paymentId != null)
//                             _buildDetailRow('Payment ID', _paymentId!),
//                           if (_userId    != null)
//                             _buildDetailRow('User ID',    _userId!),
//                           if (_points    != null)
//                             _buildDetailRow('Points',     _points!),
//                           _buildDetailRow('Time', _formatDateTime(DateTime.now())),
//                           if (verifyError != null) ...[
//                             const SizedBox(height: 16),
//                             Text(
//                               'Verification issue: $verifyError',
//                               style: const TextStyle(
//                                   color: Colors.redAccent, fontSize: 12),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.white24,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: const [
//                           Icon(Icons.security, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             'Your data is safe and secure',
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// lib/screens/points_success_page.dart
//
// Success screen for the “add-points” payment flow.
//  • Plays a short success animation
//  • Immediately calls your verify endpoint:
//
//    GET http://localhost:8000/ELACO/verify/{paymentRef}?userId={userId}&points={points}
//
//  • Shows the details (and any verification error) to the user.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PointsSuccessPage extends StatefulWidget {
  /// Values arrive from the success redirect URL:
  ///   #/points/verify?status=success&payment_ref=…&userId=…&points=…
  final String? paymentId;    // = payment_ref
  final String? userId;
  final String? points;

  const PointsSuccessPage({
    Key? key,
    this.paymentId,
    this.userId,
    this.points,
  }) : super(key: key);

  @override
  State<PointsSuccessPage> createState() => _PointsSuccessPageState();
}

class _PointsSuccessPageState extends State<PointsSuccessPage>
    with TickerProviderStateMixin {
  // ───────────────────────── state ─────────────────────────
  bool   _loading      = true;
  String? _verifyError;

  late final String? _paymentId = widget.paymentId;
  late final String? _userId    = widget.userId;
  late final String? _points    = widget.points;

  // ───────────────────────── animations ─────────────────────────
  late final AnimationController _scaleCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
  late final AnimationController _slideCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
  late final AnimationController _fadeCtrl   = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

  late final Animation<double> _scaleAnim = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut));
  late final Animation<Offset> _slideAnim = Tween(begin: const Offset(0, .3), end: Offset.zero)
      .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
  late final Animation<double> _fadeAnim  = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut));

  // ───────────────────────── lifecycle ─────────────────────────
  @override
  void initState() {
    super.initState();
    _verifyPayment();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _slideCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  // ───────────────────────── network call ─────────────────────────
  Future<void> _verifyPayment() async {
    if (_paymentId != null && _userId != null && _points != null) {
      final uri = Uri.parse(
        'http://localhost:8000/ELACO/verify/'
        '${Uri.encodeComponent(_paymentId!)}'
        '?userId=${Uri.encodeComponent(_userId!)}'
        '&points=${Uri.encodeComponent(_points!)}',
      );

      try {
        final res = await http.get(uri);
        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        if (data['status'] != 'success') {
          throw Exception(data['message'] ?? 'Verification failed');
        }
      } catch (e) {
        _verifyError = e.toString();
      }
    }

    setState(() => _loading = false);

    // play animations
    _scaleCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeCtrl.forward();
  }

  // ───────────────────────── helpers ─────────────────────────
  String _formatDateTime(DateTime dt) {
    final h  = dt.hour.toString().padLeft(2, '0');
    final m  = dt.minute.toString().padLeft(2, '0');
    final d  = dt.day.toString().padLeft(2, '0');
    final mo = dt.month.toString().padLeft(2, '0');
    final y  = dt.year.toString();
    return '$h:$m  $d/$mo/$y';
  }

  Widget _detail(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6b7280),
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );

  // ───────────────────────── UI ─────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // ✅ Icon
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: const Icon(Icons.check_circle,
                        size: 110, color: Color(0xFF10b981)),
                  ),
                  const SizedBox(height: 30),
                  // Title
                  SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      children: const [
                        Text(
                          'Points Added!',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Thank you — your balance has been updated.',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Details card
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.receipt_long,
                                  color: Color(0xFF10b981)),
                              SizedBox(width: 8),
                              Text('Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (_paymentId != null)
                            _detail('Payment Ref', _paymentId!),
                          if (_userId != null) _detail('User ID', _userId!),
                          if (_points != null) _detail('Points', _points!),
                          _detail('Time', _formatDateTime(DateTime.now())),
                          if (_verifyError != null) ...[
                            const SizedBox(height: 16),
                            Text('Verification issue: $_verifyError',
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 12)),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Footer note
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.security, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Your data is safe & secure',
                              style: TextStyle(color: Colors.white70)),
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
}
