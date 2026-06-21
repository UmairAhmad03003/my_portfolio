import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/portfolio_viewmodel.dart';
import '../../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PortfolioViewModel>();
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
          const SectionTitle(title: "Experience"),
          const SizedBox(height: 20),
          ...viewModel.experiences.map((exp) => _buildExperienceItem(context, exp)),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(BuildContext context, dynamic exp) {
    return Stack(
      children: [
        // The Vertical Line
        Positioned(
          left: 7,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            color: AppColors.primaryAccent.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 3,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.role,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${exp.company} | ${exp.duration}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.secondaryAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      exp.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
