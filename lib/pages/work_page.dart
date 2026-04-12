import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/section_label.dart';
import '../widgets/exp_card.dart';
import '../widgets/project_tile.dart';
import '../data/portfolio_data.dart';

class WorkPage extends StatelessWidget {
  final bool isDesktop;
  final GlobalKey? projectsKey;
  const WorkPage({super.key, this.isDesktop = false, this.projectsKey});

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
        SizedBox(height: isDesktop ? 80 : 40),
        SizedBox(key: projectsKey),
        if (isDesktop) const DesktopPageTitle(label: "projects"),
        if (!isDesktop) const SectionLabel(label: "projects"),
        if (isDesktop)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: 190,
            ),
            itemCount: PortfolioData.projects.length,
            itemBuilder: (context, index) => ProjectTile(
              data: PortfolioData.projects[index],
              width: double.infinity,
            ),
          )
        else
          const ProjectCarousel(),
      ],
    );
  }
}

class ProjectCarousel extends StatefulWidget {
  const ProjectCarousel({super.key});

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  late PageController _pageController;
  Timer? _timer;
  final int _initialPage = 99999 ~/ 2;
  double _currentPage = 99999 / 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.55,
    );
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page ?? _initialPage.toDouble();
        });
      }
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          _timer?.cancel();
        } else if (notification is ScrollEndNotification) {
          _resetTimer();
        }
        return false;
      },
      child: SizedBox(
        height: 230, // Increased height to prevent clipping when cards transform upwards
        child: PageView.builder(
          controller: _pageController,
          clipBehavior: Clip.none, // Allow children to draw outside bounds if needed
          itemCount: 99999,
          itemBuilder: (context, index) {
            final projectIndex = index % PortfolioData.projects.length;
            final isCentered = (index - _currentPage).abs() < 0.5;

            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ProjectTile(
                data: PortfolioData.projects[projectIndex],
                width: double.infinity,
                forceHover: isCentered,
                enableHover: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
