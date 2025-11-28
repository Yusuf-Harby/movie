import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/app_assets.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:movie/core/constants/app_strings.dart';
import 'package:movie/core/dialogs/app_toasts.dart';
import 'package:movie/core/dialogs/loading_skeletonizer.dart';
import 'package:movie/feature/details/cubit/movie_details_cubit.dart';
import 'package:movie/feature/details/data/models/movie_details_model.dart';
import 'package:movie/feature/details/data/models/related_movie_details_model.dart';
import 'package:movie/feature/details/view/widgets/movie_banner_custom_widget.dart';
import 'package:movie/feature/details/view/widgets/movie_details_status_custom_widget.dart';
import 'package:movie/feature/details/view/widgets/movie_poster_title_custom_widget.dart';
import 'package:movie/feature/details/view/widgets/movie_related_list_custom_widget.dart';
import 'package:toastification/toastification.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = '/details';

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        toolbarHeight: 65,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(AppIcons.back),
              onPressed: _onBackPressed,
            ),
            const Text(AppStrings.details),
            IconButton(
              icon: SvgPicture.asset(
                isSaved ? AppIcons.saveFilled : AppIcons.save,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              onPressed: _onSavedPressed, //@ TODO: Read/Write to DB
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _toHandleRepeatedBloc<MovieDetailsModel>(
              movieDetailsCubit,
              (state) => MovieBannerCustomWidget(
                rateValue: state.movieDetailsModel?.voteAverage ?? -1,
                backdropPath: state.movieDetailsModel!.backdropPath,
              ),
              loadingState: MovieBannerCustomWidget(loadingTemplate: true),
              errorState: (error) => MovieBannerCustomWidget(
                errorTemplate: true,
                errorMsg: error,
              ),  
            ),
            _toHandleRepeatedBloc<MovieDetailsModel>(
              movieDetailsCubit,
              (state) => MoviePosterTitleCustomWidget(
                title: state.movieDetailsModel!.title,
                posterUrl: state.movieDetailsModel!.posterPath,
              ),
              loadingState: MoviePosterTitleCustomWidget(loadingTemplate: true),
              errorState: (error) => MoviePosterTitleCustomWidget(
                errorTemplate: true,
                errorMsg: error,
              ),
            ),
            SizedBox(height: 16),
            _toHandleRepeatedBloc<MovieDetailsModel>(
              movieDetailsCubit,
              (state) => MovieDetailsStatusCustomWidget(
                movieDetailsModel: state.movieDetailsModel,
              ),
              loadingState: MovieDetailsStatusCustomWidget(
                loadingTemplate: true,
              ),
              errorState: (error) => MovieDetailsStatusCustomWidget(
                errorTemplate: true,
                errorMsg: error,
              ),
            ),
            SizedBox(height: 12),
            _toHandleRepeatedBloc<RelatedMovieDetailsModel>(
              relatedMovieDetailsCubit,
              (state) => MovieRelatedListCustomWidget(
                results: state.movieDetailsModel,
                onTap: _onRelatedMoviePressed,
              ),
              loadingState: MovieRelatedListCustomWidget(loadingTemplate: true),
              errorState: (error) => MovieRelatedListCustomWidget(
                errorTemplate: true,
                errorMsg: error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBackPressed() {
    movieDetailsCubit.close();
    relatedMovieDetailsCubit.close();
    Navigator.of(context).pop();
  }

  void _onSavedPressed() {
    isSaved = !isSaved;
  }

  Widget _onErrorState(
    String errorMsg, {
    double hieght = 50,
    Widget? errorWidget,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => AppToast.showToast(
        context: context,
        title: "Error",
        description: errorMsg,
        type: ToastificationType.error,
      ),
    );
    return errorWidget ??
        Container(
          height: hieght,
          width: double.infinity,
          // color: Colors.transparent,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[300],
          ),
          child: Center(child: Icon(Icons.image_not_supported_sharp)),
        );
  }

  Widget _toHandleRepeatedBloc<T>(
    MovieDetailsCubit? cubit,
    Widget Function(MovieDetailsSuccessState<T>) onSuccessCallback, {
    Widget? loadingState,
    Widget Function(String)? errorState,
  }) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is MovieDetailsLoadingState<T>) {
          return loadingState ?? LoadingWidgetSkeleton();
        }
        if (state is MovieDetailsSuccessState<T>) {
          return onSuccessCallback(state);
        }
        if (state is MovieDetailsErrorState<T>) {
          return _onErrorState(
            state.errorMessage,
            errorWidget: errorState == null
                ? null
                : errorState(state.errorMessage),
          );
        }
        return Center(
          child: Text(
            "UnKnown Error",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
    );
  }

  void _onRelatedMoviePressed(int movieId) {
    Navigator.of(
      context,
    ).pushNamed(DetailsScreen.routeName, arguments: movieId);
  }

  bool isSaved = false;

  late MovieDetailsCubit movieDetailsCubit;
  late MovieDetailsCubit relatedMovieDetailsCubit;
  int? movieId;

  @override
  void initState() {
    super.initState();
    movieDetailsCubit = MovieDetailsCubit();
    relatedMovieDetailsCubit = MovieDetailsCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieId ??= ModalRoute.of(context)!.settings.arguments as int;
      if (movieId != null) {
        movieDetailsCubit.getMovieDetails(movieId!);
        relatedMovieDetailsCubit.getRelatedMoviesDetails(movieId!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailsCubit.close();
    relatedMovieDetailsCubit.close();
  }
}
