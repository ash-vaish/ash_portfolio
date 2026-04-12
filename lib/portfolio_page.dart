import 'package:flutter/material.dart';
import 'layouts/mobile_layout.dart';
import 'layouts/desktop_layout.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _activeTab = 0;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late List<GlobalKey> _keys;

  late AnimationController _skillsAnimationController;
  bool _skillsAnimated = false;

  @override
  void initState() {
    super.initState();
    _keys = [_homeKey, _workKey, _projectsKey, _skillsKey, _contactKey];
    _scrollController.addListener(_onScroll);
    _skillsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _skillsAnimationController.dispose();
    super.dispose();
  }

  bool _isScrollingToSection = false;

  void _onScroll() {
    if (_isScrollingToSection) return;

    final scrollOffset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    // Special case: bottom of the page
    if (scrollOffset >= maxScroll - 50) {
      if (_activeTab != _keys.length - 1) {
        setState(() => _activeTab = _keys.length - 1);
      }
      return;
    }

    int newActiveTab = _activeTab;
    const triggerThreshold = 150.0;

    for (int i = 0; i < _keys.length; i++) {
      final context = _keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        
        if (position.dy <= triggerThreshold) {
          newActiveTab = i;
        }
      }
    }

    if (newActiveTab != _activeTab) {
      setState(() {
        _activeTab = newActiveTab;
      });
    }

    // Skills animation logic
    if (!_skillsAnimated) {
      final skillsContext = _skillsKey.currentContext;
      if (skillsContext != null) {
        final renderBox = skillsContext.findRenderObject() as RenderBox?;
        final position = renderBox?.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;
        if (position != null && position.dy < screenHeight) {
          _skillsAnimated = true;
          _skillsAnimationController.forward();
        }
      }
    }
  }

  void _scrollToSection(int index) async {
    final context = _keys[index].currentContext;
    if (context != null) {
      setState(() {
        _activeTab = index;
        _isScrollingToSection = true;
      });
      
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      
      // Small delay to ensure scroll listener doesn't fight the manual snap
      await Future.delayed(const Duration(milliseconds: 100));
      _isScrollingToSection = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return MobileLayout(
            activeTab: _activeTab,
            onTabTap: _scrollToSection,
            scrollController: _scrollController,
            homeKey: _homeKey,
            workKey: _workKey,
            projectsKey: _projectsKey,
            skillsKey: _skillsKey,
            contactKey: _contactKey,
            skillsAnimationController: _skillsAnimationController,
          );
        } else {
          return DesktopLayout(
            activeTab: _activeTab,
            onTabTap: _scrollToSection,
            scrollController: _scrollController,
            homeKey: _homeKey,
            workKey: _workKey,
            projectsKey: _projectsKey,
            skillsKey: _skillsKey,
            contactKey: _contactKey,
            skillsAnimationController: _skillsAnimationController,
          );
        }
      },
    );
  }
}
