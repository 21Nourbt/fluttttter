// import 'package:flutter/material.dart';

// class MainLayout extends StatefulWidget {
//   final Widget child;
//   final int currentIndex;

//   const MainLayout({
//     required this.child,
//     required this.currentIndex,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MainLayoutState createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   void _onTabTapped(int index) {
//     switch (index) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/home');
//         break;
//       case 1:
//         Navigator.pushReplacementNamed(context, '/schedule');
//         break;
//       case 2:
//         Navigator.pushReplacementNamed(context, '/dashboard');
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context, '/profile');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB), // Optional: light background
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: widget.currentIndex,
//         onTap: _onTabTapped,
//         backgroundColor: Colors.white, // ✅ Make navbar visible
//         selectedItemColor: const Color(0xFF1ECCC2), // ✅ Teal for active item
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         elevation: 10, // ✅ Adds subtle shadow to make it visible
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  const MainLayout({
    required this.child,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    
    // Setup bounce animation for tab selection
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void didUpdateWidget(MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != _previousIndex) {
      _previousIndex = widget.currentIndex;
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (widget.currentIndex == index) return; // Don't navigate if already on this tab
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/reserveMeetingRoom');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // Main content
          widget.child,
          
          // Notification indicator (only shown when there are notifications)
          if (widget.currentIndex != 2) // Don't show on notifications page
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 20,
              child: _buildNotificationButton(),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: widget.currentIndex,
            onTap: _onTabTapped,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF1ECCC2),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(1, Icons.schedule_outlined, Icons.schedule, 'Reserve'),
              _buildNavItem(2, Icons.notifications_outlined, Icons.notifications, 'Notifications'),
              _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, IconData regularIcon, IconData solidIcon, String label) {
    return BottomNavigationBarItem(
      icon: widget.currentIndex == index
          ? ScaleTransition(
              scale: _bounceAnimation,
              child: Icon(solidIcon),
            )
          : Icon(regularIcon),
      label: label,
    );
  }

  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/notifications'),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications_outlined,
              size: 26,
              color: Color(0xFF1ECCC2),
            ),
            // Notification badge - when there are notifications
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}