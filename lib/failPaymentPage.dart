// // // // // // import 'dart:convert';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // // // class FailPaymentPage extends StatefulWidget {
// // // // // //   final String? paymentRef;
// // // // // //   final String? errorMessage;
// // // // // //   final String? errorCode;

// // // // // //   const FailPaymentPage({
// // // // // //     Key? key,
// // // // // //     this.paymentRef,
// // // // // //     this.errorMessage,
// // // // // //     this.errorCode,
// // // // // //   }) : super(key: key);

// // // // // //   @override
// // // // // //   State<FailPaymentPage> createState() => _FailPaymentPageState();
// // // // // // }

// // // // // // class _FailPaymentPageState extends State<FailPaymentPage>
// // // // // //     with TickerProviderStateMixin {
// // // // // //   String? userId;
// // // // // //   bool isLoading = true;
  
// // // // // //   late AnimationController _shakeController;
// // // // // //   late AnimationController _slideController;
// // // // // //   late AnimationController _fadeController;
// // // // // //   late AnimationController _pulseController;
  
// // // // // //   late Animation<double> _shakeAnimation;
// // // // // //   late Animation<Offset> _slideAnimation;
// // // // // //   late Animation<double> _fadeAnimation;
// // // // // //   late Animation<double> _pulseAnimation;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _initializeAnimations();
// // // // // //     _initializeData();
// // // // // //   }

// // // // // //   void _initializeAnimations() {
// // // // // //     _shakeController = AnimationController(
// // // // // //       duration: const Duration(milliseconds: 800),
// // // // // //       vsync: this,
// // // // // //     );
// // // // // //     _slideController = AnimationController(
// // // // // //       duration: const Duration(milliseconds: 1000),
// // // // // //       vsync: this,
// // // // // //     );
// // // // // //     _fadeController = AnimationController(
// // // // // //       duration: const Duration(milliseconds: 1200),
// // // // // //       vsync: this,
// // // // // //     );
// // // // // //     _pulseController = AnimationController(
// // // // // //       duration: const Duration(milliseconds: 2000),
// // // // // //       vsync: this,
// // // // // //     );

// // // // // //     _shakeAnimation = Tween<double>(
// // // // // //       begin: 0.0,
// // // // // //       end: 1.0,
// // // // // //     ).animate(CurvedAnimation(
// // // // // //       parent: _shakeController,
// // // // // //       curve: Curves.elasticOut,
// // // // // //     ));

// // // // // //     _slideAnimation = Tween<Offset>(
// // // // // //       begin: const Offset(0, 0.3),
// // // // // //       end: Offset.zero,
// // // // // //     ).animate(CurvedAnimation(
// // // // // //       parent: _slideController,
// // // // // //       curve: Curves.easeOutCubic,
// // // // // //     ));

// // // // // //     _fadeAnimation = Tween<double>(
// // // // // //       begin: 0.0,
// // // // // //       end: 1.0,
// // // // // //     ).animate(CurvedAnimation(
// // // // // //       parent: _fadeController,
// // // // // //       curve: Curves.easeInOut,
// // // // // //     ));

// // // // // //     _pulseAnimation = Tween<double>(
// // // // // //       begin: 1.0,
// // // // // //       end: 1.05,
// // // // // //     ).animate(CurvedAnimation(
// // // // // //       parent: _pulseController,
// // // // // //       curve: Curves.easeInOut,
// // // // // //     ));

// // // // // //     // Start pulse animation loop
// // // // // //     _pulseController.repeat(reverse: true);
// // // // // //   }

// // // // // //   Future<void> _initializeData() async {
// // // // // //     // Load userId from SharedPreferences
// // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // //     final userJson = prefs.getString('user');
// // // // // //     if (userJson != null) {
// // // // // //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
// // // // // //       userId = userMap['_id'] as String?;
// // // // // //     }

// // // // // //     setState(() => isLoading = false);
    
// // // // // //     // Start animations after loading
// // // // // //     _shakeController.forward();
// // // // // //     await Future.delayed(const Duration(milliseconds: 300));
// // // // // //     _slideController.forward();
// // // // // //     await Future.delayed(const Duration(milliseconds: 200));
// // // // // //     _fadeController.forward();
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _shakeController.dispose();
// // // // // //     _slideController.dispose();
// // // // // //     _fadeController.dispose();
// // // // // //     _pulseController.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   String _getErrorTitle() {
// // // // // //     if (widget.errorCode != null) {
// // // // // //       switch (widget.errorCode!.toLowerCase()) {
// // // // // //         case 'insufficient_funds':
// // // // // //           return 'Insufficient Funds';
// // // // // //         case 'card_declined':
// // // // // //           return 'Card Declined';
// // // // // //         case 'expired_card':
// // // // // //           return 'Card Expired';
// // // // // //         case 'network_error':
// // // // // //           return 'Connection Issue';
// // // // // //         default:
// // // // // //           return 'Payment Failed';
// // // // // //       }
// // // // // //     }
// // // // // //     return 'Payment Failed';
// // // // // //   }

// // // // // //   String _getErrorDescription() {
// // // // // //     if (widget.errorCode != null) {
// // // // // //       switch (widget.errorCode!.toLowerCase()) {
// // // // // //         case 'insufficient_funds':
// // // // // //           return 'Your account doesn\'t have enough funds for this transaction';
// // // // // //         case 'card_declined':
// // // // // //           return 'Your card was declined by the bank. Please try another payment method';
// // // // // //         case 'expired_card':
// // // // // //           return 'Your card has expired. Please update your payment information';
// // // // // //         case 'network_error':
// // // // // //           return 'We couldn\'t process your payment due to a connection issue';
// // // // // //         default:
// // // // // //           return 'We couldn\'t process your payment. Please try again';
// // // // // //       }
// // // // // //     }
// // // // // //     return widget.errorMessage ?? 'We couldn\'t process your payment. Please try again';
// // // // // //   }

// // // // // //   void _retryPayment() {
// // // // // //     // Navigate back to payment page or trigger retry logic
// // // // // //     Navigator.of(context).pop();
// // // // // //   }

// // // // // //   void _contactSupport() {
// // // // // //     // Handle contact support action
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (context) => AlertDialog(
// // // // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // // // // //         title: const Text('Contact Support'),
// // // // // //         content: const Text('Our support team will help you resolve this issue. You can reach us at support@elaco.com or call +1-555-0123'),
// // // // // //         actions: [
// // // // // //           TextButton(
// // // // // //             onPressed: () => Navigator.of(context).pop(),
// // // // // //             child: const Text('Got it'),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     if (isLoading) {
// // // // // //       return Scaffold(
// // // // // //         body: Container(
// // // // // //           decoration: const BoxDecoration(
// // // // // //             gradient: LinearGradient(
// // // // // //               begin: Alignment.topLeft,
// // // // // //               end: Alignment.bottomRight,
// // // // // //               colors: [
// // // // // //                 Color(0xFFff6b6b),
// // // // // //                 Color(0xFFee5a52),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //           child: const Center(
// // // // // //             child: CircularProgressIndicator(
// // // // // //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // // // //               strokeWidth: 3,
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       );
// // // // // //     }

// // // // // //     return Scaffold(
// // // // // //       body: Container(
// // // // // //         decoration: const BoxDecoration(
// // // // // //           gradient: LinearGradient(
// // // // // //             begin: Alignment.topLeft,
// // // // // //             end: Alignment.bottomRight,
// // // // // //             colors: [
// // // // // //               Color(0xFFff6b6b),
// // // // // //               Color(0xFFee5a52),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //         child: SafeArea(
// // // // // //           child: Center(
// // // // // //             child: SingleChildScrollView(
// // // // // //               padding: const EdgeInsets.all(24.0),
// // // // // //               child: Column(
// // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                 children: [
// // // // // //                   // Error Icon with Animation
// // // // // //                   ScaleTransition(
// // // // // //                     scale: _shakeAnimation,
// // // // // //                     child: Container(
// // // // // //                       width: 120,
// // // // // //                       height: 120,
// // // // // //                       decoration: BoxDecoration(
// // // // // //                         color: Colors.white,
// // // // // //                         shape: BoxShape.circle,
// // // // // //                         boxShadow: [
// // // // // //                           BoxShadow(
// // // // // //                             color: Colors.black.withOpacity(0.1),
// // // // // //                             blurRadius: 20,
// // // // // //                             offset: const Offset(0, 10),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                       child: const Icon(
// // // // // //                         Icons.error_outline,
// // // // // //                         size: 70,
// // // // // //                         color: Color(0xFFdc2626),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
                  
// // // // // //                   const SizedBox(height: 32),
                  
// // // // // //                   // Error Message
// // // // // //                   SlideTransition(
// // // // // //                     position: _slideAnimation,
// // // // // //                     child: Column(
// // // // // //                       children: [
// // // // // //                         Text(
// // // // // //                           _getErrorTitle(),
// // // // // //                           style: const TextStyle(
// // // // // //                             fontSize: 28,
// // // // // //                             fontWeight: FontWeight.bold,
// // // // // //                             color: Colors.white,
// // // // // //                             letterSpacing: 0.5,
// // // // // //                           ),
// // // // // //                           textAlign: TextAlign.center,
// // // // // //                         ),
// // // // // //                         const SizedBox(height: 12),
// // // // // //                         Text(
// // // // // //                           _getErrorDescription(),
// // // // // //                           style: TextStyle(
// // // // // //                             fontSize: 16,
// // // // // //                             color: Colors.white.withOpacity(0.9),
// // // // // //                             fontWeight: FontWeight.w400,
// // // // // //                           ),
// // // // // //                           textAlign: TextAlign.center,
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
                  
