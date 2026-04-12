import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

class ProjectTile extends StatefulWidget {
  final ProjectData data;
  final double width;
  final bool forceHover;
  final bool enableHover;
  const ProjectTile({
    super.key,
    required this.data,
    required this.width,
    this.forceHover = false,
    this.enableHover = true,
  });

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = (widget.enableHover && isHovered) || widget.forceHover;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: const EdgeInsets.all(16),
        transform: active ? Matrix4.translationValues(0.0, -8.0, 0.0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active ? widget.data.accentColor.withValues(alpha: 0.5) : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: widget.data.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(
                widget.data.icon,
                size: 20,
                color: widget.data.accentColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.data.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                height: 1.5,
              ),
            ),
            const Spacer(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                if (widget.data.hasAppStore)
                  _StoreButton(
                    icon: FontAwesomeIcons.apple,
                    url: widget.data.appStoreUrl!,
                    isActive: active,
                  ),
                if (widget.data.hasPlayStore)
                  _StoreButton(
                    icon: FontAwesomeIcons.googlePlay,
                    url: widget.data.playStoreUrl!,
                    isActive: active,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final bool isActive;

  const _StoreButton({
    required this.icon,
    required this.url,
    this.isActive = false,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool showActive = isHovered || widget.isActive;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse(widget.url);
            try {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } catch (e) {
              debugPrint('Could not launch $uri: $e');
            }
          },
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.flutterCyan.withValues(alpha: 0.15),
          highlightColor: AppColors.flutterCyan.withValues(alpha: 0.1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: showActive 
                  ? AppColors.flutterCyan.withValues(alpha: 0.1) 
                  : AppColors.surface3,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: showActive 
                    ? AppColors.flutterCyan.withValues(alpha: 0.4) 
                    : AppColors.border,
              ),
            ),
            alignment: Alignment.center,
            child: FaIcon(
              widget.icon,
              size: 16,
              color: showActive ? AppColors.flutterCyan : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
