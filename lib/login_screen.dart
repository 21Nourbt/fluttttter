// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   String emailError = '';
//   String passwordError = '';
//   String generalError = '';
//   bool isLoading = false;

//   Future<void> login() async {
//     setState(() {
//       emailError = '';
//       passwordError = '';
//       generalError = '';
//       isLoading = true;
//     });

//     final email = emailController.text.trim();
//     final password = passwordController.text;

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:8000/ELACO/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);
//         final userId = result['data']?['user']?['_id'];

//         // if (userId != null) {
//         //   Navigator.pushReplacementNamed(context, '/home');
//         // }
//         if (userId != null) {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('id', userId); // ✅ Save userId

//   Navigator.pushReplacementNamed(context, '/home');
// }

//          else {
//           setState(() {
//             generalError = 'Unexpected server response.';
//           });
//         }
//       } else {
//         final result = jsonDecode(response.body);
//         setState(() {
//           final message = result['message']?.toString().toLowerCase() ?? '';
//           if (message.contains('email')) {
//             emailError = 'Invalid email address.';
//           } else if (message.contains('password')) {
//             passwordError = 'Incorrect password.';
//           } else {
//             generalError = result['message'] ?? 'Login failed. Please try again.';
//           }
//         });
//       }
//     } catch (e) {
//       setState(() {
//         generalError = 'Network error. Please try again.';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFF7FBFD), Color(0xFFEAFBF2), Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 28),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 20),
//                     Text("Welcome Back!",
//                         style: GoogleFonts.poppins(
//                             fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black87)),
//                     const SizedBox(height: 8),
//                     Text("Please sign in to your account",
//                         style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
//                     const SizedBox(height: 40),

//                     _glassTextField(
//                       icon: Icons.email_outlined,
//                       hint: 'Email Address',
//                       controller: emailController,
//                       error: emailError,
//                     ),
//                     const SizedBox(height: 16),
//                     _glassTextField(
//                       icon: Icons.lock_outline,
//                       hint: 'Password',
//                       obscure: true,
//                       controller: passwordController,
//                       error: passwordError,
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text("Forgot Password?",
//                             style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87)),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     GestureDetector(
//                       onTap: isLoading ? null : login,
//                       child: Container(
//                         width: double.infinity,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Colors.black, Color(0xFF00CED1)],
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 15,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         alignment: Alignment.center,
//                         child: isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : Text("Sign In",
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                     color: Colors.white)),
//                       ),
//                     ),

//                     if (generalError.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: Text(generalError,
//                             style: GoogleFonts.poppins(color: Colors.red, fontSize: 13)),
//                       ),
//                     const SizedBox(height: 25),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Don't have an Account?",
//                             style: GoogleFonts.poppins(color: Colors.black54, fontSize: 13)),
//                         TextButton(
//                           onPressed: () => Navigator.pushNamed(context, '/signup'),
//                           child: Text("Sign Up",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13,
//                                   color: const Color(0xFF00CED1),
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _glassTextField({
//     required IconData icon,
//     required String hint,
//     required TextEditingController controller,
//     bool obscure = false,
//     String? error,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: controller,
//           obscureText: obscure,
//           style: const TextStyle(color: Colors.black87),
//           decoration: InputDecoration(
//             prefixIcon: Icon(icon, color: Colors.black54),
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.black45, fontSize: 14),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.9),
//             contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none,
//             ),
//             errorText: error?.isNotEmpty == true ? error : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//   String emailError = '';
//   String passwordError = '';
//   String generalError = '';
//   bool isLoading = false;

//   Future<void> login() async {
//     setState(() {
//       emailError = '';
//       passwordError = '';
//       generalError = '';
//       isLoading = true;
//     });

//     final email = emailController.text.trim();
//     final password = passwordController.text;

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:8000/ELACO/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       final result = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         final user = result['data']?['user'];
//         final token = result['data']?['token'];
//         print(user);
//         print(token);

//         if (user != null && token != null) {
//           // ✅ Securely store the token
//           await secureStorage.write(key: 'token', value: token);

//           // Optionally store user ID in shared preferences
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('user', jsonEncode(user));

//           Navigator.pushReplacementNamed(context, '/home');
//         } else {
//           setState(() {
//             generalError = 'Unexpected server response.';
//           });
//         }
//       } else {
//         final message = result['message']?.toString().toLowerCase() ?? '';
//         setState(() {
//           if (message.contains('email')) {
//             emailError = 'Invalid email address.';
//           } else if (message.contains('password')) {
//             passwordError = 'Incorrect password.';
//           } else {
//             generalError = result['message'] ?? 'Login failed. Please try again.';
//           }
//         });
//       }
//     } catch (e) {
//         print('Error caught: $e');