// // // // // //                   const SizedBox(height: 40),
                  
// // // // // //                   // Error Details Card
// // // // // //                   if (widget.paymentRef != null || widget.errorCode != null)
// // // // // //                     FadeTransition(
// // // // // //                       opacity: _fadeAnimation,
// // // // // //                       child: Container(
// // // // // //                         width: double.infinity,
// // // // // //                         margin: const EdgeInsets.symmetric(horizontal: 8),
// // // // // //                         padding: const EdgeInsets.all(24),
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: Colors.white.withOpacity(0.95),
// // // // // //                           borderRadius: BorderRadius.circular(20),
// // // // // //                           boxShadow: [
// // // // // //                             BoxShadow(
// // // // // //                               color: Colors.black.withOpacity(0.1),
// // // // // //                               blurRadius: 20,
// // // // // //                               offset: const Offset(0, 8),
// // // // // //                             ),
// // // // // //                           ],
// // // // // //                         ),
// // // // // //                         child: Column(
// // // // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                           children: [
// // // // // //                             Row(
// // // // // //                               children: [
// // // // // //                                 Container(
// // // // // //                                   padding: const EdgeInsets.all(8),
// // // // // //                                   decoration: BoxDecoration(
// // // // // //                                     color: const Color(0xFFdc2626).withOpacity(0.1),
// // // // // //                                     borderRadius: BorderRadius.circular(10),
// // // // // //                                   ),
// // // // // //                                   child: const Icon(
// // // // // //                                     Icons.info_outline,
// // // // // //                                     color: Color(0xFFdc2626),
// // // // // //                                     size: 20,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                                 const SizedBox(width: 12),
// // // // // //                                 const Text(
// // // // // //                                   'Transaction Details',
// // // // // //                                   style: TextStyle(
// // // // // //                                     fontSize: 18,
// // // // // //                                     fontWeight: FontWeight.bold,
// // // // // //                                     color: Color(0xFF1f2937),
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),
                            
// // // // // //                             const SizedBox(height: 20),
                            
// // // // // //                             if (widget.paymentRef != null)
// // // // // //                               _buildDetailRow('Reference', widget.paymentRef!),
                            
// // // // // //                             if (widget.errorCode != null)
// // // // // //                               _buildDetailRow('Error Code', widget.errorCode!.toUpperCase()),
                            
// // // // // //                             _buildDetailRow('Status', 'Failed'),
// // // // // //                             _buildDetailRow('Time', _getCurrentTime()),
// // // // // //                           ],
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ),
                  
// // // // // //                   const SizedBox(height: 40),
                  
// // // // // //                   // Action Buttons
// // // // // //                   FadeTransition(
// // // // // //                     opacity: _fadeAnimation,
// // // // // //                     child: Column(
// // // // // //                       children: [
// // // // // //                         // Retry Button
// // // // // //                         ScaleTransition(
// // // // // //                           scale: _pulseAnimation,
// // // // // //                           child: SizedBox(
// // // // // //                             width: double.infinity,
// // // // // //                             child: ElevatedButton(
// // // // // //                               onPressed: _retryPayment,
// // // // // //                               style: ElevatedButton.styleFrom(
// // // // // //                                 backgroundColor: Colors.white,
// // // // // //                                 foregroundColor: const Color(0xFFdc2626),
// // // // // //                                 padding: const EdgeInsets.symmetric(
// // // // // //                                   horizontal: 32,
// // // // // //                                   vertical: 16,
// // // // // //                                 ),
// // // // // //                                 shape: RoundedRectangleBorder(
// // // // // //                                   borderRadius: BorderRadius.circular(15),
// // // // // //                                 ),
// // // // // //                                 elevation: 8,
// // // // // //                                 shadowColor: Colors.black.withOpacity(0.2),
// // // // // //                               ),
// // // // // //                               child: Row(
// // // // // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                                 children: const [
// // // // // //                                   Icon(Icons.refresh, size: 20),
// // // // // //                                   SizedBox(width: 8),
// // // // // //                                   Text(
// // // // // //                                     'Try Again',
// // // // // //                                     style: TextStyle(
// // // // // //                                       fontSize: 16,
// // // // // //                                       fontWeight: FontWeight.w600,
// // // // // //                                     ),
// // // // // //                                   ),
// // // // // //                                 ],
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ),
                        
// // // // // //                         const SizedBox(height: 16),
                        
