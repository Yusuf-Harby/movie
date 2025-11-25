import 'package:bloc/bloc.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/home/data/api/recomended_realise_api.dart';
import 'package:movie/feature/home/data/model/releases_movie_model.dart';

part 'release_movie_state.dart';

class ReleaseMovieCubit extends Cubit<ReleaseMovieState> {
  ReleaseMovieCubit() : super(ReleaseMovieInitial());

  Future<void> getReleasesMovies() async {
    emit(ReleaseMovieLoading());
    var result = await RecomendedRealiseApi.getReleasesMovies();

    switch (result) {
      case ApiSuccess<ReleasesMovieModel>():
        List<Results>? notEmptyList = result.data?.results!.where((movie) {
          return movie.posterPath != null && movie.posterPath!.isNotEmpty;
        }).toList();
        emit(ReleaseMovieSuccess(notEmptyList));
      case ApiError<ReleasesMovieModel>():
        emit(ReleaseMovieError(result.error));
    }
  }
}
