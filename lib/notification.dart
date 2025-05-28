// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen>
//     with TickerProviderStateMixin {
//   List<NotificationModel> _notifications = [];
//   bool _isLoading = true;
//   String? _error;
//   String? _userId;
  
//   // Animations
//   late AnimationController _slideController;
//   late Animation<Offset> _slideAnimation;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     // Setup slide animation for screen entry
//     _slideController = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutQuint,
//     ));
    
//     // Setup fade animation
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeIn,
//     ));
    
//     // Start animations
//     _slideController.forward();
//     _fadeController.forward();
    
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userString = prefs.getString('user');
//     if (userString != null) {
//       final userMap = jsonDecode(userString);
//       _userId = userMap['_id'];
//       await _fetchNotifications();
//     }
//   }

//   Future<void> _fetchNotifications() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://localhost:8000/ELACO/notification/getUserNotifications/$_userId'));

//       if (response.statusCode != 200) {
//         throw Exception('Failed to load notifications');
//       }

//       final data = jsonDecode(response.body);
//       final List<dynamic> list = data['notifications'];
//       setState(() {
//         _notifications = list
//             .map((json) => NotificationModel.fromJson(json))
//             .toList();
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   String _getTimeAgo(DateTime time) {
//     final now = DateTime.now();
//     final difference = now.difference(time);
//     if (difference.inMinutes < 1) return 'Just now';
//     if (difference.inHours < 1) return '${difference.inMinutes} min ago';
//     if (difference.inDays < 1) return '${difference.inHours} hrs ago';
//     return DateFormat('dd/MM/yyyy').format(time);
//   }

//   @override
//   void dispose() {
//     _slideController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   Widget _buildNotificationTile(NotificationModel notification, int index) {
//     final timeAgo = _getTimeAgo(notification.sentDate);
    
//     return Hero(
//       tag: 'notification-${notification.id}',
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   // Show notification details animation
//                   _showNotificationDetails(notification);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Avatar with pulse animation
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Theme.of(context).primaryColor.withOpacity(0.2),
//                               blurRadius: 6,
//                               spreadRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor: Colors.white,
//                           backgroundImage: notification.sender.photo != null
//                               ? NetworkImage(
//                                   'http://localhost:8000/images/${notification.sender.photo}')
//                               : AssetImage('assets/default_avatar.png') as ImageProvider,
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     '${notification.sender.firstName} ${notification.sender.lastName}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Text(
//                                   timeAgo,
//                                   style: TextStyle(
//                                     fontSize: 12, 
//                                     color: Colors.grey[600],
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               notification.title,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               notification.content,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[800],
//                                 height: 1.3,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showNotificationDetails(NotificationModel notification) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionAnimationController: AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: 400),
//       ),
//       builder: (context) {
//         return FractionallySizedBox(
//           heightFactor: 0.75,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 12),
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 26,
//                         backgroundImage: notification.sender.photo != null
//                             ? NetworkImage(
//                                 'http://localhost:8000/images/${notification.sender.photo}')
//                             : AssetImage('assets/default_avatar.png') as ImageProvider,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${notification.sender.firstName} ${notification.sender.lastName}',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             Text(
//                               _getTimeAgo(notification.sentDate),
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         notification.title,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         notification.content,
//                         style: TextStyle(
//                           fontSize: 16,
//                           height: 1.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: ElevatedButton(
//                     onTap(): () => Navigator.pop(context),
//                     child: Text('Dismiss'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       foregroundColor: Colors.white,
//                       minimumSize: Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.notifications_off_outlined,
//               size: 60,
//               color: Colors.grey[400],
//             ),
//           ),
//           SizedBox(height: 24),
//           Text(
//             'No notifications yet',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'You\'ll be notified when something happens',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 60,
//             color: Colors.red[300],
//           ),
//           SizedBox(height: 24),
//           Text(
//             'Something went wrong',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             _error ?? 'Could not load notifications',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () {
//               setState(() {
//                 _isLoading = true;
//                 _error = null;
//               });
//               _fetchNotifications();
//             },
//             icon: Icon(Icons.refresh),
//             label: Text('Try Again'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Theme.of(context).primaryColor,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Notifications',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 _isLoading = true;
//               });
//               _fetchNotifications();
//             },
//           ),
//         ],
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: AnimatedSwitcher(
//             duration: Duration(milliseconds: 400),
//             child: _isLoading
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 50,
//                           height: 50,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 3,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Theme.of(context).primaryColor,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Loading notifications...',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : _error != null
//                     ? _buildErrorState()
//                     : _notifications.isEmpty
//                         ? _buildEmptyState()
//                         : AnimationLimiter(
//                             child: RefreshIndicator(
//                               onRefresh: _fetchNotifications,
//                               color: Theme.of(context).primaryColor,
//                               backgroundColor: Colors.white,
//                               strokeWidth: 3,
//                               child: ListView.builder(
//                                 physics: BouncingScrollPhysics(),
//                                 padding: EdgeInsets.only(top: 8, bottom: 24),
//                                 itemCount: _notifications.length,
//                                 itemBuilder: (context, index) {
//                                   return AnimationConfiguration.staggeredList(
//                                     position: index,
//                                     duration: Duration(milliseconds: 500),
//                                     child: SlideAnimation(
//                                       horizontalOffset: 50.0,
//                                       child: FadeInAnimation(
//                                         child: _buildNotificationTile(
//                                           _notifications[index],
//                                           index,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // You can keep these model classes in a separate file
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
//       sentDate: DateTime.parse(json['sentDate'] ?? DateTime.now().toString()),
//       sender: SenderModel.fromJson(json['sender_id'] ?? {}),
//     );
//   }
// }

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
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  String? _error;
  String? _userId;
  
  // Enhanced animations
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Color constants
  static const Color accentColor = Color(0xFF07EBBD);
  static const Color backgroundColor = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF666666);
  static const Color surfaceColor = Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    
    // Enhanced slide animation
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));
    
    // Enhanced fade animation
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    ));

    // Pulse animation for loading indicator
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations with staggered timing
    Future.delayed(Duration(milliseconds: 100), () {
      _slideController.forward();
    });
    Future.delayed(Duration(milliseconds: 200), () {
      _fadeController.forward();
    });
    
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      _userId = userMap['_id'];
      await _fetchNotifications();
    }
  }

  Future<void> _fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:8000/ELACO/notification/getUserNotifications/$_userId'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load notifications');
      }

      final data = jsonDecode(response.body);
      final List<dynamic> list = data['notifications'];
      setState(() {
        _notifications = list
            .map((json) => NotificationModel.fromJson(json))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return DateFormat('MMM dd').format(time);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildNotificationTile(NotificationModel notification, int index) {
    final timeAgo = _getTimeAgo(notification.sentDate);
    
    return Hero(
      tag: 'notification-${notification.id}',
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: Offset(0, 8),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showNotificationDetails(notification),
                borderRadius: BorderRadius.circular(20),
                splashColor: accentColor.withOpacity(0.1),
                highlightColor: accentColor.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enhanced avatar with glow effect
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              accentColor.withOpacity(0.1),
                              accentColor.withOpacity(0.05),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: surfaceColor,
                          backgroundImage: notification.sender.photo != null
                              ? NetworkImage(
                                  'http://localhost:8000/images/${notification.sender.photo}')
                              : AssetImage('assets/default_avatar.png') as ImageProvider,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${notification.sender.firstName} ${notification.sender.lastName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: textPrimary,
                                      letterSpacing: -0.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: accentColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    timeAgo,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: accentColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: accentColor,
                                letterSpacing: -0.1,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              notification.content,
                              style: TextStyle(
                                fontSize: 14,
                                color: textSecondary,
                                height: 1.4,
                                letterSpacing: -0.1,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Subtle arrow indicator
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: textSecondary.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionAnimationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, -8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              accentColor.withOpacity(0.15),
                              accentColor.withOpacity(0.05),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(4),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: surfaceColor,
                          backgroundImage: notification.sender.photo != null
                              ? NetworkImage(
                                  'http://localhost:8000/images/${notification.sender.photo}')
                              : AssetImage('assets/default_avatar.png') as ImageProvider,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${notification.sender.firstName} ${notification.sender.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _getTimeAgo(notification.sentDate),
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: accentColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              notification.content,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: textSecondary,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Action button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accentColor, accentColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Text(
                            'Got it',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          SizedBox(height: 32),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'You\'ll be notified when something happens',
            style: TextStyle(
              fontSize: 16,
              color: textSecondary,
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              _error ?? 'Could not load notifications',
              style: TextStyle(
                fontSize: 16,
                color: textSecondary,
                letterSpacing: -0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _fetchNotifications();
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Loading notifications...',
            style: TextStyle(
              color: textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to home tab within the MainLayout
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _fetchNotifications();
                },
                child: Icon(Icons.refresh, color: accentColor, size: 20),
              ),
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _isLoading
                ? _buildLoadingIndicator()
                : _error != null
                    ? _buildErrorState()
                    : _notifications.isEmpty
                        ? _buildEmptyState()
                        : AnimationLimiter(
                            child: RefreshIndicator(
                              onRefresh: _fetchNotifications,
                              color: accentColor,
                              backgroundColor: backgroundColor,
                              strokeWidth: 3,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.only(top: 16, bottom: 40),
                                itemCount: _notifications.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 600),
                                    delay: Duration(milliseconds: 100),
                                    child: SlideAnimation(
                                      horizontalOffset: 100.0,
                                      curve: Curves.easeOutCubic,
                                      child: FadeInAnimation(
                                        curve: Curves.easeOut,
                                        child: _buildNotificationTile(
                                          _notifications[index],
                                          index,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}

// Model classes
class NotificationModel {
  final String id;
  final String content;
  final String title;
  final DateTime sentDate;
  final SenderModel sender;

  NotificationModel({
    required this.id,
    required this.content,
    required this.title,
    required this.sentDate,
    required this.sender,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      title: json['title'] ?? '',
      sentDate: DateTime.parse(json['sentDate'] ?? DateTime.now().toString()),
      sender: SenderModel.fromJson(json['sender_id'] ?? {}),
    );
  }
}

class SenderModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? photo;

  SenderModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.photo,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      photo: json['photo'],
    );
  }
}