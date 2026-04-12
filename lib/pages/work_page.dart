import 'package:flutter/material.dart';
import '../widgets/section_label.dart';
import '../widgets/exp_card.dart';
import '../widgets/project_tile.dart';
import '../data/portfolio_data.dart';

class WorkPage extends StatelessWidget {
  final bool isDesktop;
  const WorkPage({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) const DesktopPageTitle(label: "experience"),
        if (!isDesktop) const SectionLabel(label: "experience"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 20.0),
          child: Column(
            children: PortfolioData.experience.map((exp) => ExpCard(data: exp)).toList(),
          ),
        ),
        const SizedBox(height: 24),
        if (isDesktop) const DesktopPageTitle(label: "projects"),
        if (!isDesktop) const SectionLabel(label: "projects"),
        if (isDesktop)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.25,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: PortfolioData.projects.map((p) => ProjectTile(data: p, width: double.infinity)).toList(),
          )
        else
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: PortfolioData.projects.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return ProjectTile(data: PortfolioData.projects[index], width: 220);
              },
            ),
          ),
      ],
    );
  }
}
