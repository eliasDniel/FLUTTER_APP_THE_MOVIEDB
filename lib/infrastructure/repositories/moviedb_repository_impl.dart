import 'package:app_flutter_the_movie/domain/entities/movie.dart';

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
  Future<List<Movie>> getPopularMovies() {
    return dataSource.getPopularMovies();
  }
}
