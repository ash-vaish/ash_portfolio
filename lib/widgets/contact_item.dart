import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface3,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  widget.data.icon,
                  size: 20,
                  color: widget.data.iconBg,
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
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: widget.isDesktop ? 16 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.data.value,
                      style: GoogleFonts.firaCode(
                        color: AppColors.textMuted,
                        fontSize: widget.isDesktop ? 13 : 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.isDesktop)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textMuted,
                  size: 12,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
