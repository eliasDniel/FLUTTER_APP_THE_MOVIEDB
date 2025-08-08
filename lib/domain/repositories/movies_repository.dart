import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getUpcomming({int page = 1});
  Future<List<Movie>> getToRated({int page = 1});

    // * PELICULA POR ID
  Future<Movie> getMovieById(String id);
}
