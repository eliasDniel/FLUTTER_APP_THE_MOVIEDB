import 'package:app_flutter_the_movie/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toogleFavorite(Movie movie);
  Future<bool> isFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