// // // // // //                         // Contact Support Button
// // // // // //                         SizedBox(
// // // // // //                           width: double.infinity,
// // // // // //                           child: OutlinedButton(
// // // // // //                             onPressed: _contactSupport,
// // // // // //                             style: OutlinedButton.styleFrom(
// // // // // //                               foregroundColor: Colors.white,
// // // // // //                               side: const BorderSide(color: Colors.white, width: 2),
// // // // // //                               padding: const EdgeInsets.symmetric(
// // // // // //                                 horizontal: 32,
// // // // // //                                 vertical: 16,
// // // // // //                               ),
// // // // // //                               shape: RoundedRectangleBorder(
// // // // // //                                 borderRadius: BorderRadius.circular(15),
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                             child: Row(
// // // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                               children: const [
// // // // // //                                 Icon(Icons.support_agent, size: 20),
// // // // // //                                 SizedBox(width: 8),
// // // // // //                                 Text(
// // // // // //                                   'Contact Support',
// // // // // //                                   style: TextStyle(
// // // // // //                                     fontSize: 16,
// // // // // //                                     fontWeight: FontWeight.w500,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
                  
// // // // // //                   const SizedBox(height: 32),
                  
// // // // // //                   // Reassurance Footer
// // // // // //                   FadeTransition(
// // // // // //                     opacity: _fadeAnimation,
// // // // // //                     child: Container(
// // // // // //                       padding: const EdgeInsets.symmetric(
// // // // // //                         horizontal: 20,
// // // // // //                         vertical: 16,
// // // // // //                       ),
// // // // // //                       decoration: BoxDecoration(
// // // // // //                         color: Colors.white.withOpacity(0.2),
// // // // // //                         borderRadius: BorderRadius.circular(15),
// // // // // //                         border: Border.all(
// // // // // //                           color: Colors.white.withOpacity(0.3),
// // // // // //                           width: 1,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       child: Row(
// // // // // //                         mainAxisSize: MainAxisSize.min,
// // // // // //                         children: [
// // // // // //                           const Icon(
// // // // // //                             Icons.security,
// // // // // //                             color: Colors.white,
// // // // // //                             size: 20,
// // // // // //                           ),
// // // // // //                           const SizedBox(width: 8),
// // // // // //                           Text(
// // // // // //                             'Your information is safe and secure',
// // // // // //                             style: TextStyle(
// // // // // //                               color: Colors.white.withOpacity(0.95),
// // // // // //                               fontSize: 14,
// // // // // //                               fontWeight: FontWeight.w500,
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildDetailRow(String label, String value) {
// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.only(bottom: 16),
// // // // // //       child: Row(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           SizedBox(
// // // // // //             width: 100,
// // // // // //             child: Text(
// // // // // //               label,
// // // // // //               style: const TextStyle(
// // // // // //                 fontSize: 14,
// // // // // //                 color: Color(0xFF6b7280),
// // // // // //                 fontWeight: FontWeight.w500,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           const SizedBox(width: 16),
// // // // // //           Expanded(
// // // // // //             child: Text(
// // // // // //               value,
// // // // // //               style: const TextStyle(
// // // // // //                 fontSize: 14,
// // // // // //                 color: Color(0xFF1f2937),
// // // // // //                 fontWeight: FontWeight.w600,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   String _getCurrentTime() {
// // // // // //     final now = DateTime.now();
// // // // // //     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day}/${now.month}/${now.year}';
// // // // // //   }
// // // // // // }

// // // // // import 'dart:convert';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // // class FailPaymentPage extends StatefulWidget {
// // // // //   final String? paymentRef;
// // // // //   final String? errorMessage;
// // // // //   final String? errorCode;

// // // // //   const FailPaymentPage({
// // // // //     Key? key,
// // // // //     this.paymentRef,
// // // // //     this.errorMessage,
// // // // //     this.errorCode,
// // // // //   }) : super(key: key);

// // // // //   @override
// // // // //   State<FailPaymentPage> createState() => _FailPaymentPageState();
// // // // // }

// // // // // class _FailPaymentPageState extends State<FailPaymentPage>
// // // // //     with TickerProviderStateMixin {
// // // // //   String? userId;
// // // // //   bool isLoading = true;
  
// // // // //   late AnimationController _shakeController;
// // // // //   late AnimationController _slideController;
// // // // //   late AnimationController _fadeController;
// // // // //   late AnimationController _pulseController;
  
// // // // //   late Animation<double> _shakeAnimation;
// // // // //   late Animation<Offset> _slideAnimation;
// // // // //   late Animation<double> _fadeAnimation;
// // // // //   late Animation<double> _pulseAnimation;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initializeAnimations();
// // // // //     _initializeData();
// // // // //   }

// // // // //   void _initializeAnimations() {
// // // // //     _shakeController = AnimationController(
// // // // //       duration: const Duration(milliseconds: 800),
// // // // //       vsync: this,
// // // // //     );
// // // // //     _slideController = AnimationController(
// // // // //       duration: const Duration(milliseconds: 1000),
// // // // //       vsync: this,
// // // // //     );
// // // // //     _fadeController = AnimationController(
// // // // //       duration: const Duration(milliseconds: 1200),
// // // // //       vsync: this,
// // // // //     );
// // // // //     _pulseController = AnimationController(
// // // // //       duration: const Duration(milliseconds: 2000),
// // // // //       vsync: this,
// // // // //     );

// // // // //     _shakeAnimation = Tween<double>(
// // // // //       begin: 0.0,
// // // // //       end: 1.0,
// // // // //     ).animate(CurvedAnimation(
// // // // //       parent: _shakeController,
// // // // //       curve: Curves.elasticOut,
// // // // //     ));

// // // // //     _slideAnimation = Tween<Offset>(
// // // // //       begin: const Offset(0, 0.3),
// // // // //       end: Offset.zero,
// // // // //     ).animate(CurvedAnimation(
// // // // //       parent: _slideController,
// // // // //       curve: Curves.easeOutCubic,
// // // // //     ));

// // // // //     _fadeAnimation = Tween<double>(
// // // // //       begin: 0.0,
// // // // //       end: 1.0,
// // // // //     ).animate(CurvedAnimation(
// // // // //       parent: _fadeController,
// // // // //       curve: Curves.easeInOut,
// // // // //     ));

// // // // //     _pulseAnimation = Tween<double>(
// // // // //       begin: 1.0,
// // // // //       end: 1.05,
// // // // //     ).animate(CurvedAnimation(
// // // // //       parent: _pulseController,
// // // // //       curve: Curves.easeInOut,
// // // // //     ));

// // // // //     // Start pulse animation loop
// // // // //     _pulseController.repeat(reverse: true);
// // // // //   }

// // // // //   Future<void> _initializeData() async {
// // // // //     // Load userId from SharedPreferences
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     final userJson = prefs.getString('user');
// // // // //     if (userJson != null) {
// // // // //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
// // // // //       userId = userMap['_id'] as String?;
// // // // //     }

// // // // //     setState(() => isLoading = false);
    
// // // // //     // Start animations after loading
// // // // //     _shakeController.forward();
// // // // //     await Future.delayed(const Duration(milliseconds: 300));
// // // // //     _slideController.forward();
// // // // //     await Future.delayed(const Duration(milliseconds: 200));
// // // // //     _fadeController.forward();
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _shakeController.dispose();
// // // // //     _slideController.dispose();
// // // // //     _fadeController.dispose();
// // // // //     _pulseController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   String _getErrorTitle() {
// // // // //     if (widget.errorCode != null) {
// // // // //       switch (widget.errorCode!.toLowerCase()) {
// // // // //         case 'insufficient_funds':
// // // // //           return 'Insufficient Funds';
// // // // //         case 'card_declined':
// // // // //           return 'Card Declined';
// // // // //         case 'expired_card':
// // // // //           return 'Card Expired';
// // // // //         case 'network_error':
// // // // //           return 'Connection Issue';
// // // // //         default:
// // // // //           return 'Payment Failed';
// // // // //       }
// // // // //     }
// // // // //     return 'Payment Failed';
// // // // //   }

// // // // //   String _getErrorDescription() {
// // // // //     if (widget.errorCode != null) {
// // // // //       switch (widget.errorCode!.toLowerCase()) {
// // // // //         case 'insufficient_funds':
// // // // //           return 'Your account doesn\'t have enough funds for this transaction';
// // // // //         case 'card_declined':
// // // // //           return 'Your card was declined by the bank. Please try another payment method';
// // // // //         case 'expired_card':
// // // // //           return 'Your card has expired. Please update your payment information';
// // // // //         case 'network_error':
// // // // //           return 'We couldn\'t process your payment due to a connection issue';
// // // // //         default:
// // // // //           return 'We couldn\'t process your payment. Please try again';
// // // // //       }
// // // // //     }
// // // // //     return widget.errorMessage ?? 'We couldn\'t process your payment. Please try again';
// // // // //   }



// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     if (isLoading) {
// // // // //       return Scaffold(
// // // // //         body: Container(
// // // // //           decoration: const BoxDecoration(
// // // // //             gradient: LinearGradient(
// // // // //               begin: Alignment.topLeft,
// // // // //               end: Alignment.bottomRight,
// // // // //               colors: [
// // // // //                 Color(0xFFff6b6b),
// // // // //                 Color(0xFFee5a52),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           child: const Center(
// // // // //             child: CircularProgressIndicator(
// // // // //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // // //               strokeWidth: 3,
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     }

// // // // //     return Scaffold(
// // // // //       body: Container(
// // // // //         decoration: const BoxDecoration(
// // // // //           gradient: LinearGradient(
// // // // //             begin: Alignment.topLeft,
// // // // //             end: Alignment.bottomRight,
// // // // //             colors: [
// // // // //               Color(0xFFff6b6b),
// // // // //               Color(0xFFee5a52),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //         child: SafeArea(
// // // // //           child: Center(
// // // // //             child: SingleChildScrollView(
// // // // //               padding: const EdgeInsets.all(24.0),
// // // // //               child: Column(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 children: [
// // // // //                   // Error Icon with Animation
// // // // //                   ScaleTransition(
// // // // //                     scale: _shakeAnimation,
// // // // //                     child: Container(
// // // // //                       width: 120,
// // // // //                       height: 120,
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white,
// // // // //                         shape: BoxShape.circle,
// // // // //                         boxShadow: [
// // // // //                           BoxShadow(
// // // // //                             color: Colors.black.withOpacity(0.1),
// // // // //                             blurRadius: 20,
// // // // //                             offset: const Offset(0, 10),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                       child: const Icon(
// // // // //                         Icons.error_outline,
// // // // //                         size: 70,
// // // // //                         color: Color(0xFFdc2626),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
                  
// // // // //                   const SizedBox(height: 32),
                  
// // // // //                   // Error Message
// // // // //                   SlideTransition(
// // // // //                     position: _slideAnimation,
// // // // //                     child: Column(
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           _getErrorTitle(),
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 28,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.white,
// // // // //                             letterSpacing: 0.5,
// // // // //                           ),
// // // // //                           textAlign: TextAlign.center,
// // // // //                         ),
// // // // //                         const SizedBox(height: 12),
// // // // //                         Text(
// // // // //                           _getErrorDescription(),
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             color: Colors.white.withOpacity(0.9),
// // // // //                             fontWeight: FontWeight.w400,
// // // // //                           ),
// // // // //                           textAlign: TextAlign.center,
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
                  
// // // // //                   const SizedBox(height: 40),
                  
// // // // //                   // Error Details Card
// // // // //                   if (widget.paymentRef != null || widget.errorCode != null)
// // // // //                     FadeTransition(
// // // // //                       opacity: _fadeAnimation,
// // // // //                       child: Container(
// // // // //                         width: double.infinity,
// // // // //                         margin: const EdgeInsets.symmetric(horizontal: 8),
// // // // //                         padding: const EdgeInsets.all(24),
// // // // //                         decoration: BoxDecoration(
// // // // //                           color: Colors.white.withOpacity(0.95),
// // // // //                           borderRadius: BorderRadius.circular(20),
// // // // //                           boxShadow: [
// // // // //                             BoxShadow(
// // // // //                               color: Colors.black.withOpacity(0.1),
// // // // //                               blurRadius: 20,
// // // // //                               offset: const Offset(0, 8),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                         child: Column(
// // // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                           children: [
// // // // //                             Row(
// // // // //                               children: [
// // // // //                                 Container(
// // // // //                                   padding: const EdgeInsets.all(8),
// // // // //                                   decoration: BoxDecoration(
// // // // //                                     color: const Color(0xFFdc2626).withOpacity(0.1),
// // // // //                                     borderRadius: BorderRadius.circular(10),
// // // // //                                   ),
// // // // //                                   child: const Icon(
// // // // //                                     Icons.info_outline,
// // // // //                                     color: Color(0xFFdc2626),
// // // // //                                     size: 20,
// // // // //                                   ),
// // // // //                                 ),
// // // // //                                 const SizedBox(width: 12),
// // // // //                                 const Text(
// // // // //                                   'Transaction Details',
// // // // //                                   style: TextStyle(
// // // // //                                     fontSize: 18,
// // // // //                                     fontWeight: FontWeight.bold,
// // // // //                                     color: Color(0xFF1f2937),
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
                            
// // // // //                             const SizedBox(height: 20),
                            
// // // // //                             if (widget.paymentRef != null)
// // // // //                               _buildDetailRow('Reference', widget.paymentRef!),
                            
// // // // //                             if (widget.errorCode != null)
// // // // //                               _buildDetailRow('Error Code', widget.errorCode!.toUpperCase()),
                            
// // // // //                             _buildDetailRow('Status', 'Failed'),
// // // // //                             _buildDetailRow('Time', _getCurrentTime()),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
                  
// // // // //                   const SizedBox(height: 40),
                  
// // // // //                   // Action Buttons
// // // // //                   FadeTransition(
// // // // //                     opacity: _fadeAnimation,
// // // // //                     child: Column(
// // // // //                       children: [
// // // // //                         // Retry Button
// // // // //                         ScaleTransition(
// // // // //                           scale: _pulseAnimation,
// // // // //                           child: SizedBox(
// // // // //                             width: double.infinity,
// // // // //                             child: ElevatedButton(
// // // // //                               onPressed: _retryPayment,
// // // // //                               style: ElevatedButton.styleFrom(
// // // // //                                 backgroundColor: Colors.white,
// // // // //                                 foregroundColor: const Color(0xFFdc2626),
// // // // //                                 padding: const EdgeInsets.symmetric(
// // // // //                                   horizontal: 32,
// // // // //                                   vertical: 16,
// // // // //                                 ),
// // // // //                                 shape: RoundedRectangleBorder(
// // // // //                                   borderRadius: BorderRadius.circular(15),
// // // // //                                 ),
// // // // //                                 elevation: 8,
// // // // //                                 shadowColor: Colors.black.withOpacity(0.2),
// // // // //                               ),
// // // // //                               child: Row(
// // // // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                                 children: const [
// // // // //                                   Icon(Icons.refresh, size: 20),
// // // // //                                   SizedBox(width: 8),
// // // // //                                   Text(
// // // // //                                     'Try Again',
// // // // //                                     style: TextStyle(
// // // // //                                       fontSize: 16,
// // // // //                                       fontWeight: FontWeight.w600,
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                 ],
// // // // //                               ),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
                        
