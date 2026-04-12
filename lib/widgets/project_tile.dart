import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class ProjectTile extends StatefulWidget {
  final ProjectData data;
  final double width;
  const ProjectTile({super.key, required this.data, required this.width});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: const EdgeInsets.all(20),
        transform: isHovered ? Matrix4.translationValues(0.0, -3.0, 0.0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surface1,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isHovered ? widget.data.accentColor.withValues(alpha: 0.5) : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.data.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(
                widget.data.icon,
                size: 20,
                color: widget.data.accentColor,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.data.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.data.subtitle,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                if (widget.data.hasAppStore) _buildStoreBadge("App Store"),
                if (widget.data.hasPlayStore) _buildStoreBadge("Play Store"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surface3,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          fontSize: 10,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
