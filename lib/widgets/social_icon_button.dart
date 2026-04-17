import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const SocialIconButton({super.key, required this.icon, required this.onPressed});

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isHovered ? AppColors.primaryAccent : Colors.transparent,
          border: Border.all(color: AppColors.primaryAccent),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: IconButton(
          icon: Icon(widget.icon),
          color: _isHovered ? Colors.white : AppColors.primaryAccent,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
