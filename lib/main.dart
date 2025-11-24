import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_theme.dart';
import 'package:movie/feature/app_section/app_section.dart';

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
      initialRoute: App.routeName,
      routes: {App.routeName: (_) => const App()},
    );
  }
}
