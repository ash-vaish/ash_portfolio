import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class SkillCard extends StatelessWidget {
  final SkillData skill;
  final Animation<double>? animation;
  const SkillCard({super.key, required this.skill, this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${skill.pct.toInt()}%",
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
            child: animation != null
                ? AnimatedBuilder(
                    animation: animation!,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        widthFactor: animation!.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: skill.barColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    },
                  )
                : FractionallySizedBox(
                    widthFactor: skill.pct / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: skill.barColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
