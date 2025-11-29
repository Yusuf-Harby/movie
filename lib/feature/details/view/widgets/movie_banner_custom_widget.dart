import 'dart:ui' show ImageFilter;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';

class MovieBannerCustomWidget extends StatefulWidget {
  const MovieBannerCustomWidget({
    super.key,
    this.backdropPath,
    this.rateValue,
    this.loadingTemplate = false,
    this.errorTemplate = false,
    this.errorMsg = "",
  });
  final String? backdropPath;
  final double? rateValue;
  final bool loadingTemplate;
  final bool errorTemplate;
  final String errorMsg;

  @override
  State<MovieBannerCustomWidget> createState() =>
      _MovieBannerCustomWidgetState();
}

class _MovieBannerCustomWidgetState extends State<MovieBannerCustomWidget> {
  @override
  Widget build(BuildContext context) {
    Widget? targetWidget;
    Widget? targetRateWidget;

    if (widget.loadingTemplate) {
      targetWidget = _loadingTemplate(context);
      targetRateWidget = _textTemplate();
    }
    if (widget.errorTemplate) {
      targetWidget = _errorTemplate(context, widget.errorMsg);
      targetRateWidget = _textTemplate();
    }
    return _finishTemplate(
      targetWidget ?? _imageBanner(),
      targetRateWidget ?? _textTemplate(widget.rateValue),
    );
  }

  Widget _finishTemplate(Widget banner, Widget rate) => Stack(
    alignment: Alignment.bottomRight,
    children: [
      banner,
      Padding(
        padding: const EdgeInsets.only(right: 11, bottom: 9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).hoverColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppIcons.star),
                  SizedBox(width: 5),
                  rate,
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
  Widget _imageBanner() => CachedNetworkImage(
    imageUrl: "${ApiConstants.imagePath}${widget.backdropPath ?? ""}",
    errorWidget: (context, url, error) =>
        _errorTemplate(context, error.toString()),
    placeholder: (context, url) => _loadingTemplate(context),
    imageBuilder: (ctx, imageProvider) => ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Container(
        width: bannerWidth,
        height: bannerHeight,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    ),
  );
  Widget _loadingTemplate(BuildContext context) => LoadingWidgetSkeleton(
    itemCount: 1,
    itemHeight: bannerHeight,
    padding: EdgeInsetsGeometry.zero,
    itemWidth: MediaQuery.of(context).size.width,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  );
  Widget _errorTemplate(BuildContext context, String error) {
    return Container(
      width: bannerWidth,
      height: bannerHeight,
      color: Colors.grey,
    );
  }

  Widget _textTemplate([double? rateValue]) => Text(
    rateValue?.toStringAsFixed(1) ?? "-",
    style: Theme.of(
      context,
    ).textTheme.titleSmall!.copyWith(color: AppColors.orange),
  );

  double get bannerHeight => 210;
  double get bannerWidth => double.infinity;
}
