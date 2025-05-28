// // // // // // lib/screens/table_payment_success_page.dart

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:intl/intl.dart';

// // // // // class TablePaymentSuccessPage extends StatefulWidget {
// // // // //   /// These come from your successUrl:
// // // // //   ///   #/payment?start_time=…&end_time=…&numTable=…&date=…
// // // // //   final String? startTime;
// // // // //   final String? endTime;
// // // // //   final String? numTable;
// // // // //   final String? date;

// // // // //   const TablePaymentSuccessPage({
// // // // //     Key? key,
// // // // //     this.startTime,
// // // // //     this.endTime,
// // // // //     this.numTable,
// // // // //     this.date,
// // // // //   }) : super(key: key);

// // // // //   @override
// // // // //   _TablePaymentSuccessPageState createState() =>
// // // // //       _TablePaymentSuccessPageState();
// // // // // }

// // // // // class _TablePaymentSuccessPageState extends State<TablePaymentSuccessPage>
// // // // //     with TickerProviderStateMixin {
// // // // //   bool _loading = true;

// // // // //   late final AnimationController _scaleCtrl;
// // // // //   late final AnimationController _slideCtrl;
// // // // //   late final AnimationController _fadeCtrl;

// // // // //   late final Animation<double> _scaleAnim;
// // // // //   late final Animation<Offset> _slideAnim;
// // // // //   late final Animation<double> _fadeAnim;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initAnimations();
// // // // //     // simulate a brief “loading” before showing the screen
// // // // //     Future.delayed(const Duration(milliseconds: 300), () {
// // // // //       setState(() => _loading = false);
// // // // //       _scaleCtrl.forward();
// // // // //       Future.delayed(const Duration(milliseconds: 200), () => _slideCtrl.forward());
// // // // //       Future.delayed(const Duration(milliseconds: 400), () => _fadeCtrl.forward());
// // // // //     });
// // // // //   }

// // // // //   void _initAnimations() {
// // // // //     _scaleCtrl = AnimationController(
// // // // //       vsync: this,
// // // // //       duration: const Duration(milliseconds: 800),
// // // // //     );
// // // // //     _slideCtrl = AnimationController(
// // // // //       vsync: this,
// // // // //       duration: const Duration(milliseconds: 1000),
// // // // //     );
// // // // //     _fadeCtrl = AnimationController(
// // // // //       vsync: this,
// // // // //       duration: const Duration(milliseconds: 1200),
// // // // //     );

// // // // //     _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// // // // //       CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut),
// // // // //     );
// // // // //     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
// // // // //         .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
// // // // //     _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// // // // //       CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _scaleCtrl.dispose();
// // // // //     _slideCtrl.dispose();
// // // // //     _fadeCtrl.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   String _formatTime(String? isoTime) {
// // // // //     if (isoTime == null) return '--:--';
// // // // //     try {
// // // // //       final dt = DateTime.parse(isoTime);
// // // // //       return DateFormat.Hm().format(dt);
// // // // //     } catch (_) {
// // // // //       return isoTime;
// // // // //     }
// // // // //   }

