import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 50 : 100),
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "About Me"),
          Responsive(
            mobile: Column(
              children: [
                _buildAboutImage(context),
                const SizedBox(height: 40),
                _buildAboutContent(context),
              ],
            ),
            tablet: Column(
              children: [
                _buildAboutImage(context),
                const SizedBox(height: 60),
                _buildAboutContent(context),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildAboutImage(context)),
                const SizedBox(width: 60),
                Expanded(flex: 2, child: _buildAboutContent(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutImage(BuildContext context) {
    final isSmallMobile = Responsive.isSmallMobile(context);
    final isMobile = Responsive.isMobile(context);
    final imageSize = isSmallMobile ? 250.0 : (isMobile ? 300.0 : 400.0);
    final frameOffset = isSmallMobile ? -10.0 : -15.0;

    return FadeInLeft(
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Decorative background frame
            Positioned(
              right: frameOffset,
              bottom: frameOffset,
              child: Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondaryAccent.withOpacity(0.5), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Main Image Container
            Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.3),
                    blurRadius: 40,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
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

  Widget _buildAboutContent(BuildContext context) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "I am a Flutter Developer with 2.5 years of experience, working on real-world mobile apps. I have a passion for creating seamless user experiences and efficient code. Currently, I'm teaching Flutter at Infusible Coder software house and running my YouTube channel 'CodeFlow Umair' focused on Programming & Technology.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.8,
                ),
          ),
          const SizedBox(height: 40),
          _buildStatGrid(context),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _launchURL('https://raw.githubusercontent.com/UmairAhmad03003/my_portfolio/main/assets/umair_ahmad_cv.pdf'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Download CV', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }

  Widget _buildStatGrid(BuildContext context) {
    final stats = [
      {'label': 'Years Experience', 'value': '2.5+'},
      {'label': 'GitHub Projects', 'value': '4+'},
      {'label': 'YouTube Subscribers', 'value': '219+'},
      {'label': 'Primary Stack', 'value': 'Flutter'},
    ];

    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth < 450 ? 1 : (constraints.maxWidth < 850 ? 2 : 4),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: constraints.maxWidth < 450 ? 2.5 : 1.5,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryAccent.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stats[index]['value']!,
                  style: const TextStyle(
                    color: AppColors.secondaryAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stats[index]['label']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
