import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingWidgetSkelton extends StatelessWidget {
  const LoadingWidgetSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,

      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 5,
          padding: EdgeInsets.all(30),
          itemBuilder: (context, index) {
            return Container(
              width: 40,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        ),
      ),
    );
  }
}
