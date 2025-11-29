import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_assets.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,

      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 5),
        Image.asset(AppImages.noSearchResults),

        SizedBox(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Text(
            "we are sorry, we can not find the movie :(",
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.7,

          child: Text(
            "Find your movie by Type title, categories, years, etc ...",
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
