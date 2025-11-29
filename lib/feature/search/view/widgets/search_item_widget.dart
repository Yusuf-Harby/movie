import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchWidgetItem extends StatelessWidget {
  const SearchWidgetItem({
    super.key,
    this.imagePath,
    required this.movieDescrption,
    required this.movieType,
    required this.movieRate,
    required this.totalRate,
    required this.movieDate,
    this.totalItemonTap,
  });
  final String? imagePath;
  final String? movieDescrption;
  final String? movieDate;

  final String? movieType;
  final double? movieRate;
  final int? totalRate;
  final void Function()? totalItemonTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: totalItemonTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 5,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 9 / 12,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 15,

                    imageUrl: imagePath == "" || imagePath == null
                        ? ""
                        : "${ApiConstants.imagePath}$imagePath",
                    placeholder: (context, url) => Center(
                      child: Skeletonizer(
                        enabled: true,
                        child: Container(color: AppColors.gray),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieDescrption ?? "",
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    IcontAndTextRowItem(
                      text: double.parse(
                        movieRate.toString(),
                      ).toStringAsFixed(1),
                      iconpath: AppIcons.star,
                    ),
                    IcontAndTextRowItem(
                      text: " Total Count is $totalRate",
                      iconpath: AppIcons.ticket,
                    ),

                    IcontAndTextRowItem(
                      text: movieType ?? "",
                      iconpath: AppIcons.ticket,
                    ),
                    IcontAndTextRowItem(
                      text: movieDate != null && movieDate!.length >= 4
                          ? movieDate!.substring(0, 4)
                          : movieDate ?? "N/A",
                      iconpath: AppIcons.calendar,
                    ),

                    //Type
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IcontAndTextRowItem extends StatelessWidget {
  const IcontAndTextRowItem({
    super.key,
    required this.text,
    required this.iconpath,
  });
  final String text;
  final String iconpath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        spacing: 5,
        children: [
          SvgPicture.asset(iconpath),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
