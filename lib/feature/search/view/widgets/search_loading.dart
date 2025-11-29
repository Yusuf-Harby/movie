import 'package:flutter/material.dart';
import 'package:movie/feature/search/view/widgets/search_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchLoadingIndecator extends StatelessWidget {
  const SearchLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Skeletonizer(
            child: SearchWidgetItem(
              movieDescrption: "movieDescrption",
              movieType: "movieType",
              movieRate: 5.5,
              totalRate: 4,
              movieDate: "movieDate",
            ),
          );
        },
      ),
    );
  }
}
