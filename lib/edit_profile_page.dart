
// import 'dart:convert';
// import 'dart:io' show File; // <-- mobile / desktop
// import 'dart:typed_data';

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:http_parser/http_parser.dart'; // for MediaType on web

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   // ────────── state ──────────
//   String? userId;
//   String? photo; // filename stored on server
//   String? _localImagePath; // picked path / blob‑URL
//   Uint8List? _localImageBytes; // picked bytes (web only)

//   final _first = TextEditingController();
//   final _last = TextEditingController();
//   final _mail = TextEditingController();
//   final _phone = TextEditingController();

//   final _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();

//   // ────────── init / dispose ──────────
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   @override
//   void dispose() {
//     _first.dispose();
//     _last.dispose();
//     _mail.dispose();
//     _phone.dispose();
//     super.dispose();
//   }

//   // ────────── load user from prefs ──────────
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final raw = prefs.getString('user');
//     if (raw == null) return;
//     final m = jsonDecode(raw) as Map<String, dynamic>;
//     setState(() {
//       userId = m['_id'] ?? '';
//       photo = m['photo'] ?? '';
//       _first.text = m['firstName'] ?? '';
//       _last.text = m['lastName'] ?? '';
//       _mail.text = m['email'] ?? '';
//       _phone.text = m['phone']?.toString() ?? '';
//     });
//   }

//   // ────────── pick image ──────────
//   Future<void> _pickImage() async {
//     final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
//     if (picked == null) return;

//     setState(() {
//       _localImagePath = picked.path; // path on mobile / blob url on web
//       photo = null; // hide old photo
//     });
//     if (kIsWeb) _localImageBytes = await picked.readAsBytes();
//   }

//   // ────────── upload picked image, return filename ──────────
//   Future<String?> _uploadProfileImage() async {
//     if (userId == null || (_localImagePath == null && _localImageBytes == null))
//       return null;

//     final uri = Uri.parse('http://localhost:8000/uplaod/$userId'); // adjust!
//     final req = http.MultipartRequest('PATCH', uri);

//     if (kIsWeb) {
//       req.files.add(http.MultipartFile.fromBytes(
//         'file',
//         _localImageBytes!,
//         filename: 'avatar.png',
//         contentType: MediaType('image', 'png'),
//       ));
//     } else {
//       req.files
//           .add(await http.MultipartFile.fromPath('file', _localImagePath!));
//     }

//     final resp = await req.send();
//     if (resp.statusCode != 200) {
//       debugPrint('❌ image upload failed (${resp.statusCode})');
//       return null;
//     }
//     final body = await resp.stream.bytesToString();
//     // server should return { userImage: "<filename>" }
//     return (jsonDecode(body)['userImage'] as String?);
//   }

//   // ────────── save text fields ──────────
//   Future<void> _saveUserDetails() async {
//     if (userId == null || userId!.isEmpty) return;
//     final uri = Uri.parse('http://localhost:8000/ELACO/updateUser/$userId');

//     final res = await http.patch(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'firstName': _first.text,
//         'lastName': _last.text,
//         'email': _mail.text,
//         'phone': _phone.text,
//       }),
//     );
//     if (res.statusCode != 200) {
//       debugPrint('❌ details update failed: ${res.body}');
//     }
//   }

//   // ────────── avatar provider ──────────
//   ImageProvider? get _avatar {
//     if (_localImagePath != null) {
//       // freshly picked
//       return kIsWeb
//           ? NetworkImage(_localImagePath!)
//           : FileImage(File(_localImagePath!));
//     }
//     if (photo != null && photo!.isNotEmpty) {
//       // from server
//       return CachedNetworkImageProvider('http://localhost:8000/images/$photo');
//     }
//     return null; // placeholder -> icon
//   }

//   // ────────── build ──────────
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: const BackButton(color: Colors.black),
//         title:
//             const Text('Edit Profile', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           TextButton(
//             child: const Text('Save',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                     fontWeight: FontWeight.bold)),
//             onPressed: () async {
//               if (!_formKey.currentState!.validate()) return;

//               // 1) upload image first (may return new filename)
//               final fname = await _uploadProfileImage();
//               if (fname != null) {
//                 setState(() {
//                   photo = fname;
//                   _localImagePath = null;
//                   _localImageBytes = null;
//                 });
//               }

//               // 2) upload text fields
//               await _saveUserDetails();

