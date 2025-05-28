// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:intl/intl.dart';

// // // Model class for notifications
// // class NotificationModel {
// //   final String id;
// //   final String content;
// //   final String title;
// //   final DateTime sentDate;
// //   final SenderModel sender;

// //   NotificationModel({
// //     required this.id,
// //     required this.content,
// //     required this.title,
// //     required this.sentDate,
// //     required this.sender,
// //   });

// //   factory NotificationModel.fromJson(Map<String, dynamic> json) {
// //     return NotificationModel(
// //       id: json['_id'] ?? '',
// //       content: json['content'] ?? '',
// //       title: json['title'] ?? '',
// //       sentDate: json['sentDate'] != null ? DateTime.parse(json['sentDate']) : DateTime.now(),
// //       sender: SenderModel.fromJson(json['sender_id'] ?? {}),
// //     );
// //   }
// // }

// // // Model class for notification sender
// // class SenderModel {
// //   final String id;
// //   final String firstName;
// //   final String lastName;
// //   final String? photo;

// //   SenderModel({
// //     required this.id,
// //     required this.firstName,
// //     required this.lastName,
// //     this.photo,
// //   });

// //   factory SenderModel.fromJson(Map<String, dynamic> json) {
// //     return SenderModel(
// //       id: json['_id'] ?? '',
// //       firstName: json['firstName'] ?? '',
// //       lastName: json['lastName'] ?? '',
// //       photo: json['photo'],
// //     );
// //   }
// // }

// // class NotificationDropdown extends StatefulWidget {
// //   final String userId;
// //   final String baseUrl; // API base URL

// //   const NotificationDropdown({
// //     Key? key,
// //     required this.userId,
// //     required this.baseUrl,
// //   }) : super(key: key);

// //   @override
// //   _NotificationDropdownState createState() => _NotificationDropdownState();
// // }

// // class _NotificationDropdownState extends State<NotificationDropdown> with SingleTickerProviderStateMixin {
// //   final LayerLink _layerLink = LayerLink();
// //   OverlayEntry? _overlayEntry;
// //   bool _isOpen = false;
// //   bool _hasNotifications = true;
// //   bool _isLoading = true;
// //   String? _error;
// //   List<NotificationModel> _notifications = [];
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: Duration(milliseconds: 200),
// //     );
// //     _animation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeInOut,
// //     );
// //     _fetchNotifications();
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     _removeOverlay();
// //     super.dispose();
// //   }

// //   Future<void> _fetchNotifications() async {
// //     if (widget.userId.isEmpty) return;

// //     setState(() {
// //       _isLoading = true;
// //       _error = null;
// //     });

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${widget.baseUrl}/ELACO/notification/getUserNotifications/${widget.userId}'),
// //       );

// //       if (response.statusCode != 200) {
// //         throw Exception('Error fetching notifications: ${response.statusCode}');
// //       }

// //       final Map<String, dynamic> data = json.decode(response.body);
// //       final List<dynamic> notificationsJson = data['notifications'] ?? [];

// //       setState(() {
// //         _notifications = notificationsJson
// //             .map((json) => NotificationModel.fromJson(json))
// //             .toList();
// //         _hasNotifications = _notifications.isNotEmpty;
// //         _isLoading = false;
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _error = e.toString();
// //         _isLoading = false;
// //       });
// //       print('Error fetching notifications: $e');
// //     }
// //   }

// //   void _toggleDropdown() {
// //     if (_isOpen) {
// //       _removeOverlay();
// //     } else {
// //       _showOverlay();
// //     }

// //     setState(() {
// //       _isOpen = !_isOpen;
// //       _hasNotifications = false; // Mark notifications as read when opened

// //       if (_isOpen) {
// //         _animationController.forward();
// //       } else {
// //         _animationController.reverse();
// //       }
// //     });
// //   }

// //   void _removeOverlay() {
// //     _overlayEntry?.remove();
// //     _overlayEntry = null;
// //   }

// //   void _showOverlay() {
// //     _overlayEntry = _createOverlayEntry();
// //     Overlay.of(context).insert(_overlayEntry!);
// //   }

// //   OverlayEntry _createOverlayEntry() {
// //     final RenderBox renderBox = context.findRenderObject() as RenderBox;
// //     final size = renderBox.size;
// //     final offset = renderBox.localToGlobal(Offset.zero);

