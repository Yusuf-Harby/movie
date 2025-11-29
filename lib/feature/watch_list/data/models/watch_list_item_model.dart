import 'package:hive/hive.dart';
import 'package:movie/core/constants/app_hive.dart';
import 'package:movie/feature/details/data/models/movie_details_model.dart';

class WatchListItemModel {
  WatchListItemModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
  });

  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;

  factory WatchListItemModel.fromMovieDetails(MovieDetailsModel movie) {
    return WatchListItemModel(
      id: movie.id ?? 0,
      title: movie.title ?? movie.originalTitle ?? 'Unknown',
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
    );
  }
}

class WatchListItemModelAdapter extends TypeAdapter<WatchListItemModel> {
  @override
  int get typeId => AppHive.watchListItemTypeId;

  @override
  WatchListItemModel read(BinaryReader reader) {
    final id = reader.read() as int;
    final title = reader.read() as String;
    final posterPath = reader.read() as String?;
    final backdropPath = reader.read() as String?;
    final releaseDate = reader.read() as String?;
    final voteAverage = reader.read() as double?;

    return WatchListItemModel(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
    );
  }

  @override
  void write(BinaryWriter writer, WatchListItemModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.title)
      ..write(obj.posterPath)
      ..write(obj.backdropPath)
      ..write(obj.releaseDate)
      ..write(obj.voteAverage);
  }
}