// // // // //   String _formatDate(String? isoDate) {
// // // // //     if (isoDate == null) return '--/--/----';
// // // // //     try {
// // // // //       final dt = DateTime.parse(isoDate);
// // // // //       return DateFormat.yMMMd().format(dt);
// // // // //     } catch (_) {
// // // // //       return isoDate;
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     if (_loading) {
// // // // //       return const Scaffold(
// // // // //         body: Center(child: CircularProgressIndicator()),
// // // // //       );
// // // // //     }

// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       body: Container(
// // // // //         decoration: const BoxDecoration(
// // // // //           gradient: LinearGradient(
// // // // //             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// // // // //             begin: Alignment.topLeft,
// // // // //             end: Alignment.bottomRight,
// // // // //           ),
// // // // //         ),
// // // // //         child: SafeArea(
// // // // //           child: Center(
// // // // //             child: SingleChildScrollView(
// // // // //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   ScaleTransition(
// // // // //                     scale: _scaleAnim,
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.all(20),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white,
// // // // //                         shape: BoxShape.circle,
// // // // //                         boxShadow: [
// // // // //                           BoxShadow(
// // // // //                             color: Colors.black.withOpacity(0.2),
// // // // //                             blurRadius: 12,
// // // // //                             offset: const Offset(0, 6),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                       child: const Icon(
// // // // //                         Icons.check_circle_outline,
// // // // //                         size: 80,
// // // // //                         color: Color(0xFF10b981),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 28),
// // // // //                   SlideTransition(
// // // // //                     position: _slideAnim,
// // // // //                     child: const Text(
// // // // //                       'Payment Successful',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 26,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         color: Colors.white,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 12),
// // // // //                   SlideTransition(
// // // // //                     position: _slideAnim,
// // // // //                     child: const Text(
// // // // //                       'Your table has been reserved.',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.white70,
// // // // //                       ),
// // // // //                       textAlign: TextAlign.center,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 40),
// // // // //                   FadeTransition(
// // // // //                     opacity: _fadeAnim,
// // // // //                     child: Container(
// // // // //                       width: double.infinity,
// // // // //                       padding: const EdgeInsets.all(24),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white.withOpacity(0.95),
// // // // //                         borderRadius: BorderRadius.circular(20),
// // // // //                       ),
// // // // //                       child: Column(
// // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                         children: [
// // // // //                           const Text(
// // // // //                             'Reservation Details',
// // // // //                             style: TextStyle(
// // // // //                               fontSize: 18,
// // // // //                               fontWeight: FontWeight.bold,
// // // // //                               color: Color(0xFF1f2937),
// // // // //                             ),
// // // // //                           ),
// // // // //                           const SizedBox(height: 20),
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               const Icon(Icons.calendar_today, size: 20),
// // // // //                               const SizedBox(width: 10),
// // // // //                               Text(_formatDate(widget.date)),
// // // // //                             ],
// // // // //                           ),
// // // // //                           const SizedBox(height: 12),
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               const Icon(Icons.access_time, size: 20),
// // // // //                               const SizedBox(width: 10),
// // // // //                               Text(
// // // // //                                 '${_formatTime(widget.startTime)}  –  ${_formatTime(widget.endTime)}',
// // // // //                               ),
// // // // //                             ],
// // // // //                           ),
// // // // //                           const SizedBox(height: 12),
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               const Icon(Icons.table_bar, size: 20),
// // // // //                               const SizedBox(width: 10),
// // // // //                               Text('Table #${widget.numTable ?? '-'}'),
// // // // //                             ],
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 32),
// // // // //                   FadeTransition(
// // // // //                     opacity: _fadeAnim,
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white24,
// // // // //                         borderRadius: BorderRadius.circular(15),
// // // // //                         border: Border.all(color: Colors.white30),
// // // // //                       ),
// // // // //                       child: Row(
// // // // //                         mainAxisSize: MainAxisSize.min,
// // // // //                         children: const [
// // // // //                           Icon(Icons.security, color: Colors.white),
// // // // //                           SizedBox(width: 8),
// // // // //                           Text(
// // // // //                             'Your information is secure',
// // // // //                             style: TextStyle(color: Colors.white70),
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
// // // // // }


// // // // // lib/screens/booking_payment_success_page.dart
// // // // //
// // // // // Displays a “payment successful” screen for table bookings.
// // // // // When the page loads, it calls your backend to finalize the booking:
// // // // //
// // // // //   GET http://localhost:8000/ELACO/booking/payment
// // // // //       ?start_time={startTime}
// // // // //       &end_time={endTime}
// // // // //       &numTable={numTable}
// // // // //       &date={date}

// // // // import 'dart:convert';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;

// // // // class BookingPaymentSuccessPage extends StatefulWidget {
// // // //   final String? startTime;
// // // //   final String? endTime;
// // // //   final String? numTable;
// // // //   final String? date;
// // // //   final String? paymentRef;

// // // //   const BookingPaymentSuccessPage({
// // // //     Key? key,
// // // //     this.startTime,
// // // //     this.endTime,
// // // //     this.numTable,
// // // //     this.date,
// // // //     this.paymentRef,
// // // //   }) : super(key: key);

// // // //   @override
// // // //   State<BookingPaymentSuccessPage> createState() =>
// // // //       _BookingPaymentSuccessPageState();
// // // // }

// // // // class _BookingPaymentSuccessPageState extends State<BookingPaymentSuccessPage>
// // // //     with TickerProviderStateMixin {
// // // //   bool _loading = true;
// // // //   String? _errorMessage;
// // // //   late String? _paymentRef;


// // // //   late final AnimationController _scaleCtrl;
// // // //   late final AnimationController _slideCtrl;
// // // //   late final AnimationController _fadeCtrl;
// // // //   late final Animation<double> _scaleAnim;
// // // //   late final Animation<Offset> _slideAnim;
// // // //   late final Animation<double> _fadeAnim;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _initAnimations();
// // // //     _finalizeBooking();
// // // //   }

// // // //   void _initAnimations() {
// // // //     _scaleCtrl = AnimationController(
// // // //       vsync: this,
// // // //       duration: const Duration(milliseconds: 800),
// // // //     );
// // // //     _slideCtrl = AnimationController(
// // // //       vsync: this,
// // // //       duration: const Duration(milliseconds: 1000),
// // // //     );
// // // //     _fadeCtrl = AnimationController(
// // // //       vsync: this,
// // // //       duration: const Duration(milliseconds: 1200),
// // // //     );

// // // //     _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// // // //       CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut),
// // // //     );
// // // //     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
// // // //         .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
// // // //     _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// // // //       CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
// // // //     );
// // // //   }

// // // //   Future<void> _finalizeBooking() async {
// // // //     final qs = {
// // // //       'start_time': widget.startTime ?? '',
// // // //       'end_time':   widget.endTime   ?? '',
// // // //       'numTable':   widget.numTable  ?? '',
// // // //       'date':       widget.date      ?? '',
// // // //     };
// // // //     final uri = Uri.http(
// // // //       'localhost:8000',
// // // //       '/ELACO/booking/payment',
// // // //       qs,
// // // //     );