//               // 3) persist to prefs
//               final prefs = await SharedPreferences.getInstance();
//               await prefs.setString(
//                   'user',
//                   jsonEncode({
//                     '_id': userId,
//                     'firstName': _first.text,
//                     'lastName': _last.text,
//                     'email': _mail.text,
//                     'phone': _phone.text,
//                     'photo': photo ?? '',
//                   }));

//               // if (!mounted) return;
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   content: Text('Profile updated'),
//                   backgroundColor: Color.fromARGB(255, 0, 0, 0)));
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Form(
//           key: _formKey,
//           child: Column(children: [
//             // Avatar
//             // Center(
//             //   child: Stack(children: [
//             //     CircleAvatar(
//             //       radius: 70,
//             //       backgroundColor: Colors.white,
//             //       backgroundImage: _avatar,

//             //       child: _avatar == null
//             //           ? const Icon(Icons.person, size: 70, color: Colors.grey)
//             //           : null,
//             //     ),
//             //     Positioned(
//             //       bottom: 0,
//             //       right: 4,
//             //       child: InkWell(
//             //         onTap: _pickImage,
//             //         child: Container(
//             //           width: 44,
//             //           height: 44,
//             //           decoration: BoxDecoration(
//             //             color: const Color.fromARGB(255, 0, 0, 0),
//             //             shape: BoxShape.circle,
//             //             border: Border.all(color: Colors.white, width: 3),
//             //           ),
//             //           child: const Icon(Icons.camera_alt,
//             //               size: 20, color: Colors.white),
//             //         ),
//             //       ),
//             //     )
//             //   ]),
//             // ),

//             Center(
//               child: Stack(children: [
//                 Container(
//                   width: 140,
//                   height: 140,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                         color: Colors.black, width: 0.75), // 🟩 Black border
//                   ),
//                   child: CircleAvatar(
//                     radius: 70,
//                     backgroundColor: Colors.white,
//                     backgroundImage: _avatar,
//                     child: _avatar == null
//                         ? const Icon(Icons.person, size: 70, color: Colors.grey)
//                         : null,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 4,
//                   child: InkWell(
//                     onTap: _pickImage,
//                     child: Container(
//                       width: 44,
//                       height: 44,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 0, 0, 0),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3),
//                       ),
//                       child: const Icon(Icons.camera_alt,
//                           size: 20, color: Colors.white),
//                     ),
//                   ),
//                 )
//               ]),
//             ),

//             const SizedBox(height: 40),

//             _section('Personal Information'),
//             _field(_first, Icons.person_outline, 'First Name'),
//             const SizedBox(height: 16),
//             _field(_last, Icons.person_outline, 'Last Name'),
//             const SizedBox(height: 30),

//             _section('Contact Details'),
//             _field(_mail, Icons.email_outlined, 'Email Address',
//                 enabled: false),
//             const SizedBox(height: 16),
//             _field(_phone, Icons.phone_outlined, 'Phone Number'),
//             const SizedBox(height: 40),

//             // _section('Account'),
//             // _action(Icons.lock_outline, 'Change Password', () {}),
//             // const SizedBox(height: 16),
//             // _action(Icons.delete_outline, 'Delete Account', () {},
//             //     isDestructive: true),
//           ]),
//         ),
//       ),
//     );
//   }

//   // ────────── helpers ──────────
//   Widget _section(String t) => Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Text(t,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade800)),
//         ),
//       );

//   // Widget _field(TextEditingController c, IconData icn, String label,
//   //         {bool enabled = true}) =>
//   //     Container(
//   //       decoration: BoxDecoration(
//   //           color: enabled ? Colors.white : Colors.white,
//   //           borderRadius: BorderRadius.circular(12),
//   //           border: Border.all(color: Colors.white)),
//   //       child: TextFormField(
//   //         controller: c,
//   //         enabled: enabled,
//   //         decoration: InputDecoration(
//   //             prefixIcon:
//   //                 Icon(icn, color: const Color.fromARGB(255, 255, 255, 255)),
//   //             labelText: label,
//   //             border: InputBorder.none,
//   //             contentPadding:
//   //                 const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
//   //         validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//   //       ),
//   //     );

//   Widget _field(TextEditingController c, IconData icn, String label,
//           {bool enabled = true}) =>
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.black, width: 1),
//           // 🟩 black border
//         ),
//         child: TextFormField(
//           controller: c,
//           enabled: enabled,
//           decoration: InputDecoration(
//             prefixIcon: Icon(icn, color: Colors.black),
//             labelText: label,
//             border: InputBorder.none,
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//           ),
//           validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//         ),
//       );

