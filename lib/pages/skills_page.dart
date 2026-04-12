import 'package:flutter/material.dart';
import '../widgets/section_label.dart';
import '../widgets/skill_card.dart';
import '../data/portfolio_data.dart';

class SkillsPage extends StatelessWidget {
  final bool isDesktop;
  const SkillsPage({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) const DesktopPageTitle(label: "technical_stack"),
        if (!isDesktop) const SectionLabel(label: "technical_stack"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 20.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 80,
            ),
            itemCount: PortfolioData.skills.length,
            itemBuilder: (context, index) {
              return SkillCard(skill: PortfolioData.skills[index]);
            },
          ),
        ),
      ],
    );
  }
}
