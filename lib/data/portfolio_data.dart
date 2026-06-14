import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PillData {
  final Color dotColor;
  final String label;
  PillData({required this.dotColor, required this.label});
}

class MetricData {
  final String value;
  final String label;
  final Color color;
  MetricData({required this.value, required this.label, required this.color});
}

enum BadgeType { live, prev }

class ExperienceData {
  final IconData icon;
  final Color iconBg;
  final bool isCurrent;
  final String role;
  final String badge;
  final BadgeType badgeType;
  final String company;
  final String desc;
  final List<String> chips;

  ExperienceData({
    required this.icon,
    required this.iconBg,
    required this.isCurrent,
    required this.role,
    required this.badge,
    required this.badgeType,
    required this.company,
    required this.desc,
    required this.chips,
  });
}

class ProjectData {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String subtitle;
  final String? appStoreUrl;
  final String? playStoreUrl;

  ProjectData({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.subtitle,
    this.appStoreUrl,
    this.playStoreUrl,
  });

  bool get hasAppStore => appStoreUrl != null;
  bool get hasPlayStore => playStoreUrl != null;
}

class SkillData {
  final String name;
  final double pct;
  final Color barColor;

  SkillData({required this.name, required this.pct, required this.barColor});
}

class ContactData {
  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;

  ContactData({required this.icon, required this.iconBg, required this.label, required this.value});
}

class NavTabData {
  final String id;
  final IconData icon;
  final String label;

  NavTabData({required this.id, required this.icon, required this.label});
}

class PortfolioData {
  static const String name = "Ashish Vaish";
  static const String initials = "AV";
  static const String roleTag = "flutter_developer.dart";
  static const String statusText = "available_for_hire";
  static const String heroComment = "Flutter Developer · 4.5+ years · Noida, IN";
  static const String heroTaglineStart = "Building ";
  static const String heroTaglineBold = "production-grade";
  static const String heroTaglineEnd = " cross-platform apps. From healthcare solutions to government portals — real apps, real users.";
  static const String sidebarFooter = "// Noida, IN\n// 4.5+ yrs · 4 apps live\n// Flutter · Dart · Java";

  static final List<PillData> pills = [
    PillData(dotColor: AppColors.flutterCyan, label: "iOS · Android · Web"),
    PillData(dotColor: AppColors.dartTeal, label: "Clean Architecture"),
    PillData(dotColor: AppColors.accentRed, label: "BloC · Provider"),
  ];

  static final List<MetricData> metrics = [
    MetricData(value: "4.5+", label: "YRS EXP", color: AppColors.flutterCyan),
    MetricData(value: "4", label: "APPS LIVE", color: AppColors.dartTeal),
    MetricData(value: "3", label: "COMPANIES", color: AppColors.accentRed),
  ];

  static final List<ExperienceData> experience = [
    ExperienceData(
      icon: Icons.account_balance_rounded,
      iconBg: const Color(0x1A44D4FA),
      isCurrent: true,
      role: "Associate Consultant",
      badge: "● live",
      badgeType: BadgeType.live,
      company: "Infosys (Income Tax Dept.)",
      desc: "Developed Aaykar Setu (National IT App) with Acts, Rules, FCM notifications, and AI Chatbot integration.",
      chips: ["Flutter", "FCM", "Maps API", "Aug 2025–Now"],
    ),
    ExperienceData(
      icon: Icons.auto_stories_rounded,
      iconBg: const Color(0x1A3DC8A0),
      isCurrent: false,
      role: "Flutter Developer",
      badge: "2024–2025",
      badgeType: BadgeType.prev,
      company: "uCertify Training & Learning",
      desc: "Built uCertify Learn+ & AI Tutor. Improved LMS integration by 20% and used BigQuery for engagement insights.",
      chips: ["Flutter", "Firebase", "BigQuery", "July 24–July 25"],
    ),
    ExperienceData(
      icon: Icons.favorite_rounded,
      iconBg: const Color(0x1AFF6B6B),
      isCurrent: false,
      role: "Software Engineer - 3",
      badge: "2021–2024",
      badgeType: BadgeType.prev,
      company: "Zimetrics Technologies",
      desc: "Carelink Connect for Medtronic. Optimized app size by 10% and improved performance with BloC & Clean Arch.",
      chips: ["Flutter", "BloC", "Architecture", "Aug 21–June 24"],
    ),
  ];

