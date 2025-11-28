import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';
import 'package:movie/feature/details/data/models/movie_details_model.dart';

class MovieDetailsStatusCustomWidget extends StatefulWidget {
  const MovieDetailsStatusCustomWidget({
    super.key,
    this.movieDetailsModel,
    this.loadingTemplate = false,
    this.errorTemplate = false,
    this.errorMsg = "",
  });
  final MovieDetailsModel? movieDetailsModel;
  final bool loadingTemplate;
  final bool errorTemplate;
  final String errorMsg;
  @override
  State<MovieDetailsStatusCustomWidget> createState() =>
      _MovieDetailsStatusCustomWidgetState();
}

class _MovieDetailsStatusCustomWidgetState
    extends State<MovieDetailsStatusCustomWidget> {
  @override
  Widget build(BuildContext context) {
    Widget? targetWidget;
    Widget? targetDescWidget;
    if (widget.loadingTemplate) {
      targetWidget = _loadingTemplate();
      targetDescWidget = _loadingTemplateDesc();
    }
    if(widget.errorTemplate) {
      targetWidget = _errorTemplate();
      targetDescWidget = _errorTemplateDesc();
    }
    return _mainBody(targetWidget ?? _detailsWidget(), targetDescWidget ?? _descWidget());
  }

  Widget _mainBody(Widget detail, Widget overview) => Column(
    children: [
      IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: detail,
        ),
      ),
      SizedBox(height: 12,),
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 16,
          right: 34,
        ),
        child: overview,
      ),
    ],
  );
  Widget _detailsWidget() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _infoHeaderIconCustomWidget(
          AppIcons.calendar,
          DateTime.tryParse(
                widget.movieDetailsModel!.releaseDate!,
              )?.year.toString() ??
              "-",
        ),
        SizedBox(width: 12),
        VerticalDivider(
          width: 1,
          color: Theme.of(context).textTheme.labelSmall!.color,
        ),
        SizedBox(width: 12),
        _infoHeaderIconCustomWidget(
          AppIcons.clock,
          "${widget.movieDetailsModel!.runtime} Minutes",
        ),
        SizedBox(width: 12),
        VerticalDivider(
          width: 1,
          color: Theme.of(context).textTheme.labelSmall!.color,
        ),
        SizedBox(width: 12),
        _infoHeaderIconCustomWidget(
          AppIcons.ticket,
          widget.movieDetailsModel!.genres!.map((e) => e.name).join(", "),
        ),
      ],
    ),
  );

  Widget _descWidget() => Text(
    widget.movieDetailsModel!.overview ?? "UnKnown Descripition",
    style: Theme.of(context).textTheme.labelMedium,
    // textAlign: TextAlign.start,
  );
  Widget _loadingTemplate() => LoadingWidgetSkeleton(
    itemCount: 6,
    itemHeight: 25,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    itemWidth: MediaQuery.of(context).size.width / .5,
    color: Colors.red,
    // alignment: Alignment.center,
    type: LoadingSkeletonType.text,
  );
  Widget _errorTemplate() => Container(
    height: 25,
    width: double.infinity,
    // color: Colors.transparent,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[300],
    ),
    child: Center(child: Icon(Icons.text_fields)),
  );

  Widget _loadingTemplateDesc() => LoadingWidgetSkeleton(
    itemCount: 5,
    itemHeight: 50,
    padding: EdgeInsets.only(top: 5),
    itemWidth: MediaQuery.of(context).size.width,
    borderRadius: BorderRadius.zero,
    scrollDirection: Axis.vertical,
    type: LoadingSkeletonType.description,
  );
  Widget _errorTemplateDesc() => Container(
    height: 50,
    width: double.infinity,
    // color: Colors.transparent,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[300],
    ),
    child: Center(child: Icon(Icons.text_fields)),
  );

  Widget _infoHeaderIconCustomWidget(String iconPath, String text) {
    return Row(
      spacing: 4,
      children: [
        SvgPicture.asset(iconPath),
        Text(text, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