// // // //     try {
// // // //       final resp = await http.get(uri);
// // // //       if (resp.statusCode != 200) {
// // // //         throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
// // // //       }
// // // //       final data = jsonDecode(resp.body) as Map<String, dynamic>;
// // // //       if (data['status'] != 'success') {
// // // //         throw Exception(data['message'] ?? 'Booking finalize failed');
// // // //       }
// // // //       // Success: booking finalized on backend
// // // //       print('✅ Booking finalized: $data');
// // // //     } catch (e) {
// // // //       _errorMessage = e.toString();
// // // //     }

// // // //     setState(() => _loading = false);
// // // //     _scaleCtrl.forward();
// // // //     await Future.delayed(const Duration(milliseconds: 200));
// // // //     _slideCtrl.forward();
// // // //     await Future.delayed(const Duration(milliseconds: 300));
// // // //     _fadeCtrl.forward();
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _scaleCtrl.dispose();
// // // //     _slideCtrl.dispose();
// // // //     _fadeCtrl.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   String _formatTime(String? iso) {
// // // //     if (iso == null) return '--:--';
// // // //     try {
// // // //       final dt = DateTime.parse(iso);
// // // //       return '${dt.hour.toString().padLeft(2,'0')}:'
// // // //              '${dt.minute.toString().padLeft(2,'0')}';
// // // //     } catch (_) {
// // // //       return iso;
// // // //     }
// // // //   }

// // // //   String _formatDate(String? iso) {
// // // //     if (iso == null) return '--/--/----';
// // // //     try {
// // // //       final dt = DateTime.parse(iso);
// // // //       return '${dt.month}/${dt.day}/${dt.year}';
// // // //     } catch (_) {
// // // //       return iso;
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (_loading) {
// // // //       return const Scaffold(
// // // //         body: Center(child: CircularProgressIndicator()),
// // // //       );
// // // //     }

// // // //     return Scaffold(
// // // //       body: Container(
// // // //         decoration: const BoxDecoration(
// // // //           gradient: LinearGradient(
// // // //             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //           ),
// // // //         ),
// // // //         child: SafeArea(
// // // //           child: Center(
// // // //             child: SingleChildScrollView(
// // // //               padding:
// // // //                   const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
// // // //               child: Column(
// // // //                 children: [
// // // //                   ScaleTransition(
// // // //                     scale: _scaleAnim,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.all(20),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white,
// // // //                         shape: BoxShape.circle,
// // // //                         boxShadow: [
// // // //                           BoxShadow(
// // // //                               color: Colors.black26,
// // // //                               blurRadius: 12,
// // // //                               offset: Offset(0, 6)),
// // // //                         ],
// // // //                       ),
// // // //                       child: const Icon(
// // // //                         Icons.check_circle_outline,
// // // //                         size: 80,
// // // //                         color: Color(0xFF10b981),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 28),
// // // //                   SlideTransition(
// // // //                     position: _slideAnim,
// // // //                     child: const Text(
// // // //                       'Reservation Confirmed!',
// // // //                       style: TextStyle(
// // // //                         fontSize: 26,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: Colors.white,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 12),
// // // //                   if (_errorMessage == null)
// // // //                     SlideTransition(
// // // //                       position: _slideAnim,
// // // //                       child: const Text(
// // // //                         'Your table booking is complete.',
// // // //                         style: TextStyle(
// // // //                           fontSize: 16,
// // // //                           color: Colors.white70,
// // // //                         ),
// // // //                         textAlign: TextAlign.center,
// // // //                       ),
// // // //                     )
// // // //                   else
// // // //                     Padding(
// // // //                       padding: const EdgeInsets.all(16),
// // // //                       child: Text(
// // // //                         'Error: $_errorMessage',
// // // //                         style: const TextStyle(color: Colors.redAccent),
// // // //                         textAlign: TextAlign.center,
// // // //                       ),
// // // //                     ),
// // // //                   const SizedBox(height: 40),
// // // //                   FadeTransition(
// // // //                     opacity: _fadeAnim,
// // // //                     child: Container(
// // // //                       width: double.infinity,
// // // //                       padding: const EdgeInsets.all(24),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white.withOpacity(0.95),
// // // //                         borderRadius: BorderRadius.circular(20),
// // // //                       ),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           const Text(
// // // //                             'Booking Details',
// // // //                             style: TextStyle(
// // // //                               fontSize: 18,
// // // //                               fontWeight: FontWeight.bold,
// // // //                             ),
// // // //                           ),
// // // //                           const SizedBox(height: 20),
// // // //                           Row(
// // // //                             children: [
// // // //                               const Icon(Icons.calendar_today, size: 20),
// // // //                               const SizedBox(width: 10),
// // // //                               Text(_formatDate(widget.date)),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 12),
// // // //                           Row(
// // // //                             children: [
// // // //                               const Icon(Icons.access_time, size: 20),
// // // //                               const SizedBox(width: 10),
// // // //                               Text(
// // // //                                   '${_formatTime(widget.startTime)} – ${_formatTime(widget.endTime)}'),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 12),
// // // //                           Row(
// // // //                             children: [
// // // //                               const Icon(Icons.table_bar, size: 20),
// // // //                               const SizedBox(width: 10),
// // // //                               Text('Table #${widget.numTable}'),
// // // //                             ],
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 32),
// // // //                   FadeTransition(
// // // //                     opacity: _fadeAnim,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 20, vertical: 14),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white24,
// // // //                         borderRadius: BorderRadius.circular(15),
// // // //                         border: Border.all(color: Colors.white30),
// // // //                       ),
// // // //                       child: Row(
// // // //                         mainAxisSize: MainAxisSize.min,
// // // //                         children: const [
// // // //                           Icon(Icons.security, color: Colors.white),
// // // //                           SizedBox(width: 8),
// // // //                           Text(
// // // //                             'Your information is secure',
// // // //                             style: TextStyle(color: Colors.white70),
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
// // // // }


