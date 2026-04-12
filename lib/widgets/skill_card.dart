import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class SkillCard extends StatefulWidget {
  final SkillData skill;
  final Animation<double>? animation;

  const SkillCard({super.key, required this.skill, this.animation});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        transform: isHovered
            ? Matrix4.translationValues(0, -2, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: isHovered ? AppColors.surface3 : AppColors.surface2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppColors.flutterCyan.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.skill.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${widget.skill.pct.toInt()}%",
                  style: GoogleFonts.firaCode(
                    color: AppColors.flutterCyan,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface3,
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.centerLeft,
              child: widget.animation != null
                  ? AnimatedBuilder(
                      animation: widget.animation!,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor: widget.animation!.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.skill.barColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    )
                  : FractionallySizedBox(
                      widthFactor: widget.skill.pct / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.skill.barColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
