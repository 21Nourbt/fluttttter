import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'sidebar_screen.dart'; // Make sure this is correct

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String nom = '';
  String prenom = '';
  String mail = '';
  String tel = '';
  int points = 0;
  String photo = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const Color primaryBlack = Color(0xFF000000);
  static const Color cardColor = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF767676);

  @override
  void initState() {
    super.initState();
    _loadUserData();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      setState(() {
        nom = userMap['firstName'] ?? '';
        prenom = userMap['lastName'] ?? '';
        mail = userMap['email'] ?? '';
        tel = userMap['phone']?.toString() ?? '';
        points = userMap['points'] ?? 0;
        photo = userMap['photo'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      drawer: SidebarScreen(), // ✅ Sidebar included
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: primaryBlack)),
        iconTheme: const IconThemeData(color: primaryBlack),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Hero(
                        tag: 'profile-avatar',
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            photo.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl:
                                        'http://localhost:8000/images/$photo',
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 60,
                                      backgroundImage: imageProvider,
                                      backgroundColor: cardColor,
                                    ),
                                    placeholder: (context, url) => CircleAvatar(
                                      radius: 60,
                                      backgroundColor: cardColor,
                                      child: const CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      radius: 60,
                                      backgroundColor: cardColor,
                                      child: const Icon(Icons.error),
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 60,
                                    backgroundColor: cardColor,
                                    backgroundImage:
                                        AssetImage('assets/image.png'),
                                  ),
                            Material(
                              elevation: 4,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              color: primaryBlack,
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.camera_alt_outlined,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '$nom $prenom',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryBlack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildQuickStats(),
                    const SizedBox(height: 40),
                    _buildSectionHeader('Personal Information',
                        onEdit: () async {
                      await Navigator.pushNamed(context, '/edit');
                      _loadUserData();
                    }),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                        Icons.person_outline, 'Full Name', '$nom $prenom'),
                    _buildInfoCard(Icons.phone_outlined, 'Phone Number', tel),
                    _buildInfoCard(Icons.email_outlined, 'Email', mail),
                    const SizedBox(height: 40),
                    // _buildLogoutButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem(Icons.calendar_month_outlined, 'Member Since', '2023'),
          _divider(),
          _statItem(
              Icons.workspace_premium_outlined, 'Points', points.toString()),
          _divider(),
          _statItem(Icons.bookmark_border_outlined, 'Bookings', '8'),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF07ebbd)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 40, color: Color(0xFF07ebbd));

  Widget _buildSectionHeader(String title, {required VoidCallback onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFF07ebbd))),
        TextButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined, size: 18,color: Color(0xFF07ebbd)),
label: const Text(
  'Edit',
  style: TextStyle(
    color: Color(0xFF07ebbd),
  ),
),
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryBlack.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryBlack),
        ),
        title: Text(title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, color: textLight)),
        subtitle: Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: textDark)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  // Widget _buildLogoutButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       icon: const Icon(Icons.logout_rounded),
  //       label: const Text('LOGOUT'),
  //       onPressed: () {},
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: primaryBlack,
  //         padding: const EdgeInsets.symmetric(vertical: 16),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       ),
  //     ),
  //   );
  // }
}
