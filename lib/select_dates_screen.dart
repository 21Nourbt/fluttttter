// // // // import 'package:flutter/material.dart';
// // // // import 'package:table_calendar/table_calendar.dart';
// // // // import 'package:url_launcher/url_launcher.dart';

// // // // import 'services/user_subscription_service.dart';
// // // // import 'web_view_screen.dart';

// // // // class SelectDatesScreen extends StatefulWidget {
// // // //   final String roomType;
// // // //   final String duration;
// // // //   final double price;
// // // //   final String id;

// // // //   SelectDatesScreen({
// // // //     required this.roomType,
// // // //     required this.duration,
// // // //     required this.price,
// // // //     required this.id,
// // // //   });

// // // //   @override
// // // //   _SelectDatesScreenState createState() => _SelectDatesScreenState();
// // // // }

// // // // class _SelectDatesScreenState extends State<SelectDatesScreen> {
// // // //   DateTime? selectedDate;
// // // //   DateTime focusedDay = DateTime.now();
// // // //   int guestCount = 1; // 👈 Added Guests counter

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Color(0xFFF9FAFB),
// // // //       appBar: AppBar(
// // // //         backgroundColor: Color(0xFFF9FAFB),
// // // //         elevation: 0,
// // // //         leading: IconButton(
// // // //           icon: Icon(Icons.arrow_back, color: Colors.black87),
// // // //           onPressed: () => Navigator.pop(context),
// // // //         ),
// // // //         title: Text(
// // // //           "Select dates",
// // // //           style: TextStyle(
// // // //             color: Colors.black87,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(20),
// // // //         child: Column(
// // // //           children: [
// // // //             Container(
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.white,
// // // //                 borderRadius: BorderRadius.circular(20),
// // // //               ),
// // // //               padding: EdgeInsets.all(10),
// // // //               child: TableCalendar(
// // // //                 firstDay: DateTime.utc(2020, 1, 1),
// // // //                 lastDay: DateTime.utc(2030, 12, 31),
// // // //                 focusedDay: focusedDay,
// // // //                 selectedDayPredicate: (day) => isSameDay(selectedDate, day),
// // // //                 onDaySelected: (selectedDay, focusedDay) {
// // // //                   setState(() {
// // // //                     selectedDate = selectedDay;
// // // //                     this.focusedDay = focusedDay;
// // // //                   });
// // // //                 },
// // // //                 calendarStyle: CalendarStyle(
// // // //                   isTodayHighlighted: true,
// // // //                   selectedDecoration: BoxDecoration(
// // // //                     color: Color(0xFF3C5DF7),
// // // //                     shape: BoxShape.circle,
// // // //                   ),
// // // //                   todayDecoration: BoxDecoration(
// // // //                     color: Colors.blueAccent.withOpacity(0.5),
// // // //                     shape: BoxShape.circle,
// // // //                   ),
// // // //                   rangeHighlightColor: Colors.blue.withOpacity(0.2),
// // // //                 ),
// // // //                 headerStyle: HeaderStyle(
// // // //                   formatButtonVisible: false,
// // // //                   titleCentered: true,
// // // //                   titleTextStyle: TextStyle(
// // // //                     fontSize: 18,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     color: Colors.black87,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             Container(
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.white,
// // // //                 borderRadius: BorderRadius.circular(20),
// // // //               ),
// // // //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   Text(
// // // //                     "Selected Date",
// // // //                     style: TextStyle(color: Colors.grey),
// // // //                   ),
// // // //                   SizedBox(height: 5),
// // // //                   Text(
// // // //                     selectedDate != null
// // // //                         ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
// // // //                         : "--/--/----",
// // // //                     style: TextStyle(
// // // //                       fontWeight: FontWeight.bold,
// // // //                       fontSize: 16,
// // // //                     ),
// // // //                   ),
// // // //                   SizedBox(height: 20),

