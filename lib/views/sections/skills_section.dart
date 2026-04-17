import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/portfolio_viewmodel.dart';
import '../../widgets/section_title.dart';
import '../../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PortfolioViewModel>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1200;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "My Skills"),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              return SkillCard(skill: viewModel.skills[index]);
            },
          ),
        ],
      ),
    );
  }
}
