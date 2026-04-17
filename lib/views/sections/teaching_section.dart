import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/section_title.dart';

class TeachingSection extends StatelessWidget {
  const TeachingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "Teaching"),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 40),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryAccent.withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school, color: AppColors.secondaryAccent, size: 32),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Flutter Instructor",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            "Infusible Coder",
                            style: TextStyle(fontSize: 18, color: AppColors.secondaryAccent, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Teaching Flutter development at Infusible Coder, helping students build real-world cross-platform mobile applications with Flutter & Dart. My curriculum focuses on industry-standard practices, state management, and production-ready architecture.",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Topics Taught:",
                  style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: ["Flutter", "Dart", "Firebase", "State Management", "UI/UX", "REST APIs"].map((topic) {
                    return Chip(
                      label: Text(topic),
                      backgroundColor: AppColors.primaryAccent.withOpacity(0.1),
                      labelStyle: const TextStyle(color: AppColors.secondaryAccent),
                      side: BorderSide(color: AppColors.primaryAccent.withOpacity(0.3)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
