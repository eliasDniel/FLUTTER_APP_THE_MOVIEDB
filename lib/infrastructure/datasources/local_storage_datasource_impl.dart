import 'package:app_flutter_the_movie/domain/datasources/local_storage_datasource.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:hive/hive.dart';

class HiveDatasource extends LocalStorageDatasource {
  late Box<Movie> movieBox;

  HiveDatasource() {
    openBox();
  }

  Future<void> openBox() async {
    movieBox = await Hive.openBox<Movie>('movies');
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    await openBox();
    return movieBox.values.any((movie) => movie.id == movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    await openBox();
    final movies = movieBox.values.toList();
    return movies.skip(offset).take(limit).toList();
  }

  @override
  Future<bool> toogleFavorite(Movie movie) async {
    await openBox();
    final existingKey = movieBox.keys.firstWhere(
      (key) => movieBox.get(key)?.id == movie.id,
      orElse: () => null,
    );
    if (existingKey != null) {
      await movieBox.delete(existingKey);
      return true;
    } else {
      await movieBox.add(movie);
      return false;
    }
  }
}