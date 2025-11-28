import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/constants/app_strings.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';
import 'package:movie/feature/details/data/models/related_movie_details_model.dart';

class MovieRelatedListCustomWidget extends StatefulWidget {
  const MovieRelatedListCustomWidget({
    super.key,
    this.results,
    this.onTap,
    this.loadingTemplate = false,
    this.errorTemplate = false,
    this.errorMsg = "",
  });

  final void Function(int)? onTap;
  final bool loadingTemplate;
  final bool errorTemplate;
  final String errorMsg;
  final RelatedMovieDetailsModel? results;

  @override
  State<MovieRelatedListCustomWidget> createState() =>
      _MovieRelatedListCustomWidgetState();
}

class _MovieRelatedListCustomWidgetState
    extends State<MovieRelatedListCustomWidget> {
  @override
  Widget build(BuildContext context) {
    Widget? targetWidget;
    if (widget.loadingTemplate) {
      targetWidget = _loadingTemplate(context, Random().nextInt(3) + 2);
    }
    if (widget.errorTemplate) {
      targetWidget = _errorTemplate();
    }
    return _widgetBody(targetWidget ?? _finishTemplate());
  }

  Widget _finishTemplate() {
    final results = widget.results?.results ?? [];
    return Wrap(
      spacing: 8,
      children: results
          .where((ele) => ele.posterPath != null && ele.id != null)
          .map((ele) => _imageCard(ele.posterPath!, ele.id!))
          .toList(),
    );
  }

  Widget _imageCard(String imageUrl, int movieId) {
    return GestureDetector(
      onTap: widget.onTap != null ? () => widget.onTap!(movieId) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        width: MediaQuery.of(context).size.width / 3 - 12,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 100 / 146,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstants.imagePath}$imageUrl",
              fit: BoxFit.cover,
              placeholder: (context, url) => _loadingTemplate(context),
              errorWidget: (_, __, ___) => _errorTemplate(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetBody(Widget child) => Padding(
    padding: const EdgeInsets.only(left: 12, bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.releatedMovies,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );

  Widget _loadingTemplate(BuildContext context, [int len = 1]) => Wrap(
    spacing: 8,
    children: List.generate(
      len,
      (indx) => LoadingWidgetSkeleton(
        itemHeight: 150,
        itemCount: 1,
        padding: EdgeInsets.zero,
        itemWidth: (MediaQuery.of(context).size.width / 3) - 12,
        borderRadius: BorderRadius.circular(16),
        margin: EdgeInsets.only(bottom: 18),
      ),
    ),
  );
  Widget _errorTemplate() => Wrap(
    spacing: 8,
    children: List.generate(
      Random().nextInt(10),
      (index) => _imageCard("", -1),
    ),
  );
}
