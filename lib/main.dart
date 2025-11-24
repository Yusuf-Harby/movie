import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:movie/core/utils/app_theme.dart';

void main() {
  runApp(const Movie());
}

class Movie extends StatelessWidget {
  const Movie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.showDarkTheme(),
    );
  }
}