//   Widget _action(IconData icn, String txt, VoidCallback cb,
//           {bool isDestructive = false}) =>
//       InkWell(
//           onTap: cb,
//           child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200)),
//               child: Row(children: [
//                 const SizedBox(width: 16),
//                 Icon(icn, color: isDestructive ? Colors.red : Colors.black),
//                 const SizedBox(width: 16),
//                 Text(txt,
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: isDestructive ? Colors.red : Colors.black87)),
//                 const Spacer(),
//                 const Icon(Icons.arrow_forward_ios,
//                     size: 16, color: Colors.grey),
//                 const SizedBox(width: 16),
//               ])));
// }
// import 'dart:convert';
// import 'dart:io' show File;
// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:http_parser/http_parser.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage>
//     with TickerProviderStateMixin {
//   // ────────── Animation Controllers ──────────
//   late AnimationController _mainController;
//   late AnimationController _avatarController;
//   late AnimationController _fabController;
  
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _avatarScaleAnimation;
//   late Animation<double> _fabAnimation;

//   // ────────── State Variables ──────────
//   String? userId;
//   String? photo;
//   String? _localImagePath;
//   Uint8List? _localImageBytes;
//   bool _isLoading = false;
//   bool _isSaving = false;

//   final _first = TextEditingController();
//   final _last = TextEditingController();
//   final _mail = TextEditingController();
//   final _phone = TextEditingController();

//   final _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _loadUserData();
//   }

//   void _initializeAnimations() {
//     _mainController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );
//     _avatarController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fabController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _mainController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//       ),
//     );
    
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _mainController,
//       curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
//     ));

//     _avatarScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _avatarController, curve: Curves.elasticOut),
//     );

//     _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fabController, curve: Curves.bounceOut),
//     );

//     _mainController.forward();
//     _avatarController.forward();
//     _fabController.forward();
//   }

//   @override
//   void dispose() {
//     _mainController.dispose();
//     _avatarController.dispose();
//     _fabController.dispose();
//     _scrollController.dispose();
//     _first.dispose();
//     _last.dispose();
//     _mail.dispose();
//     _phone.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserData() async {
//     setState(() => _isLoading = true);
    
//     try {
//       await Future.delayed(const Duration(milliseconds: 300)); // Smooth loading
//       final prefs = await SharedPreferences.getInstance();
//       final raw = prefs.getString('user');
//       if (raw == null) return;
      
