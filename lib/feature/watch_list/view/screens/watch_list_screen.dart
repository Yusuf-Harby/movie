import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_strings.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.watchList)),
    );
  }
}
