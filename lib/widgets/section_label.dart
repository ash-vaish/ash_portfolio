import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  final double horizontalPadding;
  const SectionLabel({super.key, required this.label, this.horizontalPadding = 20.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 12),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 1,
            color: AppColors.flutterCyan,
          ),
          const SizedBox(width: 8),
          Text(
            label.toLowerCase(),
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: AppColors.textMuted,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopPageTitle extends StatelessWidget {
  final String label;
  const DesktopPageTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 1,
            color: AppColors.flutterCyan,
          ),
          const SizedBox(width: 10),
          Text(
            label.toLowerCase(),
            style: GoogleFonts.firaCode(
              fontSize: 13,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
