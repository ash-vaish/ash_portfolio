import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';
import '../widgets/metric_card.dart';

class HomePage extends StatelessWidget {
  final bool isDesktop;

  const HomePage({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 0 : 20.0,
        vertical: isDesktop ? 0 : 28.0,
      ),
      child: isDesktop ? _buildDesktop(context) : _buildMobile(context),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCodeComment(),
        const SizedBox(height: 16),
        _buildAvatarRow(false),
        const SizedBox(height: 24),
        _buildTagline(),
        const SizedBox(height: 28),
        _buildPills(),
        const SizedBox(height: 28),
        _buildMetrics(false),
      ],
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeComment(),
              const SizedBox(height: 16),
              _buildAvatarRow(true),
              const SizedBox(height: 20),
              _buildTagline(maxWidth: 380),
              const SizedBox(height: 24),
              _buildPills(),
            ],
          ),
        ),
        const SizedBox(width: 28),
        _buildMetrics(true),
      ],
    );
  }

  Widget _buildCodeComment() {
    return Text.rich(
      TextSpan(
        text: "// ",
        children: [
          TextSpan(
            text: PortfolioData.heroComment.split(' · ').first,
            style: const TextStyle(color: AppColors.dartTeal),
          ),
          TextSpan(text: " · ${PortfolioData.heroComment.split(' · ').sublist(1).join(' · ')}"),
        ],
      ),
      style: GoogleFonts.firaCode(
        fontSize: isDesktop ? 13 : 12,
        color: AppColors.textMuted,
        height: 1.6,
      ),
    );
  }

  Widget _buildAvatarRow(bool isDesktop) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: isDesktop ? 72 : 64,
              height: isDesktop ? 72 : 64,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(isDesktop ? 24 : 22),
                border: Border.all(
                  color: AppColors.flutterCyan.withValues(alpha: 0.2),
                ),
              ),
            ),
            Container(
              width: isDesktop ? 64 : 56,
              height: isDesktop ? 64 : 56,
              decoration: BoxDecoration(
                color: AppColors.surface3,
                borderRadius: BorderRadius.circular(isDesktop ? 20 : 18),
                border: Border.all(color: AppColors.flutterCyan, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                PortfolioData.initials,
                style: TextStyle(
                  color: AppColors.flutterCyan,
                  fontSize: isDesktop ? 22 : 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PortfolioData.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isDesktop ? 36 : 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.02,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                PortfolioData.roleTag,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.firaCode(
                  color: AppColors.flutterCyan,
                  fontSize: isDesktop ? 14 : 13,
                  letterSpacing: 0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagline({double? maxWidth}) {
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: Text.rich(
        TextSpan(
          text: PortfolioData.heroTaglineStart,
          children: [
            TextSpan(
              text: PortfolioData.heroTaglineBold,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: PortfolioData.heroTaglineEnd,
            ),
          ],
        ),
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: isDesktop ? 16 : 15,
          height: 1.7,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildPills() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: PortfolioData.pills.map((pill) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: pill.dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                pill.label,
                style: GoogleFonts.firaCode(
                  color: AppColors.textSecondary,
                  fontSize: isDesktop ? 12 : 11,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMetrics(bool isDesktop) {
    if (isDesktop) {
      return Column(
        children: PortfolioData.metrics.map((m) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MetricCard(data: m, isDesktop: true),
          );
        }).toList(),
      );
    } else {
      return Row(
        children: PortfolioData.metrics.map((m) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: m == PortfolioData.metrics.last ? 0 : 10.0,
              ),
              child: MetricCard(data: m),
            ),
          );
        }).toList(),
      );
    }
  }
}
