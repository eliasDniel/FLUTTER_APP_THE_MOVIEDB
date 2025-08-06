import '../entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<List<Movie>> getPopularMovies();
}
