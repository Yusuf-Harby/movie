import 'package:movie/feature/home/data/model/top_movie_model.dart';

abstract class TopState {}

class InitialState extends TopState {}

class LoadingState extends TopState{}

class SuccessState extends TopState{
  SuccessState(this.topMovies);
  List<Results> topMovies;
}

class ErrorState extends TopState{
  String error;
  ErrorState(this.error);
}