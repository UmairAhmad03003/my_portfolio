import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../viewmodels/scroll_viewmodel.dart';
import '../widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/youtube_section.dart';
import 'sections/teaching_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final scrollViewModel = context.watch<ScrollViewModel>();
    
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePos = event.localPosition;
          });
        },
        child: Stack(
          children: [
            // Cursor Glow Effect
            Positioned(
              left: _mousePos.dx - 150,
              top: _mousePos.dy - 150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryAccent.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              controller: scrollViewModel.scrollController,
              child: Column(
                children: [
                  HeroSection(key: scrollViewModel.sectionKeys['Hero']),
                  AboutSection(key: scrollViewModel.sectionKeys['About']),
                  SkillsSection(key: scrollViewModel.sectionKeys['Skills']),
                  ProjectsSection(key: scrollViewModel.sectionKeys['Projects']),
                  ExperienceSection(key: scrollViewModel.sectionKeys['Experience']),
                  YoutubeSection(key: scrollViewModel.sectionKeys['YouTube']),
                  TeachingSection(key: scrollViewModel.sectionKeys['Teaching']),
                  ContactSection(key: scrollViewModel.sectionKeys['Contact']),
                  const FooterSection(),
                ],
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Navbar(),
            ),
          ],
        ),
      ),
    );
  }
}