// // // // lib/screens/booking_payment_success_page.dart

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // class BookingPaymentSuccessPage extends StatefulWidget {
// // //   /// These come from your redirect URL:
// // //   ///   #/payment?start_time=…&end_time=…&numTable=…&date=…
// // //   final String? startTime;
// // //   final String? endTime;
// // //   final String? numTable;
// // //   final String? date;

// // //   const BookingPaymentSuccessPage({
// // //     Key? key,
// // //     this.startTime,
// // //     this.endTime,
// // //     this.numTable,
// // //     this.date,
// // //   }) : super(key: key);

// // //   @override
// // //   _BookingPaymentSuccessPageState createState() =>
// // //       _BookingPaymentSuccessPageState();
// // // }

// // // class _BookingPaymentSuccessPageState extends State<BookingPaymentSuccessPage>
// // //     with TickerProviderStateMixin {
// // //   bool _loading = true;
// // //   String? _error;

// // //   late final AnimationController _scaleCtrl;
// // //   late final AnimationController _slideCtrl;
// // //   late final AnimationController _fadeCtrl;
// // //   late final Animation<double> _scaleAnim;
// // //   late final Animation<Offset> _slideAnim;
// // //   late final Animation<double> _fadeAnim;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initAnimations();
// // //     _finalizeBooking();
// // //   }

// // //   void _initAnimations() {
// // //     _scaleCtrl = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 800),
// // //     );
// // //     _slideCtrl = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 1000),
// // //     );
// // //     _fadeCtrl = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 1200),
// // //     );
// // //     _scaleAnim = Tween(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut),
// // //     );
// // //     _slideAnim = Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(
// // //       CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic),
// // //     );
// // //     _fadeAnim = Tween(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
// // //     );
// // //   }

// // //   Future<void> _finalizeBooking() async {
// // //     final uri = Uri.parse(
// // //       'http://localhost:8000/ELACO/booking/payment'
// // //       '?start_time=${Uri.encodeComponent(widget.startTime ?? '')}'
// // //       '&end_time=${Uri.encodeComponent(widget.endTime ?? '')}'
// // //       '&numTable=${Uri.encodeComponent(widget.numTable ?? '')}'
// // //       '&date=${Uri.encodeComponent(widget.date ?? '')}',
// // //     );

// // //     try {
// // //       final res = await http.get(uri);
// // //       if (res.statusCode != 200) {
// // //         throw Exception('HTTP ${res.statusCode}: ${res.body}');
// // //       }
// // //       final data = jsonDecode(res.body) as Map<String, dynamic>;
// // //       if (data['status'] != 'success') {
// // //         throw Exception(data['message'] ?? 'Booking failed');
// // //       }
// // //     } catch (e) {
// // //       _error = e.toString();
// // //     }

// // //     setState(() => _loading = false);
// // //     _scaleCtrl.forward();
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _slideCtrl.forward();
// // //     await Future.delayed(const Duration(milliseconds: 300));
// // //     _fadeCtrl.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _scaleCtrl.dispose();
// // //     _slideCtrl.dispose();
// // //     _fadeCtrl.dispose();
// // //     super.dispose();
// // //   }

// // //   String _formatTime(String? iso) {
// // //     if (iso == null) return '--:--';
// // //     try {
// // //       final dt = DateTime.parse(iso);
// // //       return '${dt.hour.toString().padLeft(2,'0')}:'
// // //              '${dt.minute.toString().padLeft(2,'0')}';
// // //     } catch (_) {
// // //       return iso;
// // //     }
// // //   }

