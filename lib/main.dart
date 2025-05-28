
import 'package:flutter/material.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:flutter_application_1/reservations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ──────────────── screens & pages ────────────────
import 'package:flutter_application_1/welcome_screen.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/signup_screen.dart';
import 'package:flutter_application_1/edit_profile_page.dart';
import 'package:flutter_application_1/main_layout.dart';
import 'package:flutter_application_1/coworking_home.dart';
import 'package:flutter_application_1/listoftables.dart';
import 'package:flutter_application_1/chatScreen.dart';
import 'package:flutter_application_1/FloorSVG.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter_application_1/success_payment_page.dart';
import 'package:flutter_application_1/failPaymentPage.dart';
import 'package:flutter_application_1/screens/points_success_page.dart';
import 'package:flutter_application_1/OfficeRoom_details_screen.dart'; // for /course-detail1
import 'package:flutter_application_1/room_details_screen.dart';      // for /course-detail
import 'package:flutter_application_1/screens/table_payment_success_page.dart'; // for /payment

// ──────────────── global navigator key ────────────────
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // Allows Konnect to redirect to hash URLs like #/success, #/fail, #/payment…
  setUrlStrategy(const HashUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Static routes with no query parameters
  static final Map<String, WidgetBuilder> _staticRoutes = {
    '/':                   (_) => const WelcomeScreen(),
    '/login':              (_) => const LoginScreen(),
    '/signup':             (_) => const SignupScreen(),
    '/edit':               (_) => MainLayout(child: const EditProfilePage(), currentIndex: 0),
    '/home':               (_) => MainLayout(child: const CoworkingApp(), currentIndex: 0),
    '/reserveMeetingRoom': (_) => MainLayout(child: const CategoryRoomList(), currentIndex: 0),
    '/assistant':          (_) => const ChatScreen(),
    '/openspace':          (_) => MainLayout(child: const CategoryRoomList(), currentIndex: 0),
    '/profile':            (_) => MainLayout(child: const ProfileScreen(), currentIndex: 3),
    '/notifications': (_) => MainLayout(child: const NotificationsScreen(), currentIndex: 2),
    '/booking-history': (_) => MainLayout(child: const ReservationTableScreen(), currentIndex: 1),


  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'abda.',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/',
      routes: _staticRoutes,
      onGenerateRoute: (RouteSettings settings) {
        final uri = Uri.parse(settings.name ?? '');

        // A. Points payment success (add points flow)
        if (uri.path == '/points/verify') {
          final status     = uri.queryParameters['status'];
          final paymentRef = uri.queryParameters['payment_ref'];
          final userId     = uri.queryParameters['userId'];
          final points     = uri.queryParameters['points'];

          if (status == 'success') {
            return MaterialPageRoute(
              builder: (_) => PointsSuccessPage(
                paymentId: paymentRef,
                userId: userId,
                points: points,
              ),
              settings: settings,
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const FailPaymentPage(),
              settings: settings,
            );
          }
        }

        // B. Subscription payment success
        if (uri.path == '/success') {
          final ref       = uri.queryParameters['payment_ref'];
          final subId     = uri.queryParameters['subId'];
          final startDate = uri.queryParameters['start_date'];
          final endDate   = uri.queryParameters['end_date'];

          return MaterialPageRoute(
            builder: (_) => SuccessPaymentPage(
              paymentRef: ref,
              subId: subId,
              startDate: startDate,
              endDate: endDate,
            ),
            settings: settings,
          );
        }

        // C. Generic payment failure
        if (uri.path == '/fail') {
          return MaterialPageRoute(
            builder: (_) => const FailPaymentPage(),
            settings: settings,
          );
        }

        // D. Table payment success (your new route)
        // if (uri.path == '/payment') {
        //   final startTime = uri.queryParameters['start_time'];
        //   final endTime   = uri.queryParameters['end_time'];
        //   final numTable  = uri.queryParameters['numTable'];
        //   final date      = uri.queryParameters['date'];

        //   return MaterialPageRoute(
        //     builder: (_) => TablePaymentSuccessPage(
        //       startTime: startTime,
        //       endTime: endTime,
        //       numTable: numTable,
        //       date: date,
        //     ),
        //     settings: settings,
        //   );
        // }

//         if (uri.path == '/payment') {
//   final startTime = uri.queryParameters['start_time'];
//   final endTime   = uri.queryParameters['end_time'];
//   final numTable  = uri.queryParameters['numTable'];
//   final date      = uri.queryParameters['date'];



//   return MaterialPageRoute(
//     builder: (_) => BookingPaymentSuccessPage(

//       startTime: startTime,
//       endTime: endTime,
//       numTable: numTable,
//       date: date,
//     ),
//     settings: settings,
//   );
// }

if (uri.path == '/payment') {
  final paymentRef = uri.queryParameters['payment_ref'];
  final startTime  = uri.queryParameters['start_time'];
  final endTime    = uri.queryParameters['end_time'];
  final numTable   = uri.queryParameters['numTable'];
  final date       = uri.queryParameters['date'];

  return MaterialPageRoute(
    builder: (_) => BookingPaymentSuccessPage(
      paymentRef: paymentRef,
      startTime:  startTime,
      endTime:    endTime,
      numTable:   numTable,
      date:       date,
    ),
    settings: settings,
  );
}



        // E. Office room reservation screen
        if (uri.path == '/course-detail1') {
          return MaterialPageRoute(
            builder: (ctx) {
              final args = settings.arguments as Map<String, dynamic>?;
              if (args != null) {
                final room = args['room'] as Map<String, dynamic>;
                final reservations =
                    (args['reservations'] as List?)?.cast<Map<String, dynamic>>() ?? [];
                return OfficeRoomReservationScreen(
                  room: room,
                  reservations: reservations,
                );
              }
              return const Scaffold(
                body: Center(child: Text('Error: no office-room data provided')),
              );
            },
            settings: settings,
          );
        }

        // F. Meeting room reservation screen
        if (uri.path == '/course-detail') {
          return MaterialPageRoute(
            builder: (ctx) {
              final args = settings.arguments as Map<String, dynamic>?;
              if (args != null) {
                final room = args['room'] as Map<String, dynamic>;
                final reservations =
                    (args['reservations'] as List?)?.cast<Map<String, dynamic>>() ?? [];
                return ReservationScreen(
                  room: room,
                  reservations: reservations,
                );
              }
              return const Scaffold(
                body: Center(child: Text('Error: no meeting-room data provided')),
              );
            },
            settings: settings,
          );
        }

        // G. Static fallback
        final staticBuilder = _staticRoutes[uri.path];
        if (staticBuilder != null) {
          return MaterialPageRoute(
            builder: staticBuilder,
            settings: settings,
          );
        }

        // H. Not found
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
          settings: settings,
        );
      },
    );
  }
}
