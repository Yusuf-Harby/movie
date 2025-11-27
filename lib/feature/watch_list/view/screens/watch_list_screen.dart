import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_strings.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> watchList = [];
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.watchList)),
      body: watchList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.noSavedMovies),
                  const SizedBox(height: 16),
                  Text(
                    'There is no movie yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find your movie by Type title,\ncategories, years, etc ',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
