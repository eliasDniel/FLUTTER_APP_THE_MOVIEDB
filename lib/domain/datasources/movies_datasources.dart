import 'package:app_flutter_the_movie/domain/entities/video.dart';

import '../entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getUpcomming({int page = 1});
  Future<List<Movie>> getToRated({int page = 1});
  // * PELICULA POR ID
  Future<Movie> getMovieById(String id);
  // * BUSCAR PELICULAS
  Future<List<Movie>> searchMovie(String query);

  // * TRAER RECOMENDADOS
  Future<List<Movie>> getSimilarMovies(int movieId);

  // * TRAER VIDEOS
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