// // //   String _formatDate(String? iso) {
// // //     if (iso == null) return '--/--/----';
// // //     try {
// // //       final dt = DateTime.parse(iso);
// // //       return '${dt.month}/${dt.day}/${dt.year}';
// // //     } catch (_) {
// // //       return iso;
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_loading) {
// // //       return const Scaffold(
// // //         body: Center(child: CircularProgressIndicator()),
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
// // //               padding:
// // //                   const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
// // //               child: Column(
// // //                 children: [
// // //                   ScaleTransition(
// // //                     scale: _scaleAnim,
// // //                     child: Container(
// // //                       padding: const EdgeInsets.all(20),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         shape: BoxShape.circle,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                               color: Colors.black26,
// // //                               blurRadius: 12,
// // //                               offset: Offset(0, 6)),
// // //                         ],
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.check_circle_outline,
// // //                         size: 80,
// // //                         color: Color(0xFF10b981),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 28),
// // //                   SlideTransition(
// // //                     position: _slideAnim,
// // //                     child: _error == null
// // //                         ? const Text(
// // //                             'Booking Confirmed!',
// // //                             style: TextStyle(
// // //                               fontSize: 26,
// // //                               fontWeight: FontWeight.bold,
// // //                               color: Colors.white,
// // //                             ),
// // //                           )
// // //                         : Text(
// // //                             'Error: $_error',
// // //                             style:
// // //                                 const TextStyle(color: Colors.redAccent),
// // //                             textAlign: TextAlign.center,
// // //                           ),
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   SlideTransition(
// // //                     position: _slideAnim,
// // //                     child: Text(
// // //                       _error == null
// // //                           ? 'Your table has been reserved.'
// // //                           : 'Please try again later.',
// // //                       style: const TextStyle(
// // //                         fontSize: 16,
// // //                         color: Colors.white70,
// // //                       ),
// // //                       textAlign: TextAlign.center,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 40),
// // //                   FadeTransition(
// // //                     opacity: _fadeAnim,
// // //                     child: Container(
// // //                       width: double.infinity,
// // //                       padding: const EdgeInsets.all(24),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white.withOpacity(0.95),
// // //                         borderRadius: BorderRadius.circular(20),
// // //                       ),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const Text(
// // //                             'Reservation Details',
// // //                             style: TextStyle(
// // //                                 fontSize: 18,
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Color(0xFF1f2937)),
// // //                           ),
// // //                           const SizedBox(height: 20),
// // //                           Row(
// // //                             children: [
// // //                               const Icon(Icons.calendar_today, size: 20),
// // //                               const SizedBox(width: 10),
// // //                               Text(_formatDate(widget.date)),
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 12),
// // //                           Row(
// // //                             children: [
// // //                               const Icon(Icons.access_time, size: 20),
// // //                               const SizedBox(width: 10),
// // //                               Text(
// // //                                   '${_formatTime(widget.startTime)}  –  ${_formatTime(widget.endTime)}'),
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 12),
// // //                           Row(
// // //                             children: [
// // //                               const Icon(Icons.table_bar, size: 20),
// // //                               const SizedBox(width: 10),
// // //                               Text('Table #${widget.numTable}'),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 32),
// // //                   FadeTransition(
// // //                     opacity: _fadeAnim,
// // //                     child: Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 20, vertical: 14),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white24,
// // //                         borderRadius: BorderRadius.circular(15),
// // //                         border: Border.all(color: Colors.white30),
// // //                       ),
// // //                       child: const Row(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: [
// // //                           Icon(Icons.security, color: Colors.white),
// // //                           SizedBox(width: 8),
// // //                           Text(
// // //                             'Your information is secure',
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
// // // }

