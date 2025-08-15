import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/domain/entities/video.dart';

import '../../domain/datasources/movies_datasources.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviedbRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;
  MoviedbRepositoryImpl(this.dataSource);
  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) {
    return dataSource.getNowPlayingMovies(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return dataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getToRated({int page = 1}) {
    return dataSource.getToRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) {
    return dataSource.getUpcomming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return dataSource.searchMovie(query);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return dataSource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return dataSource.getYoutubeVideosById(movieId);
  }
}