// // // //                   // 👇 Guests Row added exactly here
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                     children: [
// // // //                       Text(
// // // //                         "Guests",
// // // //                         style: TextStyle(
// // // //                           color: Colors.black87,
// // // //                           fontWeight: FontWeight.bold,
// // // //                           fontSize: 16,
// // // //                         ),
// // // //                       ),
// // // //                       Row(
// // // //                         children: [
// // // //                           IconButton(
// // // //                             onPressed: () {
// // // //                               setState(() {
// // // //                                 if (guestCount > 1) guestCount--;
// // // //                               });
// // // //                             },
// // // //                             icon: Icon(Icons.remove_circle_outline),
// // // //                           ),
// // // //                           Text(
// // // //                             "$guestCount",
// // // //                             style: TextStyle(
// // // //                               fontWeight: FontWeight.bold,
// // // //                               fontSize: 16,
// // // //                             ),
// // // //                           ),
// // // //                           IconButton(
// // // //                             onPressed: () {
// // // //                               setState(() {
// // // //                                 guestCount++;
// // // //                               });
// // // //                             },
// // // //                             icon: Icon(Icons.add_circle_outline),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ],
// // // //                   ),

// // // //                   SizedBox(height: 20),
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // //                     children: [
// // // //                       _buildCounter("Room Type", widget.roomType),
// // // //                       _buildCounter("Duration", widget.duration),
// // // //                       _buildCounter("Price", widget.price * guestCount),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             Spacer(),
// // // //             SizedBox(
// // // //               width: double.infinity,
// // // //               child: ElevatedButton(
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: Color(0xFF3C5DF7),
// // // //                   padding: EdgeInsets.symmetric(vertical: 16),
// // // //                   shape: RoundedRectangleBorder(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                   ),
// // // //                 ),
// // // //                 onPressed: () async {
// // // //                   if (selectedDate == null) {
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       SnackBar(content: Text('Please select a date first')),
// // // //                     );
// // // //                     return;
// // // //                   }

// // // //                   final result =
// // // //                       await UserSubscriptionService.createUserSubscription(
// // // //                     subId: widget.id,
// // // //                     startDate: selectedDate!.toIso8601String(),
// // // //                     amount: widget.price * guestCount,
// // // //                   );

// // // //                   if (result['success']) {
// // // //                     print("redirectUrl");
// // // //                     print("lulu");
// // // //                     print(result);
// // // //                     print("\n");
// // // //                     print(widget.price);
// // // //                     print("the price");
// // // //                     print((widget.price * 1000));

// // // //                     final String redirectUrl = result['data']['payUrl'];
// // // //                     print(redirectUrl);

// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(
// // // //                         builder: (context) =>
// // // //                             WebViewScreen(payUrl: redirectUrl),
// // // //                       ),
// // // //                     );
// // // //                   } else {
// // // //                     print('kkkmkm');
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       SnackBar(content: Text(result['message'])),
// // // //                     );
// // // //                   }
// // // //                 },
// // // //                 child: Text(
// // // //                   "Book Room",
// // // //                   style: TextStyle(
// // // //                     fontSize: 18,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     color: Colors.white,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildCounter(String label, Object value) {
// // // //     return Column(
// // // //       children: [
// // // //         Text(label, style: TextStyle(color: Colors.grey)),
// // // //         SizedBox(height: 5),
// // // //         Text(
// // // //           value.toString(),
// // // //           style: TextStyle(
// // // //             fontSize: 16,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:table_calendar/table_calendar.dart';
// // // import 'package:url_launcher/url_launcher.dart';

// // // import 'services/user_subscription_service.dart';
// // // import 'web_view_screen.dart';

// // // class SelectDatesScreen extends StatefulWidget {
// // //   final String roomType;
// // //   final String duration;
// // //   final double price;
// // //   final String id;

// // //   const SelectDatesScreen({
// // //     Key? key,
// // //     required this.roomType,
// // //     required this.duration,
// // //     required this.price,
// // //     required this.id,
// // //   }) : super(key: key);

// // //   @override
// // //   _SelectDatesScreenState createState() => _SelectDatesScreenState();
// // // }

// // // class _SelectDatesScreenState extends State<SelectDatesScreen> {
// // //   DateTime? selectedDate;
// // //   DateTime focusedDay = DateTime.now();
// // //   int guestCount = 1; // 👈 Added Guests counter

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF9FAFB),
// // //       appBar: AppBar(
// // //         backgroundColor: const Color(0xFFF9FAFB),
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.black87),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //         title: const Text(
// // //           "Select dates",
// // //           style: TextStyle(
// // //             color: Colors.black87,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         centerTitle: true,
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(20),
// // //         child: Column(
// // //           children: [
// // //             // Calendar Container
// // //             Container(
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(20),
// // //               ),
// // //               padding: const EdgeInsets.all(10),
// // //               child: TableCalendar(
// // //                 firstDay: DateTime.utc(2020, 1, 1),
// // //                 lastDay: DateTime.utc(2030, 12, 31),
// // //                 focusedDay: focusedDay,
// // //                 selectedDayPredicate: (day) => isSameDay(selectedDate, day),
// // //                 onDaySelected: (selectedDay, newFocusedDay) {
// // //                   setState(() {
// // //                     selectedDate = selectedDay;
// // //                     focusedDay = newFocusedDay;
// // //                   });
// // //                 },
// // //                 calendarStyle: CalendarStyle(
// // //                   isTodayHighlighted: true,
// // //                   selectedDecoration: const BoxDecoration(
// // //                     color: Color.fromARGB(255, 60, 247, 235),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   todayDecoration: BoxDecoration(
// // //                     color: Color.fromARGB(255, 60, 247, 235).withOpacity(0.5),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   rangeHighlightColor:
// // //                       Color.fromARGB(255, 60, 247, 235).withOpacity(0.2),
// // //                 ),
// // //                 headerStyle: const HeaderStyle(
// // //                   formatButtonVisible: false,
// // //                   titleCentered: true,
// // //                   titleTextStyle: TextStyle(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.black87,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),

