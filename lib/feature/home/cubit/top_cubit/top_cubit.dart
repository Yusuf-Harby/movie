import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/home/cubit/top_cubit/top_state.dart';
import 'package:movie/feature/home/data/api/home_api_servcies.dart';
import 'package:movie/feature/home/data/model/top_movie_model.dart';

class TopCubit extends Cubit<TopState> {
  TopCubit() : super(InitialState());
  Future<void> getTopMovies() async {
    emit(LoadingState());
    final result = await HomeApiServcies.getTopMovies();
    switch (result) {
      case ApiSuccess<TopMovieModel>():
        List<Results>? notEmptyList = result.data?.results!.where((movie) {
          return movie.posterPath != null && movie.posterPath!.isNotEmpty;
        }).toList();
        emit(SuccessState(notEmptyList!));
      case ApiError<TopMovieModel>():
        emit(ErrorState(result.error));
    }
  }
}
