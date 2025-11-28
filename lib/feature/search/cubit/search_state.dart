part of 'search_cubit.dart';

class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchCubitLoading extends SearchState {}

final class SearchCubitLoaded extends SearchState {
  final List<Results>? data;
  SearchCubitLoaded(this.data);
}

final class SearchCubitError extends SearchState {
  final String? message;
  SearchCubitError(this.message);
}
