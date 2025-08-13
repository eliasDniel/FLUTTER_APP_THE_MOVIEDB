import 'package:app_flutter_the_movie/domain/datasources/local_storage_datasource.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  IsarDatasource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([MovieSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movieId)
        .findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<bool> toogleFavorite(Movie movie) async {
    final isar = await db;
    final isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst();
    if (isFavoriteMovie != null) {
      // * BORAR LA PELICULA SI LA ENCONTRO
      isar.writeTxnSync(() => isar.movies.deleteSync(isFavoriteMovie.isarId!));
      return true;
    }
    // * INSERTAR LA PELICULA
    isar.writeTxnSync(() => isar.movies.putSync(movie));
   return false;
  }
}
