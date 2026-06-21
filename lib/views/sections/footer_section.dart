import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Designed & Built by Umair Ahmad",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/UmairAhmad03003'),
              _buildSocialIcon(FontAwesomeIcons.youtube, 'https://youtube.com/@CodeFlowUmair'),
              _buildSocialIcon(FontAwesomeIcons.whatsapp, 'https://wa.me/923003393940'),
              _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com'), // Generic
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Copyright © ${DateTime.now().year} Umair Ahmad. All rights reserved.",
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, size: 20),
      color: AppColors.textSecondary,
      hoverColor: AppColors.secondaryAccent,
      onPressed: () => _launchURL(url),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