// // // lib/screens/booking_payment_success_page.dart

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class BookingPaymentSuccessPage extends StatefulWidget {
// //   /// These come from your successUrl:
// //   ///   #/payment?payment_ref=…&start_time=…&end_time=…&numTable=…&date=…
// //   final String? paymentRef;
// //   final String? startTime;
// //   final String? endTime;
// //   final String? numTable;
// //   final String? date;

// //   const BookingPaymentSuccessPage({
// //     Key? key,
// //     this.paymentRef,
// //     this.startTime,
// //     this.endTime,
// //     this.numTable,
// //     this.date,
// //   }) : super(key: key);

// //   @override
// //   _BookingPaymentSuccessPageState createState() =>
// //       _BookingPaymentSuccessPageState();
// // }

// // class _BookingPaymentSuccessPageState extends State<BookingPaymentSuccessPage>
// //     with TickerProviderStateMixin {
// //   bool _loading = true;
// //   String? _error;

// //   late final AnimationController _scaleCtrl;
// //   late final AnimationController _slideCtrl;
// //   late final AnimationController _fadeCtrl;
// //   late final Animation<double> _scaleAnim;
// //   late final Animation<Offset> _slideAnim;
// //   late final Animation<double> _fadeAnim;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initAnimations();
// //     _finalizeBooking();
// //   }

// //   void _initAnimations() {
// //     _scaleCtrl = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 800),
// //     );
// //     _slideCtrl = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1000),
// //     );
// //     _fadeCtrl = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1200),
// //     );

// //     _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut),
// //     );
// //     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
// //         .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
// //     _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
// //     );
// //   }

// //   Future<void> _finalizeBooking() async {
// //     final uri = Uri.parse(
// //       'http://localhost:8000/ELACO/booking/payment'
// //       '?start_time=${Uri.encodeComponent(widget.startTime ?? '')}'
// //       '&end_time=${Uri.encodeComponent(widget.endTime ?? '')}'
// //       '&numTable=${Uri.encodeComponent(widget.numTable ?? '')}'
// //       '&date=${Uri.encodeComponent(widget.date ?? '')}'
// //       '&payment_ref=${Uri.encodeComponent(widget.paymentRef ?? '')}',
// //     );

// //     try {
// //       final res = await http.get(uri);
// //       if (res.statusCode != 200) {
// //         throw Exception('HTTP ${res.statusCode}: ${res.body}');
// //       }
// //       final data = jsonDecode(res.body) as Map<String, dynamic>;
// //       if (data['status'] != 'success') {
// //         throw Exception(data['message'] ?? 'Booking failed');
// //       }
// //       // Success
// //       print('✅ Booking finalized: $data');
// //     } catch (e) {
// //       _error = e.toString();
// //     }

// //     setState(() => _loading = false);
// //     _scaleCtrl.forward();
// //     await Future.delayed(const Duration(milliseconds: 200));
// //     _slideCtrl.forward();
// //     await Future.delayed(const Duration(milliseconds: 300));
// //     _fadeCtrl.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _scaleCtrl.dispose();
// //     _slideCtrl.dispose();
// //     _fadeCtrl.dispose();
// //     super.dispose();
// //   }

// //   String _formatTime(String? iso) {
// //     if (iso == null) return '--:--';
// //     try {
// //       final dt = DateTime.parse(iso);
// //       return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
// //     } catch (_) {
// //       return iso;
// //     }
// //   }

// //   String _formatDate(String? iso) {
// //     if (iso == null) return '--/--/----';
// //     try {
// //       final dt = DateTime.parse(iso);
// //       return '${dt.month}/${dt.day}/${dt.year}';
// //     } catch (_) {
// //       return iso;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (_loading) {
// //       return const Scaffold(
// //         body: Center(child: CircularProgressIndicator()),
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
// //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
// //               child: Column(
// //                 children: [
// //                   ScaleTransition(
// //                     scale: _scaleAnim,
// //                     child: Container(
// //                       padding: const EdgeInsets.all(20),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black26,
// //                             blurRadius: 12,
// //                             offset: const Offset(0, 6),
// //                           ),
// //                         ],
// //                       ),
// //                       child: const Icon(
// //                         Icons.check_circle_outline,
// //                         size: 80,
// //                         color: Color(0xFF10b981),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 28),
// //                   SlideTransition(
// //                     position: _slideAnim,
// //                     child: Text(
// //                       _error == null
// //                           ? 'Booking Confirmed!'
// //                           : 'Error: $_error',
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         fontSize: 26,
// //                         fontWeight: FontWeight.bold,
// //                         color:
// //                             _error == null ? Colors.white : Colors.redAccent,
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 12),
// //                   SlideTransition(
// //                     position: _slideAnim,
// //                     child: Text(
// //                       _error == null
// //                           ? 'Your table has been reserved.'
// //                           : 'Please try again later.',
// //                       style: const TextStyle(
// //                         fontSize: 16,
// //                         color: Colors.white70,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 40),
// //                   FadeTransition(
// //                     opacity: _fadeAnim,
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
// //                           const Text(
// //                             'Reservation Details',
// //                             style: TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Color(0xFF1f2937),
// //                             ),
// //                           ),
// //                           const SizedBox(height: 20),
// //                           Row(
// //                             children: [
// //                               const Icon(Icons.calendar_today, size: 20),
// //                               const SizedBox(width: 10),
// //                               Text(_formatDate(widget.date)),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 12),
// //                           Row(
// //                             children: [
// //                               const Icon(Icons.access_time, size: 20),
// //                               const SizedBox(width: 10),
// //                               Text(
// //                                 '${_formatTime(widget.startTime)}  –  ${_formatTime(widget.endTime)}',
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 12),
// //                           Row(
// //                             children: [
// //                               const Icon(Icons.table_bar, size: 20),
// //                               const SizedBox(width: 10),
// //                               Text('Table #${widget.numTable}'),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 12),
// //                           if (widget.paymentRef != null) ...[
// //                             const Divider(),
// //                             Text(
// //                               'Payment Ref: ${widget.paymentRef!}',
// //                               style: const TextStyle(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                             ),
// //                           ],
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 32),
// //                   FadeTransition(
// //                     opacity: _fadeAnim,
// //                     child: Container(
// //                       padding:
// //                           const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white24,
// //                         borderRadius: BorderRadius.circular(15),
// //                         border: Border.all(color: Colors.white30),
// //                       ),
// //                       child: const Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Icon(Icons.security, color: Colors.white),
// //                           SizedBox(width: 8),
// //                           Text(
// //                             'Your information is secure',
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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// /// Shows the success/failure screen and finalises the booking.
// ///
// /// Expects the following parameters in the success URL *fragment*:
// ///   #/payment?payment_ref=…&start_time=…&end_time=…&numTable=…&date=…
// class BookingPaymentSuccessPage extends StatefulWidget {
//   final String? paymentRef;  // ← payment_ref from Konnect
//   final String? startTime;
//   final String? endTime;
//   final String? numTable;
//   final String? date;
//   // String? userId;


//   const BookingPaymentSuccessPage({
//     Key? key,
//     this.paymentRef,
//     this.startTime,
//     this.endTime,
//     this.numTable,
//     this.date,
//   }) : super(key: key);

//   @override
//   State<BookingPaymentSuccessPage> createState() =>
//       _BookingPaymentSuccessPageState();
// }

