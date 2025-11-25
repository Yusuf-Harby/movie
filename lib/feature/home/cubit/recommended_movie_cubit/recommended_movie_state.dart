part of 'recommended_movie_cubit.dart';

sealed class RecommendedMovieState {}

final class RecommendedMovieInitial extends RecommendedMovieState {}

final class RecommendedMovieLoading extends RecommendedMovieState {}

final class RecommendedSuccess extends RecommendedMovieState {
  final List<Results>? resultList;
  RecommendedSuccess(this.resultList);
}

final class RecommendedMovieError extends RecommendedMovieState {
  final String message;
  RecommendedMovieError(this.message);
}
