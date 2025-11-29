import 'package:bloc/bloc.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/search/data/api/search_api.dart';
import 'package:movie/feature/search/data/models/search_result_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search(String query) async {
    emit(SearchCubitLoading());

    var result = await SearchApiServcies.getSearchMovie(query);

    switch (result) {
      case ApiSuccess<SearchModel>():
        List<Results>? notEmptyList = result.data?.results?.where((movie) {
          return movie.posterPath != null && movie.posterPath!.isNotEmpty;
        }).toList();
        emit(SearchCubitLoaded(notEmptyList));
      case ApiError<SearchModel>():
        emit(SearchCubitError(result.error));
    }
  }
}
