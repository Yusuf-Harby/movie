import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_strings.dart';

class WatchListEmpty extends StatelessWidget {
  const WatchListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.noSavedMovies),
            const SizedBox(height: 16),
            Text(
              AppStrings.watchListEmptyTitle,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.watchListEmptySubtitle,
              style: textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
