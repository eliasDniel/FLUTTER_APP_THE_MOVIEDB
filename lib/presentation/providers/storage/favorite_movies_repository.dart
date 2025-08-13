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
  int limit = 10;
  final LocalStorageRepoository localStorageRepository;
  FavoriteMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * limit,
    );
    page++;
    final Map<int, Movie> moviesMemory = {};
    for (Movie movie in movies) {
      moviesMemory[movie.id] = movie;
    }
    state = {...state, ...moviesMemory};
  }
}
