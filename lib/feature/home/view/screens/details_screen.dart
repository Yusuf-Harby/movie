import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_strings.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  static const String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.details),
      ),
    );
  }
}