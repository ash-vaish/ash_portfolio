import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';
import '../widgets/pulse_ring.dart';
import '../pages/home_page.dart';
import '../pages/work_page.dart';
import '../pages/skills_page.dart';
import '../pages/contact_page.dart';

class DesktopLayout extends StatelessWidget {
  final int activeTab;
  final Function(int) onTabTap;
  final ScrollController scrollController;
  final GlobalKey homeKey;
  final GlobalKey workKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;
  final AnimationController skillsAnimationController;

  const DesktopLayout({
    super.key,
    required this.activeTab,
    required this.onTabTap,
    required this.scrollController,
    required this.homeKey,
    required this.workKey,
    required this.skillsKey,
    required this.contactKey,
    required this.skillsAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(48, 60, 48, 100),
                    child: Column(
                      children: [
                        HomePage(key: homeKey, isDesktop: true),
                        const SizedBox(height: 80),
                        WorkPage(key: workKey, isDesktop: true),
                        const SizedBox(height: 80),
                        SkillsPage(
                          key: skillsKey,
                          isDesktop: true,
                          animationController: skillsAnimationController,
                        ),
                        const SizedBox(height: 80),
                        ContactPage(key: contactKey, isDesktop: true),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: AppColors.surface1,
        border: Border(
          right: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebarHeader(),
          Expanded(
            child: _buildSidebarNav(),
          ),
          _buildSidebarFooter(),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "ash",
              children: [
                TextSpan(
                  text: ".dev",
                  style: TextStyle(color: AppColors.flutterCyan),
                ),
              ],
            ),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            PortfolioData.roleTag,
            style: GoogleFonts.firaCode(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const PulseRing(),
              const SizedBox(width: 8),
              Text(
                PortfolioData.statusText,
                style: GoogleFonts.firaCode(
                  color: AppColors.dartTeal,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: List.generate(PortfolioData.navTabs.length, (index) {
          final tab = PortfolioData.navTabs[index];
          final isSelected = activeTab == index;
          return SidebarNavItem(
            icon: tab.icon,
            label: tab.label,
            isSelected: isSelected,
            onTap: () => onTabTap(index),
          );
        }),
      ),
    );
  }

  Widget _buildSidebarFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Text(
        PortfolioData.sidebarFooter,
        style: GoogleFonts.firaCode(
          color: AppColors.textMuted,
          fontSize: 11,
          height: 1.8,
        ),
      ),
    );
  }
}

class SidebarNavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<SidebarNavItem> createState() => _SidebarNavItemState();
}

class _SidebarNavItemState extends State<SidebarNavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.flutterCyan.withValues(alpha: 0.1)
                  : isHovered
                      ? AppColors.surface2
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                  child: Icon(
                    widget.icon,
                    size: 16,
                    color: widget.isSelected ? AppColors.flutterCyan : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: GoogleFonts.firaCode(
                    fontSize: 13,
                    color: widget.isSelected ? AppColors.flutterCyan : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
