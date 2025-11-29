import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';

class MoviePosterTitleCustomWidget extends StatefulWidget {
  const MoviePosterTitleCustomWidget({
    super.key,
    this.title,
    this.posterUrl,
    this.loadingTemplate = false,
    this.errorTemplate = false,
    this.errorMsg = "",
  });
  final String? title;
  final String? posterUrl;
  final bool loadingTemplate;
  final bool errorTemplate;
  final String errorMsg;

  @override
  State<MoviePosterTitleCustomWidget> createState() =>
      _MoviePosterCustomWidgetState();
}

class _MoviePosterCustomWidgetState
    extends State<MoviePosterTitleCustomWidget> {
  @override
  Widget build(BuildContext context) {
    Widget? targetWidget;
    Widget? targetTextWidget;
    if (widget.loadingTemplate) {
      targetWidget = _loadingTemplate(context);
      targetTextWidget = _titleLoading();
    }
    if (widget.errorTemplate) {
      targetWidget = _errorTemplate(context, widget.errorMsg);
      targetTextWidget = _titleError();
    }
    return _widgetBody(
      context,
      targetWidget ?? _posterWidget(),
      targetTextWidget ?? _titleWidget(),
    );
  }

  Widget _widgetBody(BuildContext context, Widget child, Widget title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Transform.translate(
            offset: Offset(0, -MediaQuery.of(context).size.width / 5.5),
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: child,
              ),
            ),
          ),
          Expanded(child: title),
        ],
      ),
    );
  }

  Widget _posterWidget() => CachedNetworkImage(
    imageUrl: "${ApiConstants.imagePath}${widget.posterUrl ?? ""}",
    imageBuilder: (context, imageProvider) => Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
    placeholder: (context, _) => _loadingTemplate(context),
    errorWidget: (context, _, error) =>
        _errorTemplate(context, error.toString()),
  );

  Widget _loadingTemplate(BuildContext context) => LoadingWidgetSkeleton(
    itemCount: 1,
    itemHeight: cardHeight,
    padding: EdgeInsets.zero,
    itemWidth: cardWidth,
    borderRadius: BorderRadius.circular(16),
  );

  Widget _errorTemplate(BuildContext context, String error) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      color: Colors.grey,
      child: Center(child: Icon(Icons.image_not_supported_sharp)),
    );
  }

  Widget _titleWidget() => Text(
    widget.title ?? "Unknown Title",
    style: Theme.of(context).textTheme.titleLarge,
    softWrap: true,
    overflow: TextOverflow.visible,
  );

  Widget _titleLoading() => LoadingWidgetSkeleton(
    itemCount: 2,
    itemHeight: 50,
    padding: EdgeInsets.only(top: 5),
    itemWidth: MediaQuery.of(context).size.width,
    borderRadius: BorderRadius.zero,
    scrollDirection: Axis.vertical,
    type: LoadingSkeletonType.text,
  );

  Widget _titleError() => Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[300],
    ),
    child: Center(child: Icon(Icons.image_not_supported_sharp)),
  );

  double get cardHeight => 120;
  double get cardWidth => 95;
}