// // // // //                         const SizedBox(height: 16),
                        
// // // // //                         // Contact Support Button
// // // // //                         SizedBox(
// // // // //                           width: double.infinity,
// // // // //                           child: OutlinedButton(
// // // // //                             onPressed: _contactSupport,
// // // // //                             style: OutlinedButton.styleFrom(
// // // // //                               foregroundColor: Colors.white,
// // // // //                               side: const BorderSide(color: Colors.white, width: 2),
// // // // //                               padding: const EdgeInsets.symmetric(
// // // // //                                 horizontal: 32,
// // // // //                                 vertical: 16,
// // // // //                               ),
// // // // //                               shape: RoundedRectangleBorder(
// // // // //                                 borderRadius: BorderRadius.circular(15),
// // // // //                               ),
// // // // //                             ),
// // // // //                             child: Row(
// // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // //                               children: const [
// // // // //                                 Icon(Icons.support_agent, size: 20),
// // // // //                                 SizedBox(width: 8),
// // // // //                                 Text(
// // // // //                                   'Contact Support',
// // // // //                                   style: TextStyle(
// // // // //                                     fontSize: 16,
// // // // //                                     fontWeight: FontWeight.w500,
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
                  
// // // // //                   const SizedBox(height: 32),
                  
// // // // //                   // Reassurance Footer
// // // // //                   FadeTransition(
// // // // //                     opacity: _fadeAnimation,
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                         horizontal: 20,
// // // // //                         vertical: 16,
// // // // //                       ),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white.withOpacity(0.2),
// // // // //                         borderRadius: BorderRadius.circular(15),
// // // // //                         border: Border.all(
// // // // //                           color: Colors.white.withOpacity(0.3),
// // // // //                           width: 1,
// // // // //                         ),
// // // // //                       ),
// // // // //                       child: Row(
// // // // //                         mainAxisSize: MainAxisSize.min,
// // // // //                         children: [
// // // // //                           const Icon(
// // // // //                             Icons.security,
// // // // //                             color: Colors.white,
// // // // //                             size: 20,
// // // // //                           ),
// // // // //                           const SizedBox(width: 8),
// // // // //                           Text(
// // // // //                             'Your information is safe and secure',
// // // // //                             style: TextStyle(
// // // // //                               color: Colors.white.withOpacity(0.95),
// // // // //                               fontSize: 14,
// // // // //                               fontWeight: FontWeight.w500,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildDetailRow(String label, String value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.only(bottom: 16),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           SizedBox(
// // // // //             width: 100,
// // // // //             child: Text(
// // // // //               label,
// // // // //               style: const TextStyle(
// // // // //                 fontSize: 14,
// // // // //                 color: Color(0xFF6b7280),
// // // // //                 fontWeight: FontWeight.w500,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 16),
// // // // //           Expanded(
// // // // //             child: Text(
// // // // //               value,
// // // // //               style: const TextStyle(
// // // // //                 fontSize: 14,
// // // // //                 color: Color(0xFF1f2937),
// // // // //                 fontWeight: FontWeight.w600,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   String _getCurrentTime() {
// // // // //     final now = DateTime.now();
// // // // //     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day}/${now.month}/${now.year}';
// // // // //   }
// // // // // }

// // // // import 'dart:convert';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // class FailPaymentPage extends StatefulWidget {
// // // //   final String? paymentRef;
// // // //   final String? errorMessage;
// // // //   final String? errorCode;

// // // //   const FailPaymentPage({
// // // //     Key? key,
// // // //     this.paymentRef,
// // // //     this.errorMessage,
// // // //     this.errorCode,
// // // //   }) : super(key: key);

// // // //   @override
// // // //   State<FailPaymentPage> createState() => _FailPaymentPageState();
// // // // }

// // // // class _FailPaymentPageState extends State<FailPaymentPage>
// // // //     with TickerProviderStateMixin {
// // // //   String? userId;
// // // //   bool isLoading = true;
  
// // // //   late AnimationController _shakeController;
// // // //   late AnimationController _slideController;
// // // //   late AnimationController _fadeController;
// // // //   late AnimationController _pulseController;
  
// // // //   late Animation<double> _shakeAnimation;
// // // //   late Animation<Offset> _slideAnimation;
// // // //   late Animation<double> _fadeAnimation;
// // // //   late Animation<double> _pulseAnimation;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _initializeAnimations();
// // // //     _initializeData();
// // // //   }

// // // //   void _initializeAnimations() {
// // // //     _shakeController = AnimationController(
// // // //       duration: const Duration(milliseconds: 800),
// // // //       vsync: this,
// // // //     );
// // // //     _slideController = AnimationController(
// // // //       duration: const Duration(milliseconds: 1000),
// // // //       vsync: this,
// // // //     );
// // // //     _fadeController = AnimationController(
// // // //       duration: const Duration(milliseconds: 1200),
// // // //       vsync: this,
// // // //     );
// // // //     _pulseController = AnimationController(
// // // //       duration: const Duration(milliseconds: 2000),
// // // //       vsync: this,
// // // //     );

// // // //     _shakeAnimation = Tween<double>(
// // // //       begin: 0.0,
// // // //       end: 1.0,
// // // //     ).animate(CurvedAnimation(
// // // //       parent: _shakeController,
// // // //       curve: Curves.elasticOut,
// // // //     ));

// // // //     _slideAnimation = Tween<Offset>(
// // // //       begin: const Offset(0, 0.3),
// // // //       end: Offset.zero,
// // // //     ).animate(CurvedAnimation(
// // // //       parent: _slideController,
// // // //       curve: Curves.easeOutCubic,
// // // //     ));

// // // //     _fadeAnimation = Tween<double>(
// // // //       begin: 0.0,
// // // //       end: 1.0,
// // // //     ).animate(CurvedAnimation(
// // // //       parent: _fadeController,
// // // //       curve: Curves.easeInOut,
// // // //     ));

// // // //     _pulseAnimation = Tween<double>(
// // // //       begin: 1.0,
// // // //       end: 1.05,
// // // //     ).animate(CurvedAnimation(
// // // //       parent: _pulseController,
// // // //       curve: Curves.easeInOut,
// // // //     ));

// // // //     // Start pulse animation loop
// // // //     _pulseController.repeat(reverse: true);
// // // //   }

// // // //   Future<void> _initializeData() async {
// // // //     // Load userId from SharedPreferences
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     final userJson = prefs.getString('user');
// // // //     if (userJson != null) {
// // // //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
// // // //       userId = userMap['_id'] as String?;
// // // //     }

// // // //     setState(() => isLoading = false);
    
// // // //     // Start animations after loading
// // // //     _shakeController.forward();
// // // //     await Future.delayed(const Duration(milliseconds: 300));
// // // //     _slideController.forward();
// // // //     await Future.delayed(const Duration(milliseconds: 200));
// // // //     _fadeController.forward();
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _shakeController.dispose();
// // // //     _slideController.dispose();
// // // //     _fadeController.dispose();
// // // //     _pulseController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   String _getErrorTitle() {
// // // //     if (widget.errorCode != null) {
// // // //       switch (widget.errorCode!.toLowerCase()) {
// // // //         case 'insufficient_funds':
// // // //           return 'Insufficient Funds';
// // // //         case 'card_declined':
// // // //           return 'Card Declined';
// // // //         case 'expired_card':
// // // //           return 'Card Expired';
// // // //         case 'network_error':
// // // //           return 'Connection Issue';
// // // //         default:
// // // //           return 'Payment Failed';
// // // //       }
// // // //     }
// // // //     return 'Payment Failed';
// // // //   }

// // // //   String _getErrorDescription() {
// // // //     if (widget.errorCode != null) {
// // // //       switch (widget.errorCode!.toLowerCase()) {
// // // //         case 'insufficient_funds':
// // // //           return 'Your account doesn\'t have enough funds for this transaction';
// // // //         case 'card_declined':
// // // //           return 'Your card was declined by the bank. Please try another payment method';
// // // //         case 'expired_card':
// // // //           return 'Your card has expired. Please update your payment information';
// // // //         case 'network_error':
// // // //           return 'We couldn\'t process your payment due to a connection issue';
// // // //         default:
// // // //           return 'We couldn\'t process your payment. Please try again';
// // // //       }
// // // //     }
// // // //     return widget.errorMessage ?? 'We couldn\'t process your payment. Please try again';
// // // //   }



// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (isLoading) {
// // // //       return Scaffold(
// // // //         body: Container(
// // // //           decoration: const BoxDecoration(
// // // //             gradient: LinearGradient(
// // // //               begin: Alignment.topLeft,
// // // //               end: Alignment.bottomRight,
// // // //               colors: [
// // // //                 Color(0xFFff6b6b),
// // // //                 Color(0xFFee5a52),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           child: const Center(
// // // //             child: CircularProgressIndicator(
// // // //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // //               strokeWidth: 3,
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     return Scaffold(
// // // //       body: Container(
// // // //         decoration: const BoxDecoration(
// // // //           gradient: LinearGradient(
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //             colors: [
// // // //               Color(0xFFff6b6b),
// // // //               Color(0xFFee5a52),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         child: SafeArea(
// // // //           child: Center(
// // // //             child: SingleChildScrollView(
// // // //               padding: const EdgeInsets.all(24.0),
// // // //               child: Column(
// // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // //                 children: [
// // // //                   // Error Icon with Animation
// // // //                   ScaleTransition(
// // // //                     scale: _shakeAnimation,
// // // //                     child: Container(
// // // //                       width: 120,
// // // //                       height: 120,
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white,
// // // //                         shape: BoxShape.circle,
// // // //                         boxShadow: [
// // // //                           BoxShadow(
// // // //                             color: Colors.black.withOpacity(0.1),
// // // //                             blurRadius: 20,
// // // //                             offset: const Offset(0, 10),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       child: const Icon(
// // // //                         Icons.error_outline,
// // // //                         size: 70,
// // // //                         color: Color(0xFFdc2626),
// // // //                       ),
// // // //                     ),
// // // //                   ),
                  
// // // //                   const SizedBox(height: 32),
                  
// // // //                   // Error Message
// // // //                   SlideTransition(
// // // //                     position: _slideAnimation,
// // // //                     child: Column(
// // // //                       children: [
// // // //                         Text(
// // // //                           _getErrorTitle(),
// // // //                           style: const TextStyle(
// // // //                             fontSize: 28,
// // // //                             fontWeight: FontWeight.bold,
// // // //                             color: Colors.white,
// // // //                             letterSpacing: 0.5,
// // // //                           ),
// // // //                           textAlign: TextAlign.center,
// // // //                         ),
// // // //                         const SizedBox(height: 12),
// // // //                         Text(
// // // //                           _getErrorDescription(),
// // // //                           style: TextStyle(
// // // //                             fontSize: 16,
// // // //                             color: Colors.white.withOpacity(0.9),
// // // //                             fontWeight: FontWeight.w400,
// // // //                           ),
// // // //                           textAlign: TextAlign.center,
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
                  
// // // //                   const SizedBox(height: 40),
                  
// // // //                   // Error Details Card
// // // //                   if (widget.paymentRef != null || widget.errorCode != null)
// // // //                     FadeTransition(
// // // //                       opacity: _fadeAnimation,
// // // //                       child: Container(
// // // //                         width: double.infinity,
// // // //                         margin: const EdgeInsets.symmetric(horizontal: 8),
// // // //                         padding: const EdgeInsets.all(24),
// // // //                         decoration: BoxDecoration(
// // // //                           color: Colors.white.withOpacity(0.95),
// // // //                           borderRadius: BorderRadius.circular(20),
// // // //                           boxShadow: [
// // // //                             BoxShadow(
// // // //                               color: Colors.black.withOpacity(0.1),
// // // //                               blurRadius: 20,
// // // //                               offset: const Offset(0, 8),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                         child: Column(
// // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // //                           children: [
// // // //                             Row(
// // // //                               children: [
// // // //                                 Container(
// // // //                                   padding: const EdgeInsets.all(8),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: const Color(0xFFdc2626).withOpacity(0.1),
// // // //                                     borderRadius: BorderRadius.circular(10),
// // // //                                   ),
// // // //                                   child: const Icon(
// // // //                                     Icons.info_outline,
// // // //                                     color: Color(0xFFdc2626),
// // // //                                     size: 20,
// // // //                                   ),
// // // //                                 ),
// // // //                                 const SizedBox(width: 12),
// // // //                                 const Text(
// // // //                                   'Transaction Details',
// // // //                                   style: TextStyle(
// // // //                                     fontSize: 18,
// // // //                                     fontWeight: FontWeight.bold,
// // // //                                     color: Color(0xFF1f2937),
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
                            
// // // //                             const SizedBox(height: 20),
                            
// // // //                             if (widget.paymentRef != null)
// // // //                               _buildDetailRow('Reference', widget.paymentRef!),
                            
// // // //                             if (widget.errorCode != null)
// // // //                               _buildDetailRow('Error Code', widget.errorCode!.toUpperCase()),
                            
// // // //                             _buildDetailRow('Status', 'Failed'),
// // // //                             _buildDetailRow('Time', _getCurrentTime()),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ),
                  
// // // //                   const SizedBox(height: 40),
                  
// // // //                   // Action Buttons
// // // //                   FadeTransition(
// // // //                     opacity: _fadeAnimation,
// // // //                     child: Column(
// // // //                       children: [
// // // //                         // Retry Button
// // // //                         ScaleTransition(
// // // //                           scale: _pulseAnimation,
// // // //                           child: SizedBox(
// // // //                             width: double.infinity,
// // // //                             child: ElevatedButton(
// // // //                               onPressed: _retryPayment,
// // // //                               style: ElevatedButton.styleFrom(
// // // //                                 backgroundColor: Colors.white,
// // // //                                 foregroundColor: const Color(0xFFdc2626),
// // // //                                 padding: const EdgeInsets.symmetric(
// // // //                                   horizontal: 32,
// // // //                                   vertical: 16,
// // // //                                 ),
// // // //                                 shape: RoundedRectangleBorder(
// // // //                                   borderRadius: BorderRadius.circular(15),
// // // //                                 ),
// // // //                                 elevation: 8,
// // // //                                 shadowColor: Colors.black.withOpacity(0.2),
// // // //                               ),
// // // //                               child: Row(
// // // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // // //                                 children: const [
// // // //                                   Icon(Icons.refresh, size: 20),
// // // //                                   SizedBox(width: 8),
// // // //                                   Text(
// // // //                                     'Try Again',
// // // //                                     style: TextStyle(
// // // //                                       fontSize: 16,
// // // //                                       fontWeight: FontWeight.w600,
// // // //                                     ),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ),
                        
// // // //                         const SizedBox(height: 16),
                        
// // // //                         // Contact Support Button
// // // //                         SizedBox(
// // // //                           width: double.infinity,
// // // //                           child: OutlinedButton(
// // // //                             onPressed: _contactSupport,
// // // //                             style: OutlinedButton.styleFrom(
// // // //                               foregroundColor: Colors.white,
// // // //                               side: const BorderSide(color: Colors.white, width: 2),
// // // //                               padding: const EdgeInsets.symmetric(
// // // //                                 horizontal: 32,
// // // //                                 vertical: 16,
// // // //                               ),
// // // //                               shape: RoundedRectangleBorder(
// // // //                                 borderRadius: BorderRadius.circular(15),
// // // //                               ),
// // // //                             ),
// // // //                             child: Row(
// // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // //                               children: const [
// // // //                                 Icon(Icons.support_agent, size: 20),
// // // //                                 SizedBox(width: 8),
// // // //                                 Text(
// // // //                                   'Contact Support',
// // // //                                   style: TextStyle(
// // // //                                     fontSize: 16,
// // // //                                     fontWeight: FontWeight.w500,
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
                  
// // // //                   const SizedBox(height: 32),
                  
// // // //                   // Reassurance Footer
// // // //                   FadeTransition(
// // // //                     opacity: _fadeAnimation,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                         horizontal: 20,
// // // //                         vertical: 16,
// // // //                       ),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white.withOpacity(0.2),
// // // //                         borderRadius: BorderRadius.circular(15),
// // // //                         border: Border.all(
// // // //                           color: Colors.white.withOpacity(0.3),
// // // //                           width: 1,
// // // //                         ),
// // // //                       ),
// // // //                       child: Row(
// // // //                         mainAxisSize: MainAxisSize.min,
// // // //                         children: [
// // // //                           const Icon(
// // // //                             Icons.security,
// // // //                             color: Colors.white,
// // // //                             size: 20,
// // // //                           ),
// // // //                           const SizedBox(width: 8),
// // // //                           Text(
// // // //                             'Your information is safe and secure',
// // // //                             style: TextStyle(
// // // //                               color: Colors.white.withOpacity(0.95),
// // // //                               fontSize: 14,
// // // //                               fontWeight: FontWeight.w500,
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildDetailRow(String label, String value) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(bottom: 16),
// // // //       child: Row(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           SizedBox(
// // // //             width: 100,
// // // //             child: Text(
// // // //               label,
// // // //               style: const TextStyle(
// // // //                 fontSize: 14,
// // // //                 color: Color(0xFF6b7280),
// // // //                 fontWeight: FontWeight.w500,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //           Expanded(
// // // //             child: Text(
// // // //               value,
// // // //               style: const TextStyle(
// // // //                 fontSize: 14,
// // // //                 color: Color(0xFF1f2937),
// // // //                 fontWeight: FontWeight.w600,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   String _getCurrentTime() {
// // // //     final now = DateTime.now();
// // // //     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day}/${now.month}/${now.year}';
// // // //   }
// // // // }

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class FailPaymentPage extends StatefulWidget {
// // //   final String? paymentRef;
// // //   final String? errorMessage;
// // //   final String? errorCode;

// // //   const FailPaymentPage({
// // //     Key? key,
// // //     this.paymentRef,
// // //     this.errorMessage,
// // //     this.errorCode,
// // //   }) : super(key: key);

// // //   @override
// // //   State<FailPaymentPage> createState() => _FailPaymentPageState();
// // // }

// // // class _FailPaymentPageState extends State<FailPaymentPage>
// // //     with TickerProviderStateMixin {
// // //   String? userId;
// // //   bool isLoading = true;
  
// // //   late AnimationController _shakeController;
// // //   late AnimationController _slideController;
// // //   late AnimationController _fadeController;
  
// // //   late Animation<double> _shakeAnimation;
// // //   late Animation<Offset> _slideAnimation;
// // //   late Animation<double> _fadeAnimation;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeAnimations();
// // //     _initializeData();
// // //   }

// // //   void _initializeAnimations() {
// // //     _shakeController = AnimationController(
// // //       duration: const Duration(milliseconds: 800),
// // //       vsync: this,
// // //     );
// // //     _slideController = AnimationController(
// // //       duration: const Duration(milliseconds: 1000),
// // //       vsync: this,
// // //     );
// // //     _fadeController = AnimationController(
// // //       duration: const Duration(milliseconds: 1200),
// // //       vsync: this,
// // //     );

// // //     _shakeAnimation = Tween<double>(
// // //       begin: 0.0,
// // //       end: 1.0,
// // //     ).animate(CurvedAnimation(
// // //       parent: _shakeController,
// // //       curve: Curves.elasticOut,
// // //     ));

// // //     _slideAnimation = Tween<Offset>(
// // //       begin: const Offset(0, 0.3),
// // //       end: Offset.zero,
// // //     ).animate(CurvedAnimation(
// // //       parent: _slideController,
// // //       curve: Curves.easeOutCubic,
// // //     ));

// // //     _fadeAnimation = Tween<double>(
// // //       begin: 0.0,
// // //       end: 1.0,
// // //     ).animate(CurvedAnimation(
// // //       parent: _fadeController,
// // //       curve: Curves.easeInOut,
// // //     ));
// // //   }

// // //   Future<void> _initializeData() async {
// // //     // Load userId from SharedPreferences
// // //     final prefs = await SharedPreferences.getInstance();
// // //     final userJson = prefs.getString('user');
// // //     if (userJson != null) {
// // //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
// // //       userId = userMap['_id'] as String?;
// // //     }

// // //     setState(() => isLoading = false);
    
// // //     // Start animations after loading
// // //     _shakeController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 300));
// // //     _slideController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _fadeController.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _shakeController.dispose();
// // //     _slideController.dispose();
// // //     _fadeController.dispose();
// // //     super.dispose();
// // //   }

// // //   String _getErrorTitle() {
// // //     if (widget.errorCode != null) {
// // //       switch (widget.errorCode!.toLowerCase()) {
// // //         case 'insufficient_funds':
// // //           return 'Insufficient Funds';
// // //         case 'card_declined':
// // //           return 'Card Declined';
// // //         case 'expired_card':
// // //           return 'Card Expired';
// // //         case 'network_error':
// // //           return 'Connection Issue';
// // //         default:
// // //           return 'Payment Failed';
// // //       }
// // //     }
// // //     return 'Payment Failed';
// // //   }

// // //   String _getErrorDescription() {
// // //     if (widget.errorCode != null) {
// // //       switch (widget.errorCode!.toLowerCase()) {
// // //         case 'insufficient_funds':
// // //           return 'Your account doesn\'t have enough funds for this transaction';
// // //         case 'card_declined':
// // //           return 'Your card was declined by the bank. Please try another payment method';
// // //         case 'expired_card':
// // //           return 'Your card has expired. Please update your payment information';
// // //         case 'network_error':
// // //           return 'We couldn\'t process your payment due to a connection issue';
// // //         default:
// // //           return 'We couldn\'t process your payment. Please try again';
// // //       }
// // //     }
// // //     return widget.errorMessage ?? 'We couldn\'t process your payment. Please try again';
// // //   }



// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (isLoading) {
// // //       return Scaffold(
// // //         body: Container(
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //               colors: [
// // //                 Color(0xFFff6b6b),
// // //                 Color(0xFFee5a52),
// // //               ],
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
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: [
// // //               Color(0xFFff6b6b),
// // //               Color(0xFFee5a52),
// // //             ],
// // //           ),
// // //         ),
// // //         child: SafeArea(
// // //           child: Center(
// // //             child: SingleChildScrollView(
// // //               padding: const EdgeInsets.all(24.0),
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   // Error Icon with Animation
// // //                   ScaleTransition(
// // //                     scale: _shakeAnimation,
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
// // //                         Icons.error_outline,
// // //                         size: 70,
// // //                         color: Color(0xFFdc2626),
// // //                       ),
// // //                     ),
// // //                   ),
                  
// // //                   const SizedBox(height: 32),
                  
// // //                   // Error Message
// // //                   SlideTransition(
// // //                     position: _slideAnimation,
// // //                     child: Column(
// // //                       children: [
// // //                         Text(
// // //                           _getErrorTitle(),
// // //                           style: const TextStyle(
// // //                             fontSize: 28,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.white,
// // //                             letterSpacing: 0.5,
// // //                           ),
// // //                           textAlign: TextAlign.center,
// // //                         ),
// // //                         const SizedBox(height: 12),
// // //                         Text(
// // //                           _getErrorDescription(),
// // //                           style: TextStyle(
// // //                             fontSize: 16,
// // //                             color: Colors.white.withOpacity(0.9),
// // //                             fontWeight: FontWeight.w400,
// // //                           ),
// // //                           textAlign: TextAlign.center,
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
                  
// // //                   const SizedBox(height: 40),
                  
// // //                   // Error Details Card
// // //                   if (widget.paymentRef != null || widget.errorCode != null)
// // //                     FadeTransition(
// // //                       opacity: _fadeAnimation,
// // //                       child: Container(
// // //                         width: double.infinity,
// // //                         margin: const EdgeInsets.symmetric(horizontal: 8),
// // //                         padding: const EdgeInsets.all(24),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.white.withOpacity(0.95),
// // //                           borderRadius: BorderRadius.circular(20),
// // //                           boxShadow: [
// // //                             BoxShadow(
// // //                               color: Colors.black.withOpacity(0.1),
// // //                               blurRadius: 20,
// // //                               offset: const Offset(0, 8),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             Row(
// // //                               children: [
// // //                                 Container(
// // //                                   padding: const EdgeInsets.all(8),
// // //                                   decoration: BoxDecoration(
// // //                                     color: const Color(0xFFdc2626).withOpacity(0.1),
// // //                                     borderRadius: BorderRadius.circular(10),
// // //                                   ),
// // //                                   child: const Icon(
// // //                                     Icons.info_outline,
// // //                                     color: Color(0xFFdc2626),
// // //                                     size: 20,
// // //                                   ),
// // //                                 ),
// // //                                 const SizedBox(width: 12),
// // //                                 const Text(
// // //                                   'Transaction Details',
// // //                                   style: TextStyle(
// // //                                     fontSize: 18,
// // //                                     fontWeight: FontWeight.bold,
// // //                                     color: Color(0xFF1f2937),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
                            
// // //                             const SizedBox(height: 20),
                            
// // //                             if (widget.paymentRef != null)
// // //                               _buildDetailRow('Reference', widget.paymentRef!),
                            
// // //                             if (widget.errorCode != null)
// // //                               _buildDetailRow('Error Code', widget.errorCode!.toUpperCase()),
                            
// // //                             _buildDetailRow('Status', 'Failed'),
// // //                             _buildDetailRow('Time', _getCurrentTime()),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
                  
// // //                   const SizedBox(height: 40),
                  
// // //                   // Action Buttons
// // //                   FadeTransition(
// // //                     opacity: _fadeAnimation,
// // //                     child: Column(
// // //                       children: [
// // //                         // Retry Button
// // //                         ScaleTransition(
// // //                           scale: _pulseAnimation,
// // //                           child: SizedBox(
// // //                             width: double.infinity,
// // //                             child: ElevatedButton(
// // //                               onPressed: _retryPayment,
// // //                               style: ElevatedButton.styleFrom(
// // //                                 backgroundColor: Colors.white,
// // //                                 foregroundColor: const Color(0xFFdc2626),
// // //                                 padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 32,
// // //                                   vertical: 16,
// // //                                 ),
// // //                                 shape: RoundedRectangleBorder(
// // //                                   borderRadius: BorderRadius.circular(15),
// // //                                 ),
// // //                                 elevation: 8,
// // //                                 shadowColor: Colors.black.withOpacity(0.2),
// // //                               ),
// // //                               child: Row(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 children: const [
// // //                                   Icon(Icons.refresh, size: 20),
// // //                                   SizedBox(width: 8),
// // //                                   Text(
// // //                                     'Try Again',
// // //                                     style: TextStyle(
// // //                                       fontSize: 16,
// // //                                       fontWeight: FontWeight.w600,
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),
                        
// // //                         const SizedBox(height: 16),
                        
// // //                         // Contact Support Button
// // //                         SizedBox(
// // //                           width: double.infinity,
// // //                           child: OutlinedButton(
// // //                             onPressed: _contactSupport,
// // //                             style: OutlinedButton.styleFrom(
// // //                               foregroundColor: Colors.white,
// // //                               side: const BorderSide(color: Colors.white, width: 2),
// // //                               padding: const EdgeInsets.symmetric(
// // //                                 horizontal: 32,
// // //                                 vertical: 16,
// // //                               ),
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(15),
// // //                               ),
// // //                             ),
// // //                             child: Row(
// // //                               mainAxisAlignment: MainAxisAlignment.center,
// // //                               children: const [
// // //                                 Icon(Icons.support_agent, size: 20),
// // //                                 SizedBox(width: 8),
// // //                                 Text(
// // //                                   'Contact Support',
// // //                                   style: TextStyle(
// // //                                     fontSize: 16,
// // //                                     fontWeight: FontWeight.w500,
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
                  
// // //                   const SizedBox(height: 32),
                  
// // //                   // Reassurance Footer
// // //                   FadeTransition(
// // //                     opacity: _fadeAnimation,
// // //                     child: Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                         horizontal: 20,
// // //                         vertical: 16,
// // //                       ),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white.withOpacity(0.2),
// // //                         borderRadius: BorderRadius.circular(15),
// // //                         border: Border.all(
// // //                           color: Colors.white.withOpacity(0.3),
// // //                           width: 1,
// // //                         ),
// // //                       ),
// // //                       child: Row(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: [
// // //                           const Icon(
// // //                             Icons.security,
// // //                             color: Colors.white,
// // //                             size: 20,
// // //                           ),
// // //                           const SizedBox(width: 8),
// // //                           Text(
// // //                             'Your information is safe and secure',
// // //                             style: TextStyle(
// // //                               color: Colors.white.withOpacity(0.95),
// // //                               fontSize: 14,
// // //                               fontWeight: FontWeight.w500,
// // //                             ),
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
// // //       padding: const EdgeInsets.only(bottom: 16),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           SizedBox(
// // //             width: 100,
// // //             child: Text(
// // //               label,
// // //               style: const TextStyle(
// // //                 fontSize: 14,
// // //                 color: Color(0xFF6b7280),
// // //                 fontWeight: FontWeight.w500,
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(width: 16),
// // //           Expanded(
// // //             child: Text(
// // //               value,
// // //               style: const TextStyle(
// // //                 fontSize: 14,
// // //                 color: Color(0xFF1f2937),
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   String _getCurrentTime() {
// // //     final now = DateTime.now();
// // //     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day}/${now.month}/${now.year}';
// // //   }
// // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class FailPaymentPage extends StatefulWidget {
// //   final String? paymentRef;
// //   final String? errorMessage;
// //   final String? errorCode;

// //   const FailPaymentPage({
// //     Key? key,
// //     this.paymentRef,
// //     this.errorMessage,
// //     this.errorCode,
// //   }) : super(key: key);

// //   @override
// //   State<FailPaymentPage> createState() => _FailPaymentPageState();
// // }

// // class _FailPaymentPageState extends State<FailPaymentPage>
// //     with TickerProviderStateMixin {
// //   String? userId;
// //   bool isLoading = true;

// //   late AnimationController _shakeController;
// //   late AnimationController _slideController;
// //   late AnimationController _fadeController;

// //   late Animation<double> _shakeAnimation;
// //   late Animation<Offset> _slideAnimation;
// //   late Animation<double> _fadeAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeAnimations();
// //     _initializeData();
// //   }

// //   void _initializeAnimations() {
// //     _shakeController = AnimationController(
// //       duration: const Duration(milliseconds: 800),
// //       vsync: this,
// //     );
// //     _slideController = AnimationController(
// //       duration: const Duration(milliseconds: 1000),
// //       vsync: this,
// //     );
// //     _fadeController = AnimationController(
// //       duration: const Duration(milliseconds: 1200),
// //       vsync: this,
// //     );

// //     _shakeAnimation = Tween<double>(
// //       begin: 0.0,
// //       end: 1.0,
// //     ).animate(CurvedAnimation(
// //       parent: _shakeController,
// //       curve: Curves.elasticOut,
// //     ));

// //     _slideAnimation = Tween<Offset>(
// //       begin: const Offset(0, 0.3),
// //       end: Offset.zero,
// //     ).animate(CurvedAnimation(
// //       parent: _slideController,
// //       curve: Curves.easeOutCubic,
// //     ));

// //     _fadeAnimation = Tween<double>(
// //       begin: 0.0,
// //       end: 1.0,
// //     ).animate(CurvedAnimation(
// //       parent: _fadeController,
// //       curve: Curves.easeInOut,
// //     ));
// //   }

// //   Future<void> _initializeData() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final userJson = prefs.getString('user');
// //     if (userJson != null) {
// //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
// //       userId = userMap['_id'] as String?;
// //     }

// //     setState(() => isLoading = false);

// //     // play animations in sequence
// //     _shakeController.forward();
// //     await Future.delayed(const Duration(milliseconds: 300));
// //     _slideController.forward();
// //     await Future.delayed(const Duration(milliseconds: 200));
// //     _fadeController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _shakeController.dispose();
// //     _slideController.dispose();
// //     _fadeController.dispose();
// //     super.dispose();
// //   }

// //   String _getErrorTitle() {
// //     if (widget.errorCode != null) {
// //       switch (widget.errorCode!.toLowerCase()) {
// //         case 'insufficient_funds':
// //           return 'Insufficient Funds';
// //         case 'card_declined':
// //           return 'Card Declined';
// //         case 'expired_card':
// //           return 'Card Expired';
// //         case 'network_error':
// //           return 'Connection Issue';
// //         default:
// //           return 'Payment Failed';
// //       }
// //     }
// //     return 'Payment Failed';
// //   }

// //   String _getErrorDescription() {
// //     if (widget.errorCode != null) {
// //       switch (widget.errorCode!.toLowerCase()) {
// //         case 'insufficient_funds':
// //           return 'Your account doesn\'t have enough funds for this transaction';
// //         case 'card_declined':
// //           return 'Your card was declined by the bank. Please try another payment method';
// //         case 'expired_card':
// //           return 'Your card has expired. Please update your payment information';
// //         case 'network_error':
// //           return 'We couldn\'t process your payment due to a connection issue';
// //         default:
// //           return 'We couldn\'t process your payment. Please try again';
// //       }
// //     }
// //     return widget.errorMessage ??
// //         'We couldn\'t process your payment. Please try again';
// //   }

// //   // ─────────────────── Actions ───────────────────

// //   void _retryPayment() {
// //     // pop back to wherever you kick off payments
// //     Navigator.pop(context);
// //   }

// //   Future<void> _contactSupport() async {
// //     final subject = Uri.encodeComponent('Payment Failure Help');
// //     final body = Uri.encodeComponent(
// //         'Hi support,\n\nI had a payment failure. Ref: ${widget.paymentRef ?? 'N/A'}\n\nThanks.');
// //     final uri = Uri.parse('mailto:support@example.com?subject=$subject&body=$body');
// //     if (await canLaunch(uri.toString())) {
// //       await launch(uri.toString());
// //     }
// //   }

// //   String _getCurrentTime() {
// //     final now = DateTime.now();
// //     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} '
// //         '${now.day}/${now.month}/${now.year}';
// //   }

// //   // ─────────────────── Scaffold ───────────────────

// //   @override
// //   Widget build(BuildContext context) {
// //     if (isLoading) {
// //       return Scaffold(
// //         body: Container(
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //               colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
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
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Center(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(24.0),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   // ❗️ Error Icon
// //                   ScaleTransition(
// //                     scale: _shakeAnimation,
// //                     child: Container(
// //                       width: 120,
// //                       height: 120,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.1),
// //                             blurRadius: 20,
// //                             offset: const Offset(0, 10),
// //                           ),
// //                         ],
// //                       ),
// //                       child: const Icon(
// //                         Icons.error_outline,
// //                         size: 70,
// //                         color: Color(0xFFdc2626),
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 32),

// //                   // ❗️ Title & Description
// //                   SlideTransition(
// //                     position: _slideAnimation,
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           _getErrorTitle(),
// //                           style: const TextStyle(
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                         const SizedBox(height: 12),
// //                         Text(
// //                           _getErrorDescription(),
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             color: Colors.white.withOpacity(0.9),
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   const SizedBox(height: 40),

// //                   // ❗️ Details Card
// //                   FadeTransition(
// //                     opacity: _fadeAnimation,
// //                     child: Container(
// //                       width: double.infinity,
// //                       padding: const EdgeInsets.all(24),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.95),
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           if (widget.paymentRef != null ||
// //                               widget.errorCode != null)
// //                             Row(
// //                               children: [
// //                                 Container(
// //                                   padding: const EdgeInsets.all(8),
// //                                   decoration: BoxDecoration(
// //                                     color:
// //                                         const Color(0xFFdc2626).withOpacity(0.1),
// //                                     borderRadius: BorderRadius.circular(10),
// //                                   ),
// //                                   child: const Icon(
// //                                     Icons.info_outline,
// //                                     color: Color(0xFFdc2626),
// //                                   ),
// //                                 ),
// //                                 const SizedBox(width: 12),
// //                                 const Text(
// //                                   'Transaction Details',
// //                                   style: TextStyle(
// //                                     fontSize: 18,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Color(0xFF1f2937),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           const SizedBox(height: 20),
// //                           if (widget.paymentRef != null)
// //                             _buildDetailRow('Reference', widget.paymentRef!),
// //                           if (widget.errorCode != null)
// //                             _buildDetailRow(
// //                                 'Error Code', widget.errorCode!.toUpperCase()),
// //                           _buildDetailRow('Status', 'Failed'),
// //                           _buildDetailRow('Time', _getCurrentTime()),
// //                         ],
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 40),

// //                   // ❗️ Action Buttons
// //                   FadeTransition(
// //                     opacity: _fadeAnimation,
// //                     child: Column(
// //                       children: [
// //                         // Retry
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: _retryPayment,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.white,
// //                               foregroundColor: const Color(0xFFdc2626),
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 32, vertical: 16),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(15),
// //                               ),
// //                             ),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: const [
// //                                 Icon(Icons.refresh),
// //                                 SizedBox(width: 8),
// //                                 Text('Try Again'),
// //                               ],
// //                             ),
// //                           ),
// //                         ),

// //                         const SizedBox(height: 16),

// //                         // Contact Support
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: OutlinedButton(
// //                             onPressed: _contactSupport,
// //                             style: OutlinedButton.styleFrom(
// //                               foregroundColor: Colors.white,
// //                               side:
// //                                   const BorderSide(color: Colors.white, width: 2),
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 32, vertical: 16),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(15),
// //                               ),
// //                             ),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: const [
// //                                 Icon(Icons.support_agent),
// //                                 SizedBox(width: 8),
// //                                 Text('Contact Support'),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   const SizedBox(height: 32),

// //                   // ❗️ Footer
// //                   FadeTransition(
// //                     opacity: _fadeAnimation,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 16),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.2),
// //                         borderRadius: BorderRadius.circular(15),
// //                       ),
// //                       child: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           const Icon(Icons.security, color: Colors.white),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             'Your information is safe and secure',
// //                             style: TextStyle(
// //                               color: Colors.white.withOpacity(0.95),
// //                             ),
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

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 16),
// //       child: Row(
// //         children: [
// //           SizedBox(
// //             width: 100,
// //             child: Text(label,
// //                 style: const TextStyle(
// //                     fontSize: 14,
// //                     color: Color(0xFF6b7280),
// //                     fontWeight: FontWeight.w500)),
// //           ),
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: Text(value,
// //                 style: const TextStyle(
// //                     fontSize: 14, fontWeight: FontWeight.w600)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FailPaymentPage extends StatefulWidget {
//   final String? paymentRef;
//   final String? errorMessage;
//   final String? errorCode;

//   const FailPaymentPage({
//     Key? key,
//     this.paymentRef,
//     this.errorMessage,
//     this.errorCode,
//   }) : super(key: key);

//   @override
//   State<FailPaymentPage> createState() => _FailPaymentPageState();
// }

// class _FailPaymentPageState extends State<FailPaymentPage>
//     with TickerProviderStateMixin {
//   String? userId;
//   bool isLoading = true;

//   late AnimationController _shakeController;
//   late AnimationController _slideController;
//   late AnimationController _fadeController;

//   late Animation<double> _shakeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _initializeData();
//   }

//   void _initializeAnimations() {
//     _shakeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
//     );
//     _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );
//   }

//   Future<void> _initializeData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString('user');
//     if (userJson != null) {
//       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
//       userId = userMap['_id'] as String?;
//     }

//     setState(() => isLoading = false);

//     _shakeController.forward();
//     await Future.delayed(const Duration(milliseconds: 300));
//     _slideController.forward();
//     await Future.delayed(const Duration(milliseconds: 200));
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _shakeController.dispose();
//     _slideController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   String _getErrorTitle() {
//     if (widget.errorCode != null) {
//       switch (widget.errorCode!.toLowerCase()) {
//         case 'insufficient_funds':
//           return 'Insufficient Funds';
//         case 'card_declined':
//           return 'Card Declined';
//         case 'expired_card':
//           return 'Card Expired';
//         case 'network_error':
//           return 'Connection Issue';
//         default:
//           return 'Payment Failed';
//       }
//     }
//     return 'Payment Failed';
//   }

//   String _getErrorDescription() {
//     if (widget.errorCode != null) {
//       switch (widget.errorCode!.toLowerCase()) {
//         case 'insufficient_funds':
//           return 'Your account doesn\'t have enough funds for this transaction';
//         case 'card_declined':
//           return 'Your card was declined. Please try another payment method';
//         case 'expired_card':
//           return 'Your card has expired. Please update your payment information';
//         case 'network_error':
//           return 'We couldn\'t process your payment due to a connection issue';
//         default:
//           return 'We couldn\'t process your payment. Please try again';
//       }
//     }
//     return widget.errorMessage ??
//         'We couldn\'t process your payment. Please try again';
//   }

//   String _getCurrentTime() {
//     final now = DateTime.now();
//     return '${now.hour.toString().padLeft(2, '0')}:'
//            '${now.minute.toString().padLeft(2, '0')} '
//            '${now.day}/${now.month}/${now.year}';
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
//               colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
//             ),
//           ),
//           child: const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
//             colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ScaleTransition(
//                     scale: _shakeAnimation,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         )],
//                       ),
//                       child: const Icon(
//                         Icons.error_outline,
//                         size: 70,
//                         color: Color(0xFFdc2626),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: Column(
//                       children: [
//                         Text(
//                           _getErrorTitle(),
//                           style: const TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           _getErrorDescription(),
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.95),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (widget.paymentRef != null || widget.errorCode != null)
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFFdc2626).withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: const Icon(
//                                     Icons.info_outline,
//                                     color: Color(0xFFdc2626),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Text(
//                                   'Transaction Details',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1f2937),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           const SizedBox(height: 20),
//                           if (widget.paymentRef != null)
//                             _buildDetailRow('Reference', widget.paymentRef!),
//                           if (widget.errorCode != null)
//                             _buildDetailRow(
//                               'Error Code',
//                               widget.errorCode!.toUpperCase(),
//                             ),
//                           _buildDetailRow('Status', 'Failed'),
//                           _buildDetailRow('Time', _getCurrentTime()),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.security, color: Colors.white),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Your information is safe and secure',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.95),
//                               fontWeight: FontWeight.w500,
//                             ),
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

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF6b7280),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FailPaymentPage extends StatefulWidget {
  final String? paymentRef;
  final String? errorMessage;
  final String? errorCode;

  const FailPaymentPage({
    Key? key,
    this.paymentRef,
    this.errorMessage,
    this.errorCode,
  }) : super(key: key);

  @override
  State<FailPaymentPage> createState() => _FailPaymentPageState();
}

