import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:movie/feature/watch_list/data/models/watch_list_item_model.dart';

class WatchListItem extends StatelessWidget {
  const WatchListItem({super.key, required this.item, required this.onRemove});

  final WatchListItemModel item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, '/details', arguments: item.id),
            child: _Poster(posterPath: item.posterPath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  item.releaseDate ?? 'Unknown release date',
                  style: textTheme.labelSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.star),
                    const SizedBox(width: 4),
                    Text(
                      item.voteAverage?.toStringAsFixed(1) ?? '--',
                      style: textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(AppIcons.saveFilled),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.posterPath});
  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    if (posterPath == null || posterPath!.isEmpty) {
      return Container(
        width: 60,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.gray,
        ),
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        width: 60,
        height: 90,
        fit: BoxFit.cover,
        imageUrl: '${ApiConstants.imagePath}$posterPath',
        errorWidget: (_, __, ___) => Container(
          width: 60,
          height: 90,
          color: AppColors.gray,
          child: const Icon(Icons.image_not_supported_outlined),
        ),
      ),
    );
  }
}
