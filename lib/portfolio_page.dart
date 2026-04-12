import 'package:flutter/material.dart';
import 'layouts/mobile_layout.dart';
import 'layouts/desktop_layout.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  int _activeTab = 0;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = [_homeKey, _workKey, _skillsKey, _contactKey];
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  bool _isScrollingToSection = false;

  void _onScroll() {
    if (_isScrollingToSection) return;

    final scrollOffset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    // Special case: bottom of the page
    if (scrollOffset >= maxScroll - 50) {
      if (_activeTab != 3) {
        setState(() => _activeTab = 3);
      }
      return;
    }

    int newActiveTab = 0;
    const triggerThreshold = 120.0;

    for (int i = 0; i < _keys.length; i++) {
      final context = _keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        // The Y position of the section relative to the top of the viewport
        // is (box.localToGlobal(Offset.zero).dy).
        // However, since we are in a ScrollView, we want to know its position
        // relative to the scroll.
        // Actually, localToGlobal(Offset.zero).dy already gives us the distance
        // from the top of the screen.
        
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
            skillsKey: _skillsKey,
            contactKey: _contactKey,
          );
        } else {
          return DesktopLayout(
            activeTab: _activeTab,
            onTabTap: _scrollToSection,
            scrollController: _scrollController,
            homeKey: _homeKey,
            workKey: _workKey,
            skillsKey: _skillsKey,
            contactKey: _contactKey,
          );
        }
      },
    );
  }
}
