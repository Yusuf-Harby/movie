part of 'release_movie_cubit.dart';

sealed class ReleaseMovieState {}

final class ReleaseMovieInitial extends ReleaseMovieState {}

final class ReleaseMovieLoading extends ReleaseMovieState {}

final class ReleaseMovieSuccess extends ReleaseMovieState {
  final List<Results>? resultList;
  ReleaseMovieSuccess(this.resultList);
}

final class ReleaseMovieError extends ReleaseMovieState {
  final String message;
  ReleaseMovieError(this.message);
}
