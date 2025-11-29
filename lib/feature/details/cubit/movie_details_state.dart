part of 'movie_details_cubit.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}
class MovieDetailsLoadingState<T> extends MovieDetailsState {}
class MovieDetailsSuccessState<T> extends MovieDetailsState {
  final T? movieDetailsModel;
  MovieDetailsSuccessState(this.movieDetailsModel);
}


class MovieDetailsErrorState<T> extends MovieDetailsState {
  final String errorMessage;
  MovieDetailsErrorState(this.errorMessage);
}