// // //             const SizedBox(height: 20),

// // //             // Details & Guest Counter
// // //             Container(
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(20),
// // //               ),
// // //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// // //               child: Column(
// // //                 children: [
// // //                   const Text(
// // //                     "Selected Date",
// // //                     style: TextStyle(color: Colors.grey),
// // //                   ),
// // //                   const SizedBox(height: 5),
// // //                   Text(
// // //                     selectedDate != null
// // //                         ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
// // //                         : "--/--/----",
// // //                     style: const TextStyle(
// // //                       fontWeight: FontWeight.bold,
// // //                       fontSize: 16,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 20),

// // //                   // Guests Row
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       const Text(
// // //                         "Guests",
// // //                         style: TextStyle(
// // //                           color: Colors.black87,
// // //                           fontWeight: FontWeight.bold,
// // //                           fontSize: 16,
// // //                         ),
// // //                       ),
// // //                       Row(
// // //                         children: [
// // //                           IconButton(
// // //                             onPressed: () {
// // //                               setState(() {
// // //                                 if (guestCount > 1) guestCount--;
// // //                               });
// // //                             },
// // //                             icon: const Icon(Icons.remove_circle_outline),
// // //                           ),
// // //                           Text(
// // //                             "$guestCount",
// // //                             style: const TextStyle(
// // //                               fontWeight: FontWeight.bold,
// // //                               fontSize: 16,
// // //                             ),
// // //                           ),
// // //                           IconButton(
// // //                             onPressed: () {
// // //                               setState(() {
// // //                                 guestCount++;
// // //                               });
// // //                             },
// // //                             icon: const Icon(Icons.add_circle_outline),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),

// // //                   const SizedBox(height: 20),

// // //                   // Summary Row
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //                     children: [
// // //                       _buildCounter("Room Type", widget.roomType),
// // //                       _buildCounter("Duration", widget.duration),
// // //                       _buildCounter("Price", widget.price * guestCount),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),

// // //             const Spacer(),

// // //             // Book Room Button
// // //             SizedBox(
// // //               width: double.infinity,
// // //               child: ElevatedButton(
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: const Color.fromARGB(255, 40, 210, 228),
// // //                   padding: const EdgeInsets.symmetric(vertical: 16),
// // //                   shape: RoundedRectangleBorder(
// // //                     borderRadius: BorderRadius.circular(12),
// // //                   ),
// // //                 ),
// // //                 onPressed: () async {
// // //                   // 1️⃣ Ensure a date is selected
// // //                   if (selectedDate == null) {
// // //                     // if (!mounted) return;
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       const SnackBar(
// // //                           content: Text('Please select a date first')),
// // //                     );
// // //                     return;
// // //                   }

// // //                   // 2️⃣ Call your service
// // //                   final result =
// // //                       await UserSubscriptionService.createUserSubscription(
// // //                     subId: widget.id,
// // //                     startDate: selectedDate!.toIso8601String(),
// // //                     amount: widget.price * guestCount,
// // //                   );

// // //                   // 3️⃣ Guard before using context
// // //                   // if (!mounted) return;

// // //                   if (result['success'] == true) {
// // //                     final String redirectUrl = result['data']['payUrl'];
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (context) =>
// // //                             WebViewScreen(payUrl: redirectUrl),
// // //                       ),
// // //                     );
// // //                   } else {
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       SnackBar(content: Text(result['message'] ?? 'Error')),
// // //                     );
// // //                   }
// // //                 },
// // //                 child: const Text(
// // //                   "Book Room",
// // //                   style: TextStyle(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCounter(String label, Object value) {
// // //     return Column(
// // //       children: [
// // //         Text(label, style: const TextStyle(color: Colors.grey)),
// // //         const SizedBox(height: 5),
// // //         Text(
// // //           value.toString(),
// // //           style: const TextStyle(
// // //             fontSize: 16,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:table_calendar/table_calendar.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // import 'services/user_subscription_service.dart';
// // import 'web_view_screen.dart';

// // class SelectDatesScreen extends StatefulWidget {
// //   final String roomType;
// //   final String duration;
// //   final double price;
// //   final String id;

// //   const SelectDatesScreen({
// //     Key? key,
// //     required this.roomType,
// //     required this.duration,
// //     required this.price,
// //     required this.id,
// //   }) : super(key: key);

// //   @override
// //   _SelectDatesScreenState createState() => _SelectDatesScreenState();
// // }

// // class _SelectDatesScreenState extends State<SelectDatesScreen> {
// //   DateTime? selectedDate;
// //   DateTime focusedDay = DateTime.now();
// //   int guestCount = 1;

// //   @override
// //   Widget build(BuildContext context) {
// //     final messenger = ScaffoldMessenger.of(context);

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF9FAFB),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF9FAFB),
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.black87),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: const Text(
// //           "Select dates",
// //           style: TextStyle(
// //             color: Colors.black87,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             // Calendar
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               padding: const EdgeInsets.all(10),
// //               child: TableCalendar(
// //                 firstDay: DateTime.utc(2020, 1, 1),
// //                 lastDay: DateTime.utc(2030, 12, 31),
// //                 focusedDay: focusedDay,
// //                 selectedDayPredicate: (day) => isSameDay(selectedDate, day),
// //                 onDaySelected: (selectedDay, newFocusedDay) {
// //                   setState(() {
// //                     selectedDate = selectedDay;
// //                     focusedDay = newFocusedDay;
// //                   });
// //                 },
// //                 calendarStyle: CalendarStyle(
// //                   isTodayHighlighted: true,
// //                   selectedDecoration: const BoxDecoration(
// //                     color: Color.fromARGB(255, 60, 247, 235),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   todayDecoration: BoxDecoration(
// //                     color: Color.fromARGB(255, 60, 247, 235).withOpacity(0.5),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   rangeHighlightColor:
// //                       Color.fromARGB(255, 60, 247, 235).withOpacity(0.2),
// //                 ),
// //                 headerStyle: const HeaderStyle(
// //                   formatButtonVisible: false,
// //                   titleCentered: true,
// //                   titleTextStyle: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             // Details & Guest Counter
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //               child: Column(
// //                 children: [
// //                   const Text("Selected Date", style: TextStyle(color: Colors.grey)),
// //                   const SizedBox(height: 5),
// //                   Text(
// //                     selectedDate != null
// //                         ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
// //                         : "--/--/----",
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 16,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),

