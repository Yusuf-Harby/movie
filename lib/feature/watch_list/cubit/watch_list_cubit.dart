import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie/core/constants/app_hive.dart';
import 'package:movie/feature/watch_list/cubit/watch_list_state.dart';
import 'package:movie/feature/watch_list/data/models/watch_list_item_model.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit({Box<WatchListItemModel>? box})
    : _watchListBox = box ?? Hive.box<WatchListItemModel>(AppHive.watchListBox),
      super(const WatchListInitial()) {
    loadWatchList();
  }

  final Box<WatchListItemModel> _watchListBox;

  void loadWatchList() {
    final items = _watchListBox.values.toList();
    emit(WatchListLoaded(items));
  }

  bool isMovieSaved(int movieId) {
    return _watchListBox.containsKey(movieId);
  }

  Future<void> toggleMovie(WatchListItemModel item) async {
    final cachedItems = List<WatchListItemModel>.from(state.items);
    try {
      emit(WatchListLoading(cachedItems));
      if (_watchListBox.containsKey(item.id)) {
        await _watchListBox.delete(item.id);
      } else {
        await _watchListBox.put(item.id, item);
      }
      emit(WatchListLoaded(_watchListBox.values.toList()));
    } catch (error) {
      emit(WatchListError(error.toString(), cachedItems));
    }
  }

  Future<void> removeMovie(int movieId) async {
    if (_watchListBox.containsKey(movieId)) {
      await _watchListBox.delete(movieId);
      emit(WatchListLoaded(_watchListBox.values.toList()));
    }
  }
}
