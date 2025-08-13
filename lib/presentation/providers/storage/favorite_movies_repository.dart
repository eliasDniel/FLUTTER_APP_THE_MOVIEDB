import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/domain/repositories/local_storage_repository.dart';
import 'package:app_flutter_the_movie/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriotesMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
      final localStorageRepository = ref.watch(localStorageProvider);
      return FavoriteMoviesNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  int limit = 20;
  final LocalStorageRepoository localStorageRepository;
  FavoriteMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * limit,
      limit: limit,
    );
    page++;
    final Map<int, Movie> moviesMemory = {};
    for (Movie movie in movies) {
      moviesMemory[movie.id] = movie;
    }
    state = {...state, ...moviesMemory};
    return movies;
  }

  Future<void> toogleFavorite(Movie movie) async {
    final isFavorite = await localStorageRepository.toogleFavorite(movie);
    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
