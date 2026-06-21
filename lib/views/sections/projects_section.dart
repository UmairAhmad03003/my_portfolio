import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/portfolio_viewmodel.dart';
import '../../widgets/section_title.dart';
import '../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
          const SectionTitle(title: "My Projects"),
          _buildFilterTabs(viewModel),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.filteredProjects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: isMobile ? 0 : 30,
              mainAxisSpacing: 30,
              childAspectRatio: isMobile ? 0.95 : 0.85,
            ),
            itemBuilder: (context, index) {
              return ProjectCard(project: viewModel.filteredProjects[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(PortfolioViewModel viewModel) {
    final categories = ['All', 'Apps', 'Teaching'];
    return Wrap(
      spacing: 15,
      children: categories.map((category) {
        final isSelected = viewModel.selectedProjectFilter == category;
        return InkWell(
          onTap: () => viewModel.setFilter(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected ? AppColors.primaryAccent : AppColors.cardBorder,
              ),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
