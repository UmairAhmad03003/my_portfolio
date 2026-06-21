import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/responsive_helper.dart';
import '../viewmodels/scroll_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollViewModel = context.watch<ScrollViewModel>();
    final themeViewModel = context.watch<ThemeViewModel>();
    final isScrolled = scrollViewModel.isNavbarScrolled;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isMobile ? 70 : 80,
      decoration: BoxDecoration(
        color: isScrolled 
            ? (isDark ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.7)) 
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.cardBorder : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isScrolled ? 10 : 0, sigmaY: isScrolled ? 10 : 0),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isSmallMobile(context) ? 15 : (Responsive.isMobile(context) ? 20 : 50),
            ),
            child: Row(
              children: [
                _buildLogo(context),
                const Spacer(),
                if (!isMobile)
                  _buildNavLinks(context, scrollViewModel)
                else
                  _buildMobileMenu(context, scrollViewModel),
                const SizedBox(width: 10),
                _buildThemeSelector(context, themeViewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final isSmallMobile = Responsive.isSmallMobile(context);
    return Text(
      'UA',
      style: TextStyle(
        fontSize: isSmallMobile ? 24 : 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryAccent,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildNavLinks(BuildContext context, ScrollViewModel scrollViewModel) {
    final links = ['About', 'Skills', 'Projects', 'Experience', 'YouTube', 'Teaching', 'Contact'];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: links.map((link) {
        final isActive = scrollViewModel.activeSection == link;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () => scrollViewModel.scrollToSection(link),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  link,
                  style: TextStyle(
                    color: isActive 
                        ? AppColors.primaryAccent 
                        : (isDark ? AppColors.textPrimary : AppColors.textPrimaryLight),
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 2,
                  width: isActive ? 20 : 0,
                  color: AppColors.primaryAccent,
                  margin: const EdgeInsets.only(top: 4),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThemeSelector(BuildContext context, ThemeViewModel themeViewModel) {
    return PopupMenuButton<ThemeMode>(
      icon: Icon(
        themeViewModel.themeMode == ThemeMode.dark 
            ? Icons.dark_mode 
            : (themeViewModel.themeMode == ThemeMode.light ? Icons.light_mode : Icons.settings_brightness),
        color: AppColors.primaryAccent,
      ),
      onSelected: (ThemeMode mode) => themeViewModel.setThemeMode(mode),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(children: [Icon(Icons.light_mode, size: 20), SizedBox(width: 10), Text('Light')]),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(children: [Icon(Icons.dark_mode, size: 20), SizedBox(width: 10), Text('Dark')]),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(children: [Icon(Icons.settings_brightness, size: 20), SizedBox(width: 10), Text('System')]),
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context, ScrollViewModel scrollViewModel) {
    return IconButton(
      icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (context) => ListView(
            padding: const EdgeInsets.all(20),
            children: ['About', 'Skills', 'Projects', 'Experience', 'YouTube', 'Teaching', 'Contact']
                .map((link) => ListTile(
                      title: Text(link, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      onTap: () {
                        Navigator.pop(context);
                        scrollViewModel.scrollToSection(link);
                      },
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
