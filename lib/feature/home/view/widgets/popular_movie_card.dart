import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemMovieWidget extends StatelessWidget {
  const ItemMovieWidget({super.key, this.posterPath, this.onTap});
  final String? posterPath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 13),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 100 / 145,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstants.imagePath}$posterPath",
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Skeletonizer(
                  enabled: true,
                  child: Container(color: AppColors.gray),
                ),
              ),
              errorWidget: (_, __, ___) => ColoredBox(
                color: AppColors.gray,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
