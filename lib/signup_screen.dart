import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool _isLoading = false;
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/ELACO/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": _firstNameController.text.trim(),
          "lastName": _lastNameController.text.trim(),
          "email": _emailController.text.trim(),
          "phone": _phoneController.text.trim(),
          "password": _passwordController.text,
          "passwordConfirm": _confirmPasswordController.text,
        }),
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final user = result['data']?['user'];
        final token = result['data']?['token'];
        print(user);
        print(token);

        if (user != null && token != null) {
          // ✅ Securely store the token
          await secureStorage.write(key: 'token', value: token);

          // Optionally store user ID in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', jsonEncode(user));

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showError('Unexpected server response.');
        }

        // Navigator.push('/home');
        Navigator.pushNamed(context, '/home');
      } else {
        final data = jsonDecode(response.body);
        _showError(data["message"] ?? "Signup failed");
      }
    } catch (e) {
      _showError("An error occurred. Please try again.");
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF0F4F8), Color(0xFFEAFBF2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.white.withOpacity(0.5)),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Create Account",
                                  style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  )),
                              const SizedBox(height: 8),
                              Text("Join our coworking community",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // First Name & Last Name side by side
                        Row(
                          children: [
                            Expanded(
                              child: _glassTextField(
                                controller: _firstNameController,
                                icon: Icons.person,
                                hint: 'First Name',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _glassTextField(
                                controller: _lastNameController,
                                icon: Icons.person,
                                hint: 'Last Name',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        _glassTextField(
                            controller: _emailController,
                            icon: Icons.email,
                            hint: 'Email Address',
                            isEmail: true),
                        const SizedBox(height: 16),
                        _glassTextField(
                            controller: _phoneController,
                            icon: Icons.phone,
                            hint: 'Phone Number'),
                        const SizedBox(height: 16),
                        _glassTextField(
                            controller: _passwordController,
                            icon: Icons.lock,
                            hint: 'Password',
                            obscure: true),
                        const SizedBox(height: 16),
                        _glassTextField(
                            controller: _confirmPasswordController,
                            icon: Icons.lock_outline,
                            hint: 'Confirm Password',
                            obscure: true,
                            isConfirm: true),

                        const SizedBox(height: 30),
                        _gradientButton(
                            _isLoading ? "Signing Up..." : "Sign Up",
                            onTap: _isLoading ? null : _signup),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            const Expanded(
                                child: Divider(
                                    thickness: 1, color: Colors.black26)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("or",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black45,
                                    fontSize: 13,
                                  )),
                            ),
                            const Expanded(
                                child: Divider(
                                    thickness: 1, color: Colors.black26)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        GestureDetector(
                          onTap: () {
                            // Handle Google sign up
                          },
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png',
                                    height: 24, width: 24),
                                const SizedBox(width: 12),
                                Text("Sign Up with Google",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    )),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: Colors.black54)),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Sign In",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: const Color(0xFF00CED1),
                                    fontWeight: FontWeight.w500,
                                  )),
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
        ],
      ),
    );
  }

  Widget _glassTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    bool isEmail = false,
    bool isConfirm = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.poppins(color: Colors.black87, fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: Icon(icon, color: Colors.grey[700], size: 20),
              hintText: hint,
              hintStyle:
                  GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              if (isEmail && !value.contains('@')) return 'Enter valid email';
              if (isConfirm && value != _passwordController.text)
                return 'Passwords do not match';
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _gradientButton(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient:
              const LinearGradient(colors: [Colors.black, Color(0xFF00CED1)]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}
