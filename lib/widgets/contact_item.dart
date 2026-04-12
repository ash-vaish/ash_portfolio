import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class ContactItem extends StatefulWidget {
  final ContactData data;
  final bool isDesktop;
  const ContactItem({super.key, required this.data, this.isDesktop = false});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface1,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isHovered ? AppColors.flutterCyan.withValues(alpha: 0.25) : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _getIconBgColor(widget.data.label),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: FaIcon(
                _getIcon(widget.data.label),
                size: 22,
                color: _getIconColor(widget.data.label),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.data.label,
                    style: const TextStyle(
                      color: Color(0xFFF0F2FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.data.value,
                    style: GoogleFonts.firaCode(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String label) {
    switch (label.toLowerCase()) {
      case 'email':
        return FontAwesomeIcons.envelope;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'github':
        return FontAwesomeIcons.github;
      case 'location':
        return FontAwesomeIcons.locationDot;
      default:
        return FontAwesomeIcons.question;
    }
  }

  Color _getIconColor(String label) {
    switch (label.toLowerCase()) {
      case 'email':
        return const Color(0xFF44D4FA);
      case 'linkedin':
        return const Color(0xFF0A66C2);
      case 'github':
        return const Color(0xFFF0F2FF);
      case 'location':
        return const Color(0xFFFF6B6B);
      default:
        return Colors.white;
    }
  }

  Color _getIconBgColor(String label) {
    switch (label.toLowerCase()) {
      case 'email':
        return const Color(0xFF44D4FA).withValues(alpha: 0.12);
      case 'linkedin':
        return const Color(0xFF0A66C2).withValues(alpha: 0.15);
      case 'github':
        return const Color(0xFFF0F2FF).withValues(alpha: 0.08);
      case 'location':
        return const Color(0xFFFF6B6B).withValues(alpha: 0.12);
      default:
        return Colors.white10;
    }
  }
}