class _FailPaymentPageState extends State<FailPaymentPage>
    with TickerProviderStateMixin {
  String? userId;
  bool isLoading = true;

  late AnimationController _shakeController;
  late AnimationController _slideController;
  late AnimationController _fadeController;

  late Animation<double> _shakeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeData();
  }

  void _initializeAnimations() {
    _shakeController = AnimationController(
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

    _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      userId = userMap['_id'] as String?;
    }

    setState(() => isLoading = false);

    _shakeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  String _getErrorTitle() {
    if (widget.errorCode != null) {
      switch (widget.errorCode!.toLowerCase()) {
        case 'insufficient_funds':
          return 'Insufficient Funds';
        case 'card_declined':
          return 'Card Declined';
        case 'expired_card':
          return 'Card Expired';
        case 'network_error':
          return 'Connection Issue';
        default:
          return 'Payment Failed';
      }
    }
    return 'Payment Failed';
  }

  String _getErrorDescription() {
    if (widget.errorCode != null) {
      switch (widget.errorCode!.toLowerCase()) {
        case 'insufficient_funds':
          return 'Your account doesn\'t have enough funds for this transaction';
        case 'card_declined':
          return 'Your card was declined. Please try another payment method';
        case 'expired_card':
          return 'Your card has expired. Please update your payment information';
        case 'network_error':
          return 'We couldn\'t process your payment due to a connection issue';
        default:
          return 'We couldn\'t process your payment. Please try again';
      }
    }
    return widget.errorMessage ??
        'We couldn\'t process your payment. Please try again';
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
           '${now.minute.toString().padLeft(2, '0')} '
           '${now.day}/${now.month}/${now.year}';
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
              colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
            colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _shakeAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )],
                      ),
                      child: const Icon(
                        Icons.error_outline,
                        size: 70,
                        color: Color(0xFFdc2626),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        Text(
                          _getErrorTitle(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getErrorDescription(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.paymentRef != null || widget.errorCode != null)
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFdc2626).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Color(0xFFdc2626),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Transaction Details',
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
                            _buildDetailRow('Reference', widget.paymentRef!),
                          if (widget.errorCode != null)
                            _buildDetailRow(
                              'Error Code',
                              widget.errorCode!.toUpperCase(),
                            ),
                          _buildDetailRow('Status', 'Failed'),
                          _buildDetailRow('Time', _getCurrentTime()),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.security, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Your information is safe and secure',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.95),
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
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6b7280),
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
