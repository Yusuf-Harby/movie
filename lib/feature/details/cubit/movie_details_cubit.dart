import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/details/data/api/details_api.dart';
import 'package:movie/feature/details/data/models/movie_details_model.dart';
import 'package:movie/feature/details/data/models/related_movie_details_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState<MovieDetailsModel>());
    final movieDetails = await DetailsApi.getMovieDetails(movieId);
    switch (movieDetails) {
      case ApiSuccess<MovieDetailsModel>():
        emit(MovieDetailsSuccessState<MovieDetailsModel>(movieDetails.data));
      case ApiError<MovieDetailsModel>():
        emit(MovieDetailsErrorState<MovieDetailsModel>(movieDetails.error));
    }
  }

  Future<void> getRelatedMoviesDetails(int movieId) async {
    emit(MovieDetailsLoadingState<RelatedMovieDetailsModel>());
    final movieDetails = await DetailsApi.getRelatedMoviesToMovie(movieId);
    switch (movieDetails) {
      case ApiSuccess<RelatedMovieDetailsModel>():
        emit(
          MovieDetailsSuccessState<RelatedMovieDetailsModel>(movieDetails.data),
        );
      case ApiError<RelatedMovieDetailsModel>():
        emit(
          MovieDetailsErrorState<RelatedMovieDetailsModel>(movieDetails.error),
        );
    }
  }
}
