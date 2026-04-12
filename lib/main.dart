import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_colors.dart';
import 'portfolio_page.dart';

void main() {
  runApp(const AshPortfolioApp());
}

class AshPortfolioApp extends StatelessWidget {
  const AshPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ashish Vaish | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme,
        ),
        primaryColor: AppColors.flutterCyan,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.flutterCyan,
          brightness: Brightness.dark,
          surface: AppColors.background,
        ),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}
