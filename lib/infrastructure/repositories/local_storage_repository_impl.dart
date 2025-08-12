import 'package:app_flutter_the_movie/domain/datasources/local_storage_datasource.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepoository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl({required this.datasource});
  @override
  Future<bool> isFavorite(int movieId) {
    return datasource.isFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toogleFavorite(Movie movie) {
    return datasource.toogleFavorite(movie);
  }
}
