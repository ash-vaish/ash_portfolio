import 'package:flutter/material.dart';
import '../widgets/section_label.dart';
import '../widgets/contact_item.dart';
import '../data/portfolio_data.dart';

class ContactPage extends StatelessWidget {
  final bool isDesktop;
  const ContactPage({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) const DesktopPageTitle(label: "get_in_touch"),
        if (!isDesktop) const SectionLabel(label: "get_in_touch"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 20.0),
          child: isDesktop ? _buildDesktop() : _buildMobile(),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      mainAxisExtent: 90,
      children: PortfolioData.contacts.map((c) => ContactItem(data: c, isDesktop: true)).toList(),
    );
  }

  Widget _buildMobile() {
    return Column(
      children: PortfolioData.contacts.map((c) => ContactItem(data: c)).toList(),
    );
  }
}