// //     return OverlayEntry(
// //       builder: (context) => Positioned(
// //         left: offset.dx - 300 + size.width, // Position to the left of the button
// //         top: offset.dy + size.height + 5,
// //         width: 350,
// //         child: CompositedTransformFollower(
// //           link: _layerLink,
// //           showWhenUnlinked: false,
// //           offset: Offset(-300 + size.width, size.height + 5),
// //           child: Material(
// //             elevation: 8,
// //             borderRadius: BorderRadius.circular(12),
// //             color: Colors.transparent,
// //             child: FadeTransition(
// //               opacity: _animation,
// //               child: ScaleTransition(
// //                 scale: Tween<double>(begin: 0.8, end: 1.0).animate(_animation),
// //                 child: _buildDropdownContent(),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDropdownContent() {
// //     return Container(
// //       width: 350,
// //       height: 480,
// //       decoration: BoxDecoration(
// //         color: Theme.of(context).scaffoldBackgroundColor,
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(
// //           color: Colors.grey.withOpacity(0.2),
// //         ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 10,
// //             spreadRadius: 2,
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           // Header
// //           Container(
// //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //             decoration: BoxDecoration(
// //               border: Border(
// //                 bottom: BorderSide(
// //                   color: Colors.grey.withOpacity(0.2),
// //                 ),
// //               ),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   'Notifications',
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: Theme.of(context).textTheme.titleLarge?.color,
// //                   ),
// //                 ),
// //                 IconButton(
// //                   padding: EdgeInsets.zero,
// //                   constraints: BoxConstraints(),
// //                   icon: Icon(Icons.close),
// //                   onPressed: _toggleDropdown,
// //                   color: Colors.grey,
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Notification List
// //           Expanded(
// //             child: _buildNotificationList(),
// //           ),

// //           // View All Button
// //           Padding(
// //             padding: const EdgeInsets.all(12.0),
// //             child: SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   _toggleDropdown();
// //                   // Navigate to notifications page
// //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Theme.of(context).primaryColor,
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     side: BorderSide(
// //                       color: Colors.grey.withOpacity(0.3),
// //                     ),
// //                   ),
// //                 ),
// //                 child: Text(
// //                   'View All Notifications',
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildNotificationList() {
// //     if (_isLoading) {
// //       return Center(child: CircularProgressIndicator());
// //     }

// //     if (_error != null) {
// //       return Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Text(
// //             'Error: $_error',
// //             style: TextStyle(color: Colors.red),
// //           ),
// //         ),
// //       );
// //     }

// //     if (_notifications.isEmpty) {
// //       return Center(
// //         child: Text(
// //           'No new notifications',
// //           style: TextStyle(color: Colors.grey),
// //         ),
// //       );
// //     }

// //     return ListView.builder(
// //       padding: EdgeInsets.zero,
// //       itemCount: _notifications.length,
// //       itemBuilder: (context, index) {
// //         final notification = _notifications[index];
// //         return _buildNotificationItem(notification);
// //       },
// //     );
// //   }

// //   Widget _buildNotificationItem(NotificationModel notification) {
// //     final timeAgo = _getTimeAgo(notification.sentDate);

// //     return Container(
// //       decoration: BoxDecoration(
// //         border: Border(
// //           bottom: BorderSide(
// //             color: Colors.grey.withOpacity(0.2),
// //           ),
// //         ),
// //       ),
// //       child: ListTile(
// //         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         leading: Stack(
// //           children: [
// //             CircleAvatar(
// //               radius: 20,
// //               backgroundImage: notification.sender.photo != null
// //                   ? NetworkImage('${widget.baseUrl}/images/${notification.sender.photo}')
// //                   : AssetImage('assets/default_avatar.png') as ImageProvider,
// //               backgroundColor: Colors.grey.withOpacity(0.2),
// //             ),
// //             Positioned(
// //               right: 0,
// //               bottom: 0,
// //               child: Container(
// //                 width: 10,
// //                 height: 10,
// //                 decoration: BoxDecoration(
// //                   color: Colors.green,
// //                   shape: BoxShape.circle,
// //                   border: Border.all(
// //                     color: Theme.of(context).scaffoldBackgroundColor,
// //                     width: 1.5,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         title: RichText(
// //           text: TextSpan(
// //             style: TextStyle(
// //               fontSize: 14,
// //               color: Colors.grey[600],
// //             ),
// //             children: [
// //               TextSpan(
// //                 text: '${notification.sender.firstName} ${notification.sender.lastName} ',
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: Theme.of(context).textTheme.bodyLarge?.color,
// //                 ),
// //               ),
// //               TextSpan(text: notification.content),
// //             ],
// //           ),
// //         ),
// //         subtitle: Padding(
// //           padding: const EdgeInsets.only(top: 4.0),
// //           child: Row(
// //             children: [
// //               Text(
// //                 notification.title,
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: Colors.grey[600],
// //                 ),
// //               ),
// //               SizedBox(width: 5),
// //               Container(
// //                 width: 4,
// //                 height: 4,
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[400],
// //                   shape: BoxShape.circle,
// //                 ),
// //               ),
// //               SizedBox(width: 5),
// //               Text(
// //                 timeAgo,
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: Colors.grey[600],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         onTap: () {
// //           _toggleDropdown();
// //           // Handle notification tap
// //         },
// //       ),
// //     );
// //   }

// //   String _getTimeAgo(DateTime dateTime) {
// //     final difference = DateTime.now().difference(dateTime);

// //     if (difference.inDays > 365) {
// //       return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? 'year' : 'years'} ago';
// //     } else if (difference.inDays > 30) {
// //       return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? 'month' : 'months'} ago';
// //     } else if (difference.inDays > 0) {
// //       return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
// //     } else if (difference.inHours > 0) {
// //       return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
// //     } else if (difference.inMinutes > 0) {
// //       return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
// //     } else {
// //       return 'Just now';
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return CompositedTransformTarget(
// //       link: _layerLink,
// //       child: GestureDetector(
// //         onTap: _toggleDropdown,
// //         child: Container(
// //           width: 48,
// //           height: 48,
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             shape: BoxShape.circle,
// //             border: Border.all(
// //               color: Colors.grey.withOpacity(0.2),
// //             ),
// //           ),
// //           child: Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               Icon(
// //                 Icons.notifications_outlined,
// //                 color: Theme.of(context).primaryColor,
// //                 size: 24,
// //               ),
// //               if (_hasNotifications)
// //                 Positioned(
// //                   top: 10,
// //                   right: 12,
// //                   child: Container(
// //                     width: 8,
// //                     height: 8,
// //                     decoration: BoxDecoration(
// //                       color: Colors.orange,
// //                       shape: BoxShape.circle,
// //                     ),
// //                     child: Center(
// //                       child: Container(
// //                         width: 8,
// //                         height: 8,
// //                         decoration: BoxDecoration(
// //                           color: Colors.orange,
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: AnimatedBuilder(
// //                           animation: _animationController,
// //                           builder: (context, child) {
// //                             return Container(
// //                               width: 8,
// //                               height: 8,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.orange.withOpacity(0.75),
// //                                 shape: BoxShape.circle,
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Usage example for the NotificationDropdown widget
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Model class for notifications
// class NotificationModel {
//   final String id;
//   final String content;
//   final String title;
//   final DateTime sentDate;
//   final SenderModel sender;

//   NotificationModel({
//     required this.id,
//     required this.content,
//     required this.title,
//     required this.sentDate,
//     required this.sender,
//   });

//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       id: json['_id'] ?? '',
//       content: json['content'] ?? '',
//       title: json['title'] ?? '',
//       sentDate: json['sentDate'] != null
//           ? DateTime.parse(json['sentDate'])
//           : DateTime.now(),
//       sender: SenderModel.fromJson(json['sender_id'] ?? {}),
//     );
//   }
// }

// // Model class for sender
// class SenderModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String? photo;

//   SenderModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     this.photo,
//   });

//   factory SenderModel.fromJson(Map<String, dynamic> json) {
//     return SenderModel(
//       id: json['_id'] ?? '',
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       photo: json['photo'],
//     );
//   }
// }

// // Notification Dropdown Widget
// class NotificationDropdown extends StatefulWidget {
//   final String baseUrl;

//   const NotificationDropdown({
//     Key? key,
//     required this.baseUrl,
//   }) : super(key: key);

//   @override
//   _NotificationDropdownState createState() => _NotificationDropdownState();
// }

// class _NotificationDropdownState extends State<NotificationDropdown>
//     with SingleTickerProviderStateMixin {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//   bool _isOpen = false;
//   bool _hasNotifications = true;
//   bool _isLoading = true;
//   String? _error;
//   List<NotificationModel> _notifications = [];
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 200),
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userString = prefs.getString('user');
//     if (userString != null) {
//       final userMap = jsonDecode(userString);
//       setState(() {
//         _userId = userMap['_id'];
//         print(_userId);
//       });
//       await _fetchNotifications();
//     }
//   }

//   Future<void> _fetchNotifications() async {
//     if (_userId == null) return;

//     setState(() {
//       _isLoading = true;
//       _error = null;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://localhost:8000/ELACO/notification/getUserNotifications/$_userId'),
//       );
//       print(response);

//       if (response.statusCode != 200) {
//         throw Exception('Error fetching notifications: ${response.statusCode}');
//       }

//       final Map<String, dynamic> data = json.decode(response.body);
//       final List<dynamic> notificationsJson = data['notifications'] ?? [];

//       setState(() {
//         _notifications = notificationsJson
//             .map((json) => NotificationModel.fromJson(json))
//             .toList();
//         _hasNotifications = _notifications.isNotEmpty;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _isLoading = false;
//       });
//       print('Error fetching notifications: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _removeOverlay();
//     super.dispose();
//   }

//   void _toggleDropdown() {
//     if (_isOpen) {
//       _removeOverlay();
//     } else {
//       _showOverlay();
//     }

//     setState(() {
//       _isOpen = !_isOpen;
//       _hasNotifications = false;

//       if (_isOpen) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   void _showOverlay() {
//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   OverlayEntry _createOverlayEntry() {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     final offset = renderBox.localToGlobal(Offset.zero);

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: offset.dx - 300 + size.width,
//         top: offset.dy + size.height + 5,
//         width: 350,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(-300 + size.width, size.height + 5),
//           child: Material(
//             elevation: 8,
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.transparent,
//             child: FadeTransition(
//               opacity: _animation,
//               child: ScaleTransition(
//                 scale: Tween<double>(begin: 0.8, end: 1.0).animate(_animation),
//                 child: _buildDropdownContent(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownContent() {
//     return Container(
//       width: 350,
//       height: 480,
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildHeader(),
//           Expanded(child: _buildNotificationList()),
//           _buildFooterButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Notifications',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).textTheme.titleLarge?.color,
//             ),
//           ),
//           IconButton(
//             padding: EdgeInsets.zero,
//             constraints: BoxConstraints(),
//             icon: Icon(Icons.close),
//             onPressed: _toggleDropdown,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNotificationList() {
//     if (_isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (_error != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text('Error: $_error', style: TextStyle(color: Colors.red)),
//         ),
//       );
//     }

//     if (_notifications.isEmpty) {
//       return Center(
//         child:
//             Text('No new notifications', style: TextStyle(color: Colors.grey)),
//       );
//     }

//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: _notifications.length,
//       itemBuilder: (context, index) {
//         final notification = _notifications[index];
//         return _buildNotificationItem(notification);
//       },
//     );
//   }

//   Widget _buildNotificationItem(NotificationModel notification) {
//     final timeAgo = _getTimeAgo(notification.sentDate);

//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
//         ),
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: CircleAvatar(
//           radius: 20,
//           backgroundImage: notification.sender.photo != null
//               ? NetworkImage(
//                   '${widget.baseUrl}/images/${notification.sender.photo}')
//               : AssetImage('assets/default_avatar.png') as ImageProvider,
//           backgroundColor: Colors.grey.withOpacity(0.2),
//         ),
//         title: RichText(
//           text: TextSpan(
//             style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             children: [
//               TextSpan(
//                 text:
//                     '${notification.sender.firstName} ${notification.sender.lastName} ',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).textTheme.bodyLarge?.color,
//                 ),
//               ),
//               TextSpan(text: notification.content),
//             ],
//           ),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 4.0),
//           child: Row(
//             children: [
//               Text(notification.title,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//               SizedBox(width: 5),
//               Container(
//                   width: 4,
//                   height: 4,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[400], shape: BoxShape.circle)),
//               SizedBox(width: 5),
//               Text(timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFooterButton() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: () {
//             _toggleDropdown();
//             // Navigate to notifications page if needed
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Theme.of(context).primaryColor,
//             padding: EdgeInsets.symmetric(vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: BorderSide(color: Colors.grey.withOpacity(0.3)),
//             ),
//           ),
//           child: Text(
//             'View All Notifications',
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),
//     );
//   }

//   String _getTimeAgo(DateTime dateTime) {
//     final now = DateTime.now();
//     final diff = now.difference(dateTime);

//     if (diff.inMinutes < 1) return 'just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     return DateFormat('MMM d, yyyy').format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggleDropdown,
//         child: Stack(
//           children: [
//             Icon(Icons.notifications, size: 30),
//             if (_hasNotifications)
//               Positioned(
//                 right: 0,
//                 top: 0,
//                 child: Container(
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
