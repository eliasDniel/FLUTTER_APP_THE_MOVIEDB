import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie extends HiveObject {
  @HiveField(0)
  bool adult;

  @HiveField(1)
  String? backdropPath;

  @HiveField(2)
  List<String> genreIds;

  @HiveField(3)
  int id;

  @HiveField(4)
  String originalLanguage;

  @HiveField(5)
  String originalTitle;

  @HiveField(6)
  String overview;

  @HiveField(7)
  double popularity;

  @HiveField(8)
  String? posterPath;

  @HiveField(9)
  DateTime releaseDate;

  @HiveField(10)
  String title;

  @HiveField(11)
  bool video;

  @HiveField(12)
  double voteAverage;

  @HiveField(13)
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}