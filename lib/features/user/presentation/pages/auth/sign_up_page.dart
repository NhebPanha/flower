import 'dart:developer';
import 'package:flower/core/utils/app_color.dart';
import 'package:flower/core/utils/app_label/app_label.dart';
import 'package:flower/core/utils/app_notification.dart';
import 'package:flower/features/user/presentation/pages/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Manrope'),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  // Add Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Add UI State variables
  bool _agreeToTerms = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  Future<void> _handleSignUp() async {
    if (_isLoading) return;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // ✅ Validate input
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppNotification.show(
        message: "Please fill in all fields",
        color: Colors.orange,
        icon: Icons.error,
      );
      return;
    }

    if (!_agreeToTerms) {
      AppNotification.show(
        message: "Please agree to the terms",
        color: Colors.orange,
        icon: Icons.error,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // ✅ SIGN UP USER
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name, // optional metadata
        },
      );

      final user = res.user;

      if (user == null) {
        AppNotification.show(
          message: "Signup failed",
          color: Colors.red,
          icon: Icons.error,
        );
        return;
      }

      // ✅ CHECK EMAIL CONFIRMATION
      final isEmailConfirmed = res.session != null;

      if (!isEmailConfirmed) {
        AppNotification.show(
          message: "Account created! Please verify your email.",
          color: Colors.orange,
          icon: Icons.info,
        );
      } else {
        AppNotification.show(
          message: "Account created successfully!",
          color: Colors.green,
          icon: Icons.check_circle,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInPage()),
        );
      }

      // ✅ INSERT PROFILE (SAFE)
      try {
        await supabase.from('users').insert({
          'id': user.id,
          'name': name,
          'email': email,
          'phone': '',
          'address': '',
          'image': '',
        });
      } catch (e) {
        // ⚠️ Prevent crash if already inserted
        log("Profile insert error: $e");
      }

      // ✅ OPTIONAL: Navigate after signup
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => ProfilePage()),
      // );
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
        message: "Something went wrong",
        color: Colors.red,
        icon: Icons.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Decorative backgrounds kept from your original code...
          _buildBackgroundDecor(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildHeroText(),
                  const SizedBox(height: 40),

                  // Form Fields linked to controllers
                  _buildInputField(
                    label: "FULL NAME",
                    hint: "John Doe",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    label: "EMAIL",
                    hint: "example@email.com",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    label: "PASSWORD",
                    hint: "••••••••",
                    isPassword: true,
                    controller: _passwordController,
                  ),

                  const SizedBox(height: 16),
                  _buildTermsCheckbox(),
                  const SizedBox(height: 32),

                  // Functional Button
                  _buildSignUpButton(),

                  const SizedBox(height: 32),
                  _buildLoginLink(),
                  const SizedBox(height: 40),
                  _buildPerksCard(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Sub-Widgets with logic integrated ---
  Widget _buildSignUpButton() {
    return Container(
      width: width * 0.8,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.colorPrimary.withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ElevatedButton(
        // onPressed: _isLoading ? null : _handleSignUp,
        onPressed: () {
          _handleSignUp();
          log("Sign Up button pressed");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.colorPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const AppLabel(
                text: "Create Account",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: AppColor.colorOnSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFA9A9D7)),
            filled: true,
            fillColor: AppColor.colorContainerHigh.withOpacity(0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColor.colorPrimary,
                width: 2,
              ),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: AppColor.colorOnSurfaceVariant,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  // Rest of your UI widgets: _buildHeader, _buildHeroText, etc., stay mostly the same

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          activeColor: AppColor.colorPrimary,
          onChanged: (val) => setState(() => _agreeToTerms = val!),
        ),
        const Expanded(
          child: AppLabel(
            text: "I agree to the Terms of Service and Privacy Policy.",
            fontSize: 14,
            color: AppColor.colorOnSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundDecor() {
    return Stack(
      children: [
        Positioned(
          top: -40,
          right: -40,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.colorSecondaryContainer.withValues(alpha: 0.4),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: Container(
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.colorPrimary.withValues(alpha: 0.05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: .5),
            ),
          ),
          const AppLabel(
            text: "STEP 01 / 02",
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: AppColor.colorPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: AppColor.colorOnSurface,
              letterSpacing: -1.5,
              height: 1.1,
            ),
            children: [
              TextSpan(text: "Join us "),
              TextSpan(
                text: "today",
                style: TextStyle(
                  color: AppColor.colorPrimary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const AppLabel(
          text: "Enter your details to create an account and start shopping.",
          fontSize: 17,
          color: AppColor.colorOnSurfaceVariant,
          height: 1.5,
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLabel(
            text: "Already have an account? ",
            color: AppColor.colorOnSurfaceVariant,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignInPage()),
              );
            }, // Typically goes back to Login
            child: const AppLabel(
              text: "Log in",
              color: AppColor.colorPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerksCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.waves, color: AppColor.colorPrimary),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLabel(
                  text: "MEMBER PERKS",
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppColor.colorOnSurfaceVariant,
                ),
                AppLabel(
                  text: "Early access to limited drops.",
                  fontSize: 12,
                  color: AppColor.colorOnSurfaceVariant,
                ),
              ],
            ),
          ),
          Icon(Icons.stars, color: Colors.orange),
        ],
      ),
    );
  }
}
