import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/section_title.dart';

class YoutubeSection extends StatelessWidget {
  const YoutubeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "YouTube Channel"),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 50),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.05),
                  blurRadius: 50,
                  spreadRadius: 5,
                )
              ],
            ),
            child: isMobile 
              ? Column(
                  children: _buildContent(context, isMobile: true),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.youtube, size: 100, color: Colors.red),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildContent(context, isMobile: false),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, {required bool isMobile}) {
    return [
      Text(
        "CodeFlow Umair",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
      ),
      const SizedBox(height: 10),
      Text(
        "@CodeFlowUmair • 219+ Subscribers",
        style: const TextStyle(color: AppColors.secondaryAccent, fontSize: 18),
      ),
      const SizedBox(height: 20),
      Text(
        "Programming & Technology Knowledge Channel. I share Flutter tutorials, programming tips, and tech content to help developers grow their skills.",
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.6),
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          _buildStat("219+", "Subscribers"),
          _buildDivider(),
          _buildStat("Programming", "Tech"),
          _buildDivider(),
          _buildStat("Flutter", "Tutorials"),
        ],
      ),
      const SizedBox(height: 40),
      ElevatedButton.icon(
        onPressed: () => _launchURL('https://www.youtube.com/@CodeFlowUmair'),
        icon: const Icon(FontAwesomeIcons.youtube),
        label: const Text("Visit Channel"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ];
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.cardBorder,
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
