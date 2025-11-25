import 'package:bloc/bloc.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/home/data/api/home_api_servcies.dart';
import 'package:movie/feature/home/data/model/reccomended_movie_model.dart';

part 'recommended_movie_state.dart';

class RecommendedMovieCubit extends Cubit<RecommendedMovieState> {
  RecommendedMovieCubit() : super(RecommendedMovieInitial());

  Future<void> getRecommendedMovies() async {
    emit(RecommendedMovieLoading());
    var result = await HomeApiServcies.getRecommendedMovies();
    switch (result) {
      case ApiSuccess<RecommendedMovieModel>():
        List<Results>? notEmptyList = result.data?.results!.where((movie) {
          return movie.posterPath != null && movie.posterPath!.isNotEmpty;
        }).toList();
        emit(RecommendedSuccess(notEmptyList));
      case ApiError<RecommendedMovieModel>():
        emit(RecommendedMovieError(result.error));
    }
  }
}