// //                   // Guests Row
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       const Text(
// //                         "Guests",
// //                         style: TextStyle(
// //                           color: Colors.black87,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                       Row(
// //                         children: [
// //                           IconButton(
// //                             onPressed: () {
// //                               if (guestCount > 1) {
// //                                 setState(() => guestCount--);
// //                               }
// //                             },
// //                             icon: const Icon(Icons.remove_circle_outline),
// //                           ),
// //                           Text(
// //                             "$guestCount",
// //                             style: const TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 16,
// //                             ),
// //                           ),
// //                           IconButton(
// //                             onPressed: () {
// //                               setState(() => guestCount++);
// //                             },
// //                             icon: const Icon(Icons.add_circle_outline),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),

// //                   const SizedBox(height: 20),

// //                   // Summary Row
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                     children: [
// //                       _buildCounter("Room Type", widget.roomType),
// //                       _buildCounter("Duration", widget.duration),
// //                       _buildCounter("Price", widget.price * guestCount),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const Spacer(),

// //             // Book Room Button
// //             SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color.fromARGB(255, 40, 210, 228),
// //                   padding: const EdgeInsets.symmetric(vertical: 16),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //                 onPressed: () async {
// //                   // Clear any existing SnackBars
// //                   messenger.clearSnackBars();

// //                   // 1️⃣ Ensure a date is selected
// //                   if (selectedDate == null) {
// //                     messenger.showSnackBar(
// //                       const SnackBar(content: Text('Please select a date first')),
// //                     );
// //                     return;
// //                   }

// //                   // 2️⃣ Call your service
// //                   final result = await UserSubscriptionService.createUserSubscription(
// //                     subId: widget.id,
// //                     startDate: selectedDate!.toIso8601String(),
// //                     amount: widget.price * guestCount,
// //                   );

// //                   if (result['success'] == true) {
// //                     final String redirectUrl = result['data']['payUrl'];
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => WebViewScreen(payUrl: redirectUrl),
// //                       ),
// //                     );
// //                   } else {
// //                     messenger.showSnackBar(
// //                       SnackBar(content: Text(result['message'] ?? 'Error')),
// //                     );
// //                   }
// //                 },
// //                 child: const Text(
// //                   "Book Room",
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCounter(String label, Object value) {
// //     return Column(
// //       children: [
// //         Text(label, style: const TextStyle(color: Colors.grey)),
// //         const SizedBox(height: 5),
// //         Text(
// //           value.toString(),
// //           style: const TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// import 'services/user_subscription_service.dart';
// import 'web_view_screen.dart';

// class SelectDatesScreen extends StatefulWidget {
//   final String roomType;
//   final String duration;
//   final double price;
//   final String id;

//   const SelectDatesScreen({
//     Key? key,
//     required this.roomType,
//     required this.duration,
//     required this.price,
//     required this.id,
//   }) : super(key: key);

//   @override
//   _SelectDatesScreenState createState() => _SelectDatesScreenState();
// }

// class _SelectDatesScreenState extends State<SelectDatesScreen> {
//   DateTime? selectedDate;
//   DateTime focusedDay = DateTime.now();
//   int guestCount = 1;

//   // helper → always replace existing snackbar
//   void _showSnack(BuildContext ctx, String msg) {
//     final messenger = ScaffoldMessenger.of(ctx);
//     messenger.removeCurrentSnackBar();
//     messenger.showSnackBar(SnackBar(content: Text(msg)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF9FAFB),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Select dates",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // ─────────── Calendar ───────────
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.all(10),
//               child: TableCalendar(
//                 firstDay: DateTime.utc(2020, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 focusedDay: focusedDay,
//                 selectedDayPredicate: (day) => isSameDay(selectedDate, day),
//                 onDaySelected: (sel, foc) =>
//                     setState(() => {selectedDate = sel, focusedDay = foc}),
//                 calendarStyle: CalendarStyle(
//                   isTodayHighlighted: true,
//                   selectedDecoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 60, 247, 235),
//                     shape: BoxShape.circle,
//                   ),
//                   todayDecoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 60, 247, 235)
//                         .withOpacity(0.5),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                   titleTextStyle: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ─────────── Details box ───────────
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//               child: Column(
//                 children: [
//                   const Text("Selected Date",
//                       style: TextStyle(color: Colors.grey)),
//                   const SizedBox(height: 5),
//                   Text(
//                     selectedDate != null
//                         ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
//                         : "--/--/----",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Guests counter
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Guests",
//                         style: TextStyle(
//                             color: Colors.black87,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                       Row(children: [
//                         IconButton(
//                             icon: const Icon(Icons.remove_circle_outline),
//                             onPressed: () =>
//                                 setState(() => guestCount = guestCount > 1
//                                     ? guestCount - 1
//                                     : 1)),
//                         Text("$guestCount",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16)),
//                         IconButton(
//                             icon: const Icon(Icons.add_circle_outline),
//                             onPressed: () =>
//                                 setState(() => guestCount++)),
//                       ])
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Summary
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildCounter("Room Type", widget.roomType),
//                       _buildCounter("Duration", widget.duration),
//                       _buildCounter("Price", widget.price * guestCount),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const Spacer(),

//             // ─────────── Book button ───────────
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 40, 210, 228),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Book Room",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 onPressed: () async {
//                   // ensure a date
//                   if (selectedDate == null) {
//                     _showSnack(context, 'Please select a date first');
//                     return;
//                   }

//                   // call backend
//                   final res = await UserSubscriptionService
//                       .createUserSubscription(
//                     subId: widget.id,
//                     startDate: selectedDate!.toIso8601String(),
//                     amount: widget.price * guestCount,
//                   );

//                   if (res['success'] == true) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => WebViewScreen(
//                           payUrl: res['data']['payUrl'] as String,
//                         ),
//                       ),
//                     );
//                   } else {
//                     _showSnack(context, res['message'] ?? 'Error');
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCounter(String label, Object value) => Column(
//         children: [
//           Text(label, style: const TextStyle(color: Colors.grey)),
//           const SizedBox(height: 5),
//           Text("$value",
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       );
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'services/user_subscription_service.dart';
import 'web_view_screen.dart';

class SelectDatesScreen extends StatefulWidget {
  final String roomType;
  final String duration;
  final double price;
  final String id;

  const SelectDatesScreen({
    Key? key,
    required this.roomType,
    required this.duration,
    required this.price,
    required this.id,
  }) : super(key: key);

  @override
  _SelectDatesScreenState createState() => _SelectDatesScreenState();
}

class _SelectDatesScreenState extends State<SelectDatesScreen> {
  DateTime? selectedDate;
  DateTime focusedDay = DateTime.now();
  int guestCount = 1;

  /* ───────────────────────── helper ───────────────────────── */
  void _showSnack(String msg) {
    if (!mounted) return;                 // <- keeps framework happy
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(msg)));
  }

  /* ───────────────────────── UI ───────────────────────────── */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Select dates",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /* ─── Calendar ─── */
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                onDaySelected: (sel, foc) =>
                    setState(() => {selectedDate = sel, focusedDay = foc}),
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 60, 247, 235),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: const Color.fromARGB(255, 60, 247, 235)
                        .withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /* ─── Details box ─── */
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  const Text("Selected Date",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(
                    selectedDate != null
                        ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
                        : "--/--/----",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /* Guests counter */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Guests",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Row(children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () =>
                              setState(() => guestCount = guestCount > 1
                                  ? guestCount - 1
                                  : 1),
                        ),
                        Text("$guestCount",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () =>
                              setState(() => guestCount++),
                        ),
                      ])
                    ],
                  ),

                  const SizedBox(height: 20),

                  /* Summary */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCounter("Room Type", widget.roomType),
                      _buildCounter("Duration", widget.duration),
                      _buildCounter("Price", widget.price * guestCount),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /* ─── Book button ─── */
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 40, 210, 228),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Book Room",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () async {
                  /* ensure a date */
                  if (selectedDate == null) {
                    _showSnack('Please select a date first');
                    return;
                  }

                  /* call backend */
                  final res = await UserSubscriptionService
                      .createUserSubscription(
                    subId: widget.id,
                    startDate: selectedDate!.toIso8601String(),
                    amount: widget.price * guestCount,
                  );

                  if (!mounted) return;          // screen might be gone

                  if (res['success'] == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(
                          payUrl: res['data']['payUrl'] as String,
                        ),
                      ),
                    );
                  } else {
                    _showSnack(res['message'] ?? 'Error');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* small helper widget */
  Widget _buildCounter(String label, Object value) => Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Text("$value",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      );
}
