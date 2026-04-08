import 'package:flower/core/utils/app_color.dart';
import 'package:flower/core/utils/app_fontsize.dart';
import 'package:flower/core/utils/app_label/app_label.dart';
import 'package:flower/features/user/presentation/pages/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlashScreen extends StatefulWidget {
  const PlashScreen({super.key});

  @override
  State<PlashScreen> createState() => _PlashScreenState();
}

class _PlashScreenState extends State<PlashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- BACKGROUND IMAGE ---
          Positioned.fill(
            child: Image.network(
              'https://www.shutterstock.com/image-photo/happy-celebrating-cute-asian-woman-600nw-2630239977.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // --- GRADIENT OVERLAY ---
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.transparent,
                    AppColor.surface.withValues(alpha: .4),
                    AppColor.surface,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // --- TOP NAVIGATION/HEADER ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EST. 2024 / KINETIC STUDIO',
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.0,
                    color: AppColor.onSurfaceVariant,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColor.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(Icons.language, color: AppColor.primaryColor),
                ),
              ],
            ),
          ),

          // --- MAIN CONTENT ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                AppLabel(
                  text: 'KINETIC',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: AppColor.primaryColor,
                    letterSpacing: -4,
                  ),
                ),
                SizedBox(height: 8),
                // SUBTITLE
                SizedBox(
                  width: 400,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2a2b51),
                        height: 1.1,
                      ),
                      children: [
                        TextSpan(text: 'Curation for the '),
                        TextSpan(
                          text: 'Modern',
                          style: GoogleFonts.plusJakartaSans(
                            fontStyle: FontStyle.italic,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        TextSpan(text: ' Motion.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // DASHED INDICATOR
                Row(
                  children: [
                    Container(
                      height: 4,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 4,
                      width: 16,
                      decoration: BoxDecoration(
                        color: AppColor.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 4,
                      width: 16,
                      decoration: BoxDecoration(
                        color: AppColor.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // CTA AND USERS
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // GET STARTED BUTTON
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignInPage()),
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: AppColor.primaryColor.withValues(
                              alpha: .3,
                            ),
                            elevation: 10,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ).copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              AppColor.primaryColor,
                            ),
                          ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.secondaryColor,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppLabel(
                              text: 'Get Started',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),

                    // USER AVATARS
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAvatar(
                          'https://img.freepik.com/free-photo/asian-happy-female-woman-girl-holds-colourful-shopping-packages-standing-yellow-background-studio-shot-close-up-portrait-young-beautiful-attractive-girl-smiling-looking-camera-with-bags_609648-3029.jpg',
                        ),
                        Transform.translate(
                          offset: const Offset(-12, 0),
                          child: _buildAvatar(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg9hVRK3CAaELPQzZ3aLl7lChgn2o1M9UAVQ&s',
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(-24, 0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFF829bff),
                            backgroundImage: NetworkImage(
                              'https://www.shutterstock.com/image-photo/happy-celebrating-cute-asian-woman-600nw-2630239977.jpg',
                            ),
                            child: AppLabel(
                              text: '+12k',
                              style: GoogleFonts.manrope(
                                fontSize: AppFontsize.h12,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppLabel(
                          text: 'JOINED THE CURATION',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.onSurfaceVariant,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // --- FLOATING HELP ICON ---
          Positioned(
            bottom: 32,
            right: 32,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.colorSurface.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.colorOnSurfaceVariant.withValues(alpha: 0.05),
                ),
              ),
              child: Icon(Icons.help_outline, color: AppColor.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.colorSurface, width: 2),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