//       final m = jsonDecode(raw) as Map<String, dynamic>;
//       setState(() {
//         userId = m['_id'] ?? '';
//         photo = m['photo'] ?? '';
//         _first.text = m['firstName'] ?? '';
//         _last.text = m['lastName'] ?? '';
//         _mail.text = m['email'] ?? '';
//         _phone.text = m['phone']?.toString() ?? '';
//       });
//     } catch (e) {
//       _showSnackBar('Failed to load profile', isError: true);
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _pickImage() async {
//     HapticFeedback.lightImpact();
    
//     final result = await showModalBottomSheet<ImageSource>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => _buildImageSourceBottomSheet(),
//     );

//     if (result == null) return;

//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: result,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 90,
//       );
      
//       if (picked == null) return;

//       setState(() {
//         _localImagePath = picked.path;
//         photo = null;
//       });
      
//       if (kIsWeb) {
//         _localImageBytes = await picked.readAsBytes();
//       }

//       // Animate avatar change
//       _avatarController.reset();
//       _avatarController.forward();
//       HapticFeedback.mediumImpact(); // Fixed: Changed from successfulImpact to mediumImpact
      
//     } catch (e) {
//       _showSnackBar('Failed to select image', isError: true);
//     }
//   }

//   Widget _buildImageSourceBottomSheet() {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(top: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Select Photo',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildImageSourceOption(
//             icon: Icons.photo_library_outlined,
//             title: 'Choose from Gallery',
//             onTap: () => Navigator.pop(context, ImageSource.gallery),
//           ),
//           _buildImageSourceOption(
//             icon: Icons.camera_alt_outlined,
//             title: 'Take Photo',
//             onTap: () => Navigator.pop(context, ImageSource.camera),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageSourceOption({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//         child: Row(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: Colors.blue.shade600),
//             ),
//             const SizedBox(width: 16),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//             const Spacer(),
//             Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String?> _uploadProfileImage() async {
//     if (userId == null || (_localImagePath == null && _localImageBytes == null)) {
//       return null;
//     }

//     try {
//       final uri = Uri.parse('http://localhost:8000/upload/$userId');
//       final req = http.MultipartRequest('PATCH', uri);

//       if (kIsWeb) {
//         req.files.add(http.MultipartFile.fromBytes(
//           'file',
//           _localImageBytes!,
//           filename: 'avatar.png',
//           contentType: MediaType('image', 'png'),
//         ));
//       } else {
//         req.files.add(await http.MultipartFile.fromPath('file', _localImagePath!));
//       }

//       final resp = await req.send();
//       if (resp.statusCode != 200) return null;
      
//       final body = await resp.stream.bytesToString();
//       return (jsonDecode(body)['userImage'] as String?);
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _saveUserDetails() async {
//     if (userId == null || userId!.isEmpty) return;
    
//     final uri = Uri.parse('http://localhost:8000/ELACO/updateUser/$userId');
//     final res = await http.patch(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'firstName': _first.text,
//         'lastName': _last.text,
//         'email': _mail.text,
//         'phone': _phone.text,
//       }),
//     );
    
//     if (res.statusCode != 200) {
//       throw Exception('Update failed');
//     }
//   }

//   ImageProvider? get _avatar {
//     if (_localImagePath != null) {
//       return kIsWeb
//           ? NetworkImage(_localImagePath!)
//           : FileImage(File(_localImagePath!));
//     }
//     if (photo != null && photo!.isNotEmpty) {
//       return CachedNetworkImageProvider('http://localhost:8000/images/$photo');
//     }
//     return null;
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   Future<void> _handleSave() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isSaving = true);
//     HapticFeedback.mediumImpact();

//     try {
//       final fname = await _uploadProfileImage();
//       if (fname != null) {
//         setState(() {
//           photo = fname;
//           _localImagePath = null;
//           _localImageBytes = null;
//         });
//       }

//       await _saveUserDetails();

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//         'user',
//         jsonEncode({
//           '_id': userId,
//           'firstName': _first.text,
//           'lastName': _last.text,
//           'email': _mail.text,
//           'phone': _phone.text,
//           'photo': photo ?? '',
//         }),
//       );

//       HapticFeedback.heavyImpact(); // Fixed: Changed from successfulImpact to heavyImpact
//       _showSnackBar('Profile updated successfully! ✨');
      
//       await Future.delayed(const Duration(milliseconds: 800));
//       if (mounted) Navigator.pop(context);
      
//     } catch (e) {
//       _showSnackBar('Something went wrong', isError: true);
//     } finally {
//       setState(() => _isSaving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: _isLoading ? _buildLoadingState() : _buildMainContent(),
//       floatingActionButton: _buildFloatingActionButton(),
//     );
//   }

//   Widget _buildLoadingState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07ebbd)),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Loading your profile...',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     return CustomScrollView(
//       controller: _scrollController,
//       physics: const BouncingScrollPhysics(),
//       slivers: [
//         _buildSliverAppBar(),
//         SliverToBoxAdapter(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: Column(
//                 children: [
//                   _buildAvatarSection(),
//                   const SizedBox(height: 32),
//                   _buildFormSection(),
//                   const SizedBox(height: 100),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSliverAppBar() {
//     return SliverAppBar(
//       expandedHeight: 120,
//       floating: false,
//       pinned: true,
//       stretch: true,
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       elevation: 0,
//       leading: Container(
//         margin: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, size: 18),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         stretchModes: const [StretchMode.zoomBackground],
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white,
//                 Color(0xFFF8F9FA),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatarSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: ScaleTransition(
//         scale: _avatarScaleAnimation,
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Colors.black,
//                         Color.fromARGB(255, 0, 0, 0),
//                       ],
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color.fromARGB(255, 219, 227, 234).withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(4),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     padding: const EdgeInsets.all(4),
//                     child: CircleAvatar(
//                       radius: 56,
//                       backgroundColor: Colors.grey.shade100,
//                       backgroundImage: _avatar,
//                       child: _avatar == null
//                           ? Icon(
//                               Icons.person_outline,
//                               size: 40,
//                               color: Colors.grey.shade400,
//                             )
//                           : null,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Colors.black,
//                             Color.fromARGB(255, 0, 0, 0),
//                           ],
//                         ),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color.fromARGB(255, 234, 236, 238).withOpacity(0.3),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.camera_alt,
//                         size: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               '${_first.text} ${_last.text}'.trim().isEmpty 
//                   ? 'Your Name' 
//                   : '${_first.text} ${_last.text}',
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               _mail.text.isEmpty ? 'your.email@example.com' : _mail.text,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFormSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Colors.black, Color.fromARGB(255, 0, 9, 7)],
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.edit_outlined,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Personal Information',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               _buildTextField(
//                 controller: _first,
//                 label: 'First Name',
//                 icon: Icons.person_outline,
//                 hint: 'Enter your first name',
//               ),
//               const SizedBox(height: 20),
//               _buildTextField(
//                 controller: _last,
//                 label: 'Last Name',
//                 icon: Icons.person_outline,
//                 hint: 'Enter your last name',
//               ),
//               const SizedBox(height: 20),
//               _buildTextField(
//                 controller: _mail,
//                 label: 'Email Address',
//                 icon: Icons.email_outlined,
//                 hint: 'your.email@example.com',
//                 enabled: false,
//               ),
//               const SizedBox(height: 20),
//               _buildTextField(
//                 controller: _phone,
//                 label: 'Phone Number',
//                 icon: Icons.phone_outlined,
//                 hint: '+1 (555) 123-4567',
//                 keyboardType: TextInputType.phone,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required String hint,
//     bool enabled = true,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           enabled: enabled,
//           keyboardType: keyboardType,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: enabled ? Colors.black87 : Colors.grey.shade500,
//           ),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(
//               color: Colors.grey.shade400,
//               fontWeight: FontWeight.w400,
//             ),
//             prefixIcon: Container(
//               margin: const EdgeInsets.all(12),
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 color: enabled 
//                     ? const Color.fromARGB(255, 0, 0, 0) 
//                     : const Color.fromARGB(255, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Icon(
//                 icon,
//                 size: 16,
//                 color: enabled 
//                     ? const Color.fromARGB(255, 0, 5, 8) 
//                     : const Color.fromARGB(255, 255, 255, 255),
//               ),
//             ),
//             filled: true,
//             fillColor: enabled 
//                 ? Colors.grey.shade50 
//                 : Colors.grey.shade100,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide.none,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Color(0xFF07ebbd),
//                 width: 2,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Colors.red.shade400,
//                 width: 2,
//               ),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: 16,
//               horizontal: 16,
//             ),
//           ),
//           validator: (value) {
//             if (!enabled) return null;
//             if (value == null || value.trim().isEmpty) {
//               return '$label is required';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildFloatingActionButton() {
//     return ScaleTransition(
//       scale: _fabAnimation,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.black,
//               Color.fromARGB(255, 0, 0, 0),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(28),
//           boxShadow: [
//             BoxShadow(
//               color: const Color.fromARGB(255, 251, 252, 252).withOpacity(0.4),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: FloatingActionButton.extended(
//           onPressed: _isSaving ? null : _handleSave,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           label: _isSaving
//               ? const SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.white,
//                   ),
//                 )
//               : const Text(
//                   'Save Changes',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//           icon: _isSaving
//               ? null
//               : const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                 ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io' show File;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http_parser/http_parser.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {
  // ────────── Animation Controllers ──────────
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // ────────── State Variables ──────────
  String? userId;
  String? photo;
  String? _localImagePath;
  Uint8List? _localImageBytes;
  bool _isLoading = false;
  bool _isSaving = false;

  final _first = TextEditingController();
  final _last = TextEditingController();
  final _mail = TextEditingController();
  final _phone = TextEditingController();

  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserData();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _first.dispose();
    _last.dispose();
    _mail.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('user');
      if (raw == null) return;
      
      final m = jsonDecode(raw) as Map<String, dynamic>;
      setState(() {
        userId = m['_id'] ?? '';
        photo = m['photo'] ?? '';
        _first.text = m['firstName'] ?? '';
        _last.text = m['lastName'] ?? '';
        _mail.text = m['email'] ?? '';
        _phone.text = m['phone']?.toString() ?? '';
      });
    } catch (e) {
      _showSnackBar('Failed to load profile', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    HapticFeedback.lightImpact();
    
    final result = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildImageSourceBottomSheet(),
    );

    if (result == null) return;

    try {
      final XFile? picked = await _picker.pickImage(
        source: result,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (picked == null) return;

      setState(() {
        _localImagePath = picked.path;
        photo = null;
      });
      
      if (kIsWeb) {
        _localImageBytes = await picked.readAsBytes();
      }

      HapticFeedback.mediumImpact();
      
    } catch (e) {
      _showSnackBar('Failed to select image', isError: true);
    }
  }

  Widget _buildImageSourceBottomSheet() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Update Photo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose how you\'d like to update your profile picture',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildImageSourceOption(
              icon: Icons.photo_library_rounded,
              title: 'Choose from Gallery',
              color: const Color(0xFF07ebbd),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            const SizedBox(height: 16),
            _buildImageSourceOption(
              icon: Icons.camera_alt_rounded,
              title: 'Take New Photo',
              color: Colors.blue.shade500,
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _uploadProfileImage() async {
    if (userId == null || (_localImagePath == null && _localImageBytes == null)) {
      return null;
    }

    try {
      final uri = Uri.parse('http://localhost:8000/upload/$userId');
      final req = http.MultipartRequest('PATCH', uri);

      if (kIsWeb) {
        req.files.add(http.MultipartFile.fromBytes(
          'file',
          _localImageBytes!,
          filename: 'avatar.png',
          contentType: MediaType('image', 'png'),
        ));
      } else {
        req.files.add(await http.MultipartFile.fromPath('file', _localImagePath!));
      }

      final resp = await req.send();
      if (resp.statusCode != 200) return null;
      
      final body = await resp.stream.bytesToString();
      return (jsonDecode(body)['userImage'] as String?);
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveUserDetails() async {
    if (userId == null || userId!.isEmpty) return;
    
    final uri = Uri.parse('http://localhost:8000/ELACO/updateUser/$userId');
    final res = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': _first.text,
        'lastName': _last.text,
        'email': _mail.text,
        'phone': _phone.text,
      }),
    );
    
    if (res.statusCode != 200) {
      throw Exception('Update failed');
    }
  }

  ImageProvider? get _avatar {
    if (_localImagePath != null) {
      return kIsWeb
          ? NetworkImage(_localImagePath!)
          : FileImage(File(_localImagePath!));
    }
    if (photo != null && photo!.isNotEmpty) {
      return CachedNetworkImageProvider('http://localhost:8000/images/$photo');
    }
    return null;
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade500 : const Color(0xFF07ebbd),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      final fname = await _uploadProfileImage();
      if (fname != null) {
        setState(() {
          photo = fname;
          _localImagePath = null;
          _localImageBytes = null;
        });
      }

      await _saveUserDetails();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'user',
        jsonEncode({
          '_id': userId,
          'firstName': _first.text,
          'lastName': _last.text,
          'email': _mail.text,
          'phone': _phone.text,
          'photo': photo ?? '',
        }),
      );

      HapticFeedback.heavyImpact();
      _showSnackBar('Profile updated successfully! ✨');
      
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) Navigator.pop(context);
      
    } catch (e) {
      _showSnackBar('Something went wrong', isError: true);
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? _buildLoadingState() : _buildMainContent(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF07ebbd),
        strokeWidth: 3,
      ),
    );
  }

  Widget _buildMainContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAvatarSection(),
                const SizedBox(height: 40),
                _buildFormSection(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: _isSaving
              ? Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07ebbd).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF07ebbd),
                      ),
                    ),
                  ),
                )
              : Material(
                  color: const Color(0xFF07ebbd),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: _handleSave,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF07ebbd).withOpacity(0.1),
                      const Color(0xFF07ebbd).withOpacity(0.05),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.grey.shade50,
                  backgroundImage: _avatar,
                  child: _avatar == null
                      ? Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: Colors.grey.shade400,
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF07ebbd),
                          Color(0xFF06d4a7),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF07ebbd).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '${_first.text} ${_last.text}'.trim().isEmpty 
                ? 'Your Name' 
                : '${_first.text} ${_last.text}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _mail.text.isEmpty ? 'your.email@example.com' : _mail.text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildModernTextField(
            controller: _first,
            label: 'First Name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
          _buildModernTextField(
            controller: _last,
            label: 'Last Name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
          _buildModernTextField(
            controller: _mail,
            label: 'Email Address',
            icon: Icons.email_outlined,
            enabled: false,
          ),
          const SizedBox(height: 20),
          _buildModernTextField(
            controller: _phone,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: enabled ? Colors.black87 : Colors.grey.shade500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: enabled 
                  ? const Color(0xFF07ebbd).withOpacity(0.1) 
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: enabled 
                  ? const Color(0xFF07ebbd) 
                  : Colors.grey.shade400,
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF07ebbd),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: (value) {
          if (!enabled) return null;
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }
}