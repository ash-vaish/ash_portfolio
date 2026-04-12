import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class MetricCard extends StatelessWidget {
  final MetricData data;
  final bool isDesktop;
  const MetricCard({super.key, required this.data, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.value,
            style: TextStyle(
              color: data.color,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.firaCode(
              color: AppColors.textMuted,
              fontSize: isDesktop ? 12 : 10,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