// class _BookingPaymentSuccessPageState extends State<BookingPaymentSuccessPage>
//     with TickerProviderStateMixin {
//   bool _loading = true;
//   String? _error;
//   String? _userId;

//   late final AnimationController _scaleCtrl;
//   late final AnimationController _slideCtrl;
//   late final AnimationController _fadeCtrl;

//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _fetchUserId().then((_) => _finalizeBooking());
//   }

//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userString = prefs.getString('user');
//     if (userString != null) {
//       final user = json.decode(userString);
//       setState(() {
//         _userId = user['_id'] ?? user['id']; // Adjust based on actual key
//         print(_userId);
//       });
//     }
//   }

//   /* ─────────────────── animations ─────────────────── */
//   void _initAnimations() {
//     _scaleCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _slideCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _fadeCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//   }

//   /* ────────────────  1. get logged-in user id  ──────────────── */
//   // Future<void> _fetchUserId() async {
//   //   try {
//   //     final r = await http.get(
//   //       Uri.parse('http://localhost:8000/ELACO/getUserId'),
//   //       headers: {'Accept': 'application/json'},
//   //     );
//   //     if (r.statusCode == 200) {
//   //       final j = jsonDecode(r.body);
//   //       _userId = j['id_user']?.toString();
//   //     } else {
//   //       throw Exception('HTTP ${r.statusCode}: ${r.body}');
//   //     }
//   //   } catch (e) {
//   //     _error = 'Unable to identify user';
//   //   }
//   // }

//   /* ───────────────  2. verify payment & book table  ─────────────── */
//   Future<void> _finalizeBooking() async {
//     if (_error != null) {
//       setState(() => _loading = false);
//       return;
//     }
//     if (_userId == null ||
//         widget.paymentRef == null ||
//         widget.startTime == null ||
//         widget.endTime == null ||
//         widget.numTable == null ||
//         widget.date == null) {
//       _error = 'Missing parameters';
//       setState(() => _loading = false);
//       return;
//     }

//     // Build: /ELACO/booking/verify/<paymentId>?userId=…&start_time=…
//     final uri = Uri.http(
//       'localhost:8000',
//       '/ELACO/booking/verify/${widget.paymentRef}',
//       {
//         'userId'    : _userId!,
//         'start_time': widget.startTime!,
//         'end_time'  : widget.endTime!,
//         'numTable'  : widget.numTable!,
//         'date'      : widget.date!,
//       },
//     );

//     try {
//       final res = await http.get(uri);
//       if (res.statusCode != 200) {
//         throw Exception('HTTP ${res.statusCode}: ${res.body}');
//       }
//       final data = jsonDecode(res.body);
//       if (data['status'] != 'success') {
//         throw Exception(data['message'] ?? 'Booking failed');
//       }
//     } catch (e) {
//       _error = e.toString();
//     }

//     setState(() => _loading = false);
//     _scaleCtrl.forward();
//     _slideCtrl.forward();
//     _fadeCtrl.forward();
//   }

//   /* ─────────────────── UI helpers ─────────────────── */
//   String _fmtTime(String iso) {
//     final dt = DateTime.tryParse(iso);
//     return dt == null
//         ? iso
//         : '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
//   }

//   String _fmtDate(String iso) {
//     final dt = DateTime.tryParse(iso);
//     return dt == null ? iso : '${dt.day}/${dt.month}/${dt.year}';
//   }

