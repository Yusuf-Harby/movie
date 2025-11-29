import 'package:movie/feature/watch_list/data/models/watch_list_item_model.dart';

abstract class WatchListState {
  const WatchListState(this.items);

  final List<WatchListItemModel> items;
}

class WatchListInitial extends WatchListState {
  const WatchListInitial() : super(const []);
}

class WatchListLoading extends WatchListState {
  const WatchListLoading(super.items);
}

class WatchListLoaded extends WatchListState {
  const WatchListLoaded(super.items);

  bool contains(int movieId) =>
      items.any((watchListItem) => watchListItem.id == movieId);
}

class WatchListError extends WatchListState {
  const WatchListError(this.message, super.items);

  final String message;
}
