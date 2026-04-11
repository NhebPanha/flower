import 'dart:developer';
import 'package:flower/core/utils/app_color.dart';
import 'package:flower/core/utils/app_label/app_label.dart';
import 'package:flower/core/utils/app_notification.dart';
import 'package:flower/features/user/presentation/pages/auth/profile_page.dart';
import 'package:flower/features/user/presentation/pages/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controllers to capture input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // UI State variables
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (isLoading) return; // 🚀 prevent spam click

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    log("Email: $email");
    log("Password: $password");

    // ✅ Validation
    if (email.isEmpty || password.isEmpty) {
      AppNotification.show(
        message: "Please fill in all fields",
        color: Colors.orange,
        icon: Icons.error,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // ✅ LOGIN
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        AppNotification.show(
          message: "Invalid email or password",
          color: Colors.red,
          icon: Icons.error,
        );
        return;
      }

      // ✅ CHECK EMAIL VERIFIED (IMPORTANT)
      if (user.emailConfirmedAt == null) {
        AppNotification.show(
          message: "Please verify your email first",
          color: Colors.orange,
          icon: Icons.warning,
        );

        await supabase.auth.signOut();
        return;
      }

      // ✅ FETCH PROFILE
      final profile = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      // ✅ IF PROFILE NOT FOUND → CREATE ONE (AUTO FIX)
      if (profile == null) {
        log("Profile not found → creating new profile");

        await supabase.from('users').insert({
          'id': user.id,
          'name': user.userMetadata?['name'] ?? '',
          'email': user.email,
          'phone': '',
          'address': '',
          'image': '',
        });
      }

      // ✅ SUCCESS
      AppNotification.show(
        message: "Login Successful!",
        color: Colors.green,
        icon: Icons.check_circle,
      );

      // ✅ NAVIGATE
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage()),
      );
    } on AuthException catch (e) {
      log("Auth error: ${e.message}");

      AppNotification.show(
        message: e.message,
        color: Colors.red,
        icon: Icons.error,
      );
    } catch (e) {
      log("Unexpected error: $e");

      AppNotification.show(
        message: "Something went wrong. Try again.",
        color: Colors.red,
        icon: Icons.error,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorBackground,
      body: Stack(
        children: [
          // Background Decorative Blur
          Positioned(
            top: 100,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.colorPrimary.withValues(alpha: .1),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  const AppLabel(
                    text: "Welcome Back",
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2A2B51),
                    letterSpacing: -1,
                  ),
                  const AppLabel(
                    text: "THE KINETIC CURATOR • ENTRY",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppColor.colorOnSurfaceVariant,
                  ),
                  const SizedBox(height: 40),

                  // Login Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColor.colorSurface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF2A2B51,
                          ).withValues(alpha: 0.06),
                          blurRadius: 80,
                          offset: const Offset(0, 40),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("EMAIL ADDRESS"),
                        _buildTextField(
                          controller: emailController,
                          hint: "name@example.com",
                          isPassword: false,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLabel("PASSWORD"),
                            TextButton(
                              onPressed: () {}, // Implement Forgot Password
                              child: const AppLabel(
                                text: "Forgot?",
                                color: AppColor.colorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        _buildTextField(
                          controller: passwordController,
                          hint: "••••••••",
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),

                        // Sign In Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0049E6), Color(0xFF829BFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.colorPrimary.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              signIn();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const AppLabel(
                                    text: "Sign In",
                                    color: AppColor.background,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                        ),

                        SizedBox(height: 32),
                        _buildDivider(),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildSocialButton("Google")),
                            SizedBox(width: 16),
                            Expanded(child: _buildSocialButton("Apple")),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppLabel(text: "New to the gallery? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                        child: AppLabel(
                          text: "Create an account",
                          color: AppColor.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return AppLabel(
      text: text,
      fontSize: 10,
      fontWeight: FontWeight.w900,
      color: const Color(0xFF575881),
      letterSpacing: 0.5,
    );
  }

  // Updated to use real Controllers and Visibility Toggling
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isPassword,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscurePassword : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFE1DFFF).withValues(alpha: 0.3),
        hintStyle: const TextStyle(color: Color(0xFF73739E)),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0049E6), width: 2),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => obscurePassword = !obscurePassword),
              )
            : null,
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(color: const Color(0xFF73739E).withValues(alpha: 0.2)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "OR CONTINUE WITH",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF73739E),
            ),
          ),
        ),
        Expanded(
          child: Divider(color: const Color(0xFF73739E).withValues(alpha: 0.2)),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String label) {
    return InkWell(
      onTap: () {
        // Implement OAuth (Google/Apple) here
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF2EFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