//   /* ───────────────────── UI  ───────────────────── */
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     if (_loading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               child: Column(
//                 children: [
//                   ScaleTransition(
//                     scale: _scaleCtrl,
//                     child: Icon(
//                       _error == null
//                           ? Icons.check_circle_outline
//                           : Icons.error_outline,
//                       size: 90,
//                       color: _error == null
//                           ? const Color(0xFF10b981)
//                           : Colors.redAccent,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     _error == null ? 'Booking Confirmed!' : 'Booking Failed',
//                     style: theme.textTheme.headlineSmall?.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     _error ??
//                         'Your reservation is now in our system. See you soon!',
//                     style: theme.textTheme.bodyMedium
//                         ?.copyWith(color: Colors.white70),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 36),
//                   if (_error == null) _reservationCard(theme),
//                   const SizedBox(height: 36),
//                   _primaryButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _reservationCard(ThemeData theme) => Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.95),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Reservation Details',
//                 style: theme.textTheme.titleMedium
//                     ?.copyWith(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             _row(Icons.calendar_today, _fmtDate(widget.date!)),
//             const SizedBox(height: 12),
//             _row(Icons.access_time,
//                 '${_fmtTime(widget.startTime!)} – ${_fmtTime(widget.endTime!)}'),
//             const SizedBox(height: 12),
//             _row(Icons.table_bar, 'Table #${widget.numTable}'),
//             const SizedBox(height: 12),
//             _row(Icons.receipt, 'Payment Ref: ${widget.paymentRef}'),
//           ],
//         ),
//       );

//   Widget _row(IconData icon, String text) => Row(
//         children: [
//           Icon(icon, size: 20, color: const Color(0xFF4b5563)),
//           const SizedBox(width: 10),
//           Text(text),
//         ],
//       );

//   Widget _primaryButton(BuildContext ctx) => SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             backgroundColor:
//                 _error == null ? const Color(0xFF10b981) : Colors.redAccent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           onPressed: () =>
//               Navigator.of(ctx).pushReplacementNamed(_error == null ? '/list' : '/booking'),
//           child: Text(
//             _error == null ? 'Go to My Bookings' : 'Try Again',
//             style: const TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       );
// }


// booking_payment_success_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingPaymentSuccessPage extends StatefulWidget {
  final String? paymentRef;
  final String? startTime;
  final String? endTime;
  final String? numTable;
  final String? date;

  const BookingPaymentSuccessPage({
    Key? key,
    this.paymentRef,
    this.startTime,
    this.endTime,
    this.numTable,
    this.date,
  }) : super(key: key);

  @override
  State<BookingPaymentSuccessPage> createState() =>
      _BookingPaymentSuccessPageState();
}

class _BookingPaymentSuccessPageState extends State<BookingPaymentSuccessPage>
    with TickerProviderStateMixin {
  bool _loading = true;
  String? _error;
  String? _userId;

  late final AnimationController _scaleCtrl;
  late final AnimationController _slideCtrl;
  late final AnimationController _fadeCtrl;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadUserId().then((_) {
      _finalizeBooking();
    });
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      final user = json.decode(userString);
      setState(() {
        // adjust key if your JSON uses a different field name:
        _userId = (user['_id'] ?? user['id'])?.toString();
      });
    } else {
      setState(() {
        _error = 'Not logged in';
        _loading = false;
      });
    }
  }

  void _initAnimations() {
    _scaleCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds:1000));
    _fadeCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds:1200));
  }

  Future<void> _finalizeBooking() async {
    if (_error != null) return; // already failed

    if (_userId == null ||
        widget.paymentRef == null ||
        widget.startTime == null ||
        widget.endTime == null ||
        widget.numTable == null ||
        widget.date == null) {
      setState(() {
        _error = 'Missing parameters';
        _loading = false;
      });
      return;
    }

    // ⚠️ On Android emulator use '10.0.2.2:8000' instead of 'localhost:8000'
    final uri = Uri.http(
      'localhost:8000',
      '/ELACO/booking/verify/${widget.paymentRef}',
      {
        'userId'    : _userId!,
        'start_time': widget.startTime!,
        'end_time'  : widget.endTime!,
        'numTable'  : widget.numTable!,
        'date'      : widget.date!,
      },
    );

    try {
      final res = await http.get(uri);
      if (res.statusCode != 200) {
        throw Exception('HTTP ${res.statusCode}: ${res.body}');
      }
      final data = jsonDecode(res.body);
      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Booking failed');
      }
    } catch (e) {
      _error = e.toString();
    }

    setState(() {
      _loading = false;
    });
    _scaleCtrl.forward();
    _slideCtrl.forward();
    _fadeCtrl.forward();
  }

  String _fmtTime(String iso) {
    final dt = DateTime.tryParse(iso);
    return dt == null
        ? iso
        : '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
  }

  String _fmtDate(String iso) {
    final dt = DateTime.tryParse(iso);
    return dt == null ? iso : '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isError = _error != null;
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
              padding: const EdgeInsets.symmetric(horizontal:24, vertical:32),
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _scaleCtrl,
                    child: Icon(
                      isError ? Icons.error_outline : Icons.check_circle_outline,
                      size: 90,
                      color: isError ? Colors.redAccent : Color(0xFF10b981),
                    ),
                  ),
                  const SizedBox(height:24),
                  Text(
                    isError ? 'Booking Failed' : 'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height:12),
                  Text(
                    isError
                        ? (_error!)
                        : 'Your reservation is now in our system. See you soon!',
                    style: TextStyle(fontSize:16, color:Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height:36),
                  if (!isError) _reservationCard(),
                  const SizedBox(height:36),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: isError ? Colors.redAccent : Color(0xFF10b981),
                  //     padding: const EdgeInsets.symmetric(vertical:14),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(context)
                  //         .pushReplacementNamed(isError ? '/booking' : '/list');
                  //   },
                  //   child: Text(
                  //     isError ? 'Try Again' : 'Go to My Bookings',
                  //     style: const TextStyle(color: Colors.white, fontSize:16),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _reservationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reservation Details',
            style: TextStyle(fontSize:18, fontWeight:FontWeight.bold)),
          const SizedBox(height:20),
          _row(Icons.calendar_today, _fmtDate(widget.date!)),
          const SizedBox(height:12),
          _row(Icons.access_time,
               '${_fmtTime(widget.startTime!)} – ${_fmtTime(widget.endTime!)}'),
          const SizedBox(height:12),
          _row(Icons.table_bar, 'Table #${widget.numTable}'),
          const SizedBox(height:12),
          _row(Icons.receipt, 'Payment Ref: ${widget.paymentRef}'),
        ],
      ),
    );
  }

  Widget _row(IconData i, String t) => Row(
    children: [
      Icon(i, size:20, color:Color(0xFF4b5563)),
      const SizedBox(width:10),
      Text(t),
    ],
  );
}
