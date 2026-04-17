import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/scroll_viewmodel.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: isMobile
          ? SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120),
                    _buildProfileImage(),
                    const SizedBox(height: 40),
                    _buildHeroContent(context, isMobile, isDark),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            )
          : Row(
              children: [
                Expanded(child: _buildHeroContent(context, isMobile, isDark)),
                Expanded(child: _buildProfileImage()),
              ],
            ),
    );
  }

  Widget _buildHeroContent(BuildContext context, bool isMobile, bool isDark) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, I'm",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.secondaryAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Umair Ahmad",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : AppColors.textPrimaryLight,
                ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.secondaryAccent,
                fontWeight: FontWeight.w500,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('Flutter Developer'),
                  TypewriterAnimatedText('Content Creator'),
                  TypewriterAnimatedText('Educator'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "I build high-performance, beautiful, and responsive mobile and web applications using Flutter with 2.5 years of industry experience.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  color: isDark ? AppColors.textSecondary : AppColors.textSecondaryLight,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              _buildPrimaryButton(context, "Contact Me", () {
                context.read<ScrollViewModel>().scrollToSection('Contact');
              }),
              _buildSecondaryButton(context, "Get Portfolio Source", () {
                _launchURL('https://github.com/UmairAhmad03003/my_portfolio');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative background circles
            Container(
              height: 420,
              width: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryAccent.withOpacity(0.2), width: 2),
              ),
            ),
            Container(
              height: 380,
              width: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.secondaryAccent.withOpacity(0.4), width: 1),
              ),
            ),
            // Main Image Container
            Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryAccent, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.5),
                    blurRadius: 60,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryAccent,
        side: const BorderSide(color: AppColors.primaryAccent, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