//       setState(() {
//         generalError = 'Network error. Please try again.';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255), Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 28),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 20),
//                     Text("Welcome Back!",
//                         style: GoogleFonts.poppins(
//                             fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black87)),
//                     const SizedBox(height: 8),
//                     Text("Please sign in to your account",
//                         style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
//                     const SizedBox(height: 40),
//                     _glassTextField(
//                       icon: Icons.email_outlined,
//                       hint: 'Email Address',
//                       controller: emailController,
//                       error: emailError,
//                     ),
//                     const SizedBox(height: 16),
//                     _glassTextField(
//                       icon: Icons.lock_outline,
//                       hint: 'Password',
//                       obscure: true,
//                       controller: passwordController,
//                       error: passwordError,
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text("Forgot Password?",
//                             style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87)),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: isLoading ? null : login,
//                       child: Container(
//                         width: double.infinity,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Colors.black, Color(0xFF00CED1)],
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 15,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         alignment: Alignment.center,
//                         child: isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : Text("Sign In",
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                     color: Colors.white)),
//                       ),
//                     ),
//                     if (generalError.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: Text(generalError,
//                             style: GoogleFonts.poppins(color: Colors.red, fontSize: 13)),
//                       ),
//                     const SizedBox(height: 25),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Don't have an Account?",
//                             style: GoogleFonts.poppins(color: Colors.black54, fontSize: 13)),
//                         TextButton(
//                           onPressed: () => Navigator.pushNamed(context, '/signup'),
//                           child: Text("Sign Up",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13,
//                                   color: const Color(0xFF00CED1),
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _glassTextField({
//     required IconData icon,
//     required String hint,
//     required TextEditingController controller,
//     bool obscure = false,
//     String? error,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: controller,
//           obscureText: obscure,
//           style: const TextStyle(color: Colors.black87),
//           decoration: InputDecoration(
//             prefixIcon: Icon(icon, color: Colors.black54),
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.black45, fontSize: 14),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.9),
//             contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none,
//             ),
//             errorText: error?.isNotEmpty == true ? error : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String emailError = '';
  String passwordError = '';
  String generalError = '';
  bool isLoading = false;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      emailError = '';
      passwordError = '';
      generalError = '';
    });

    // Validate input fields
    bool hasError = false;
    if (email.isEmpty) {
      setState(() => emailError = 'Email is required');
      hasError = true;
    }
    if (password.isEmpty) {
      setState(() => passwordError = 'Password is required');
      hasError = true;
    }
    if (hasError) return;

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/ELACO/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = result['data']?['user'];
        final token = result['data']?['token'];

        if (user != null && token != null) {
          await secureStorage.write(key: 'token', value: token);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', jsonEncode(user));
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          setState(() => generalError = 'Unexpected server response.');
        }
      } else {
        final message = result['message']?.toString().toLowerCase() ?? '';
        setState(() {
          if (message.contains('email')) {
            emailError = 'Invalid email address.';
          } else if (message.contains('password')) {
            passwordError = 'Incorrect password.';
          } else {
            generalError = result['message'] ?? 'Login failed. Please try again.';
          }
        });
      }
    } catch (e) {
      setState(() => generalError = 'Network error. Please try again.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text("Welcome Back!",
                        style: GoogleFonts.poppins(
                            fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black87)),
                    const SizedBox(height: 8),
                    Text("Please sign in to your account",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
                    const SizedBox(height: 40),
                    _customTextField(
                      icon: Icons.email_outlined,
                      hint: 'Email Address',
                      controller: emailController,
                      error: emailError,
                    ),
                    const SizedBox(height: 16),
                    _customTextField(
                      icon: Icons.lock_outline,
                      hint: 'Password',
                      obscure: true,
                      controller: passwordController,
                      error: passwordError,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Forgot Password?",
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: isLoading ? null : login,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.black, Color(0xFF00CED1)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text("Sign In",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white)),
                      ),
                    ),
                    if (generalError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(generalError,
                            style: GoogleFonts.poppins(color: Colors.red, fontSize: 13)),
                      ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account?",
                            style: GoogleFonts.poppins(color: Colors.black54, fontSize: 13)),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/signup'),
                          child: Text("Sign Up",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF00CED1),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 0.1),
            color: Colors.white.withOpacity(0.9),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.black54),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black45, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              border: InputBorder.none,
            ),
          ),
        ),
        if (error != null && error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 8.0),
            child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }
}
