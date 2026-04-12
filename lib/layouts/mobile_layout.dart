import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';
import '../widgets/pulse_ring.dart';
import '../pages/home_page.dart';
import '../pages/work_page.dart';
import '../pages/skills_page.dart';
import '../pages/contact_page.dart';

class MobileLayout extends StatelessWidget {
  final int activeTab;
  final Function(int) onTabTap;
  final ScrollController scrollController;
  final GlobalKey homeKey;
  final GlobalKey workKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;
  final AnimationController skillsAnimationController;

  const MobileLayout({
    super.key,
    required this.activeTab,
    required this.onTabTap,
    required this.scrollController,
    required this.homeKey,
    required this.workKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.contactKey,
    required this.skillsAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface1,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        shape: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "ash",
                  children: [
                    TextSpan(
                      text: ".",
                      style: TextStyle(color: AppColors.flutterCyan),
                    ),
                    const TextSpan(text: "dev"),
                  ],
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 8,
                      height: 8,
                      child: PulseRing(),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        PortfolioData.statusText,
                        style: GoogleFonts.firaCode(
                          color: AppColors.dartTeal,
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            HomePage(key: homeKey, isDesktop: false),
            WorkPage(key: workKey, projectsKey: projectsKey, isDesktop: false),
            SkillsPage(
              key: skillsKey,
              isDesktop: false,
              animationController: skillsAnimationController,
            ),
            ContactPage(key: contactKey, isDesktop: false),
            const SizedBox(height: 100), // Extra space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: _buildBottomNav(),
      ),
      extendBody: true,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCC0F1017),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(PortfolioData.navTabs.length, (index) {
                final tab = PortfolioData.navTabs[index];
                final isSelected = activeTab == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTabTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.flutterCyan.withValues(alpha: 0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tab.icon,
                            size: 20,
                            color: isSelected ? AppColors.flutterCyan : AppColors.textMuted,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            tab.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.firaCode(
                              fontSize: 11,
                              color: isSelected ? AppColors.flutterCyan : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