  static final List<ProjectData> projects = [
    ProjectData(
      icon: Icons.edit_note_rounded,
      accentColor: const Color(0xFF6C63FF),
      title: "Writer.",
      subtitle: "Handwriting conversion tool with 300K+ downloads",
      playStoreUrl: "https://play.google.com/store/apps/details?id=in.ashprog.assignmentwriter",
    ),
    ProjectData(
      icon: Icons.account_balance_rounded,
      accentColor: AppColors.flutterCyan,
      title: "Aaykar Setu",
      subtitle: "Official Income Tax Department app for Acts & Rules",
      appStoreUrl: "https://apps.apple.com/us/app/aaykar-setu/id6760544459",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.taxmann.aayakarsetu",
    ),
    ProjectData(
      icon: Icons.monitor_heart_rounded,
      accentColor: AppColors.accentRed,
      title: "Carelink Connect",
      subtitle: "Real-time glucose monitoring for Medtronic patients",
      appStoreUrl: "https://apps.apple.com/us/app/carelink-connect-us/id1535972481",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.medtronic.diabetes.carepartner.us",
    ),
    ProjectData(
      icon: Icons.school_rounded,
      accentColor: AppColors.dartTeal,
      title: "uCertify Learn+",
      subtitle: "AI-powered e-learning platform with hands-on labs",
      appStoreUrl: "https://apps.apple.com/in/app/ucertify-learn/id1505460373",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.flutter.ucertifyLearn",
    ),
  ];

  static final List<SkillData> skills = [
    SkillData(name: "Flutter/Dart", pct: 95, barColor: AppColors.flutterCyan),
    SkillData(name: "Java/Kotlin", pct: 85, barColor: AppColors.dartTeal),
    SkillData(name: "BloC/Provider", pct: 92, barColor: AppColors.flutterCyan),
    SkillData(name: "Firebase/FCM", pct: 90, barColor: AppColors.dartTeal),
    SkillData(name: "Clean Architecture", pct: 88, barColor: AppColors.accentRed),
    SkillData(name: "REST APIs/Dio", pct: 90, barColor: AppColors.flutterCyan),
    SkillData(name: "SQLite/Hive", pct: 85, barColor: AppColors.dartTeal),
    SkillData(name: "Unit/Widget Testing", pct: 80, barColor: AppColors.accentRed),
    SkillData(name: "CI/CD/Git", pct: 88, barColor: AppColors.flutterCyan),
  ];

  static final List<ContactData> contacts = [
    ContactData(
      icon: Icons.email_rounded,
      iconBg: const Color(0x1A44D4FA),
      label: "Email",
      value: "ashvaish8081@gmail.com",
    ),
    ContactData(
      icon: Icons.business_rounded,
      iconBg: const Color(0x1A3DC8A0),
      label: "LinkedIn",
      value: "linkedin.com/in/ash-vaish",
    ),
    ContactData(
      icon: Icons.code_rounded,
      iconBg: const Color(0x1AFF6B6B),
      label: "GitHub",
      value: "github.com/ash-vaish",
    ),
    ContactData(
      icon: Icons.place_rounded,
      iconBg: const Color(0x1AFFB83C),
      label: "Location",
      value: "Noida, Uttar Pradesh, IN",
    ),
  ];

  static final List<NavTabData> navTabs = [
    NavTabData(id: "home", icon: Icons.home_rounded, label: "home"),
    NavTabData(id: "work", icon: Icons.work_rounded, label: "work"),
    NavTabData(id: "projects", icon: Icons.grid_view_rounded, label: "projects"),
    NavTabData(id: "skills", icon: Icons.terminal_rounded, label: "skills"),
    NavTabData(id: "contact", icon: Icons.mail_rounded, label: "contact"),
  ];
}
