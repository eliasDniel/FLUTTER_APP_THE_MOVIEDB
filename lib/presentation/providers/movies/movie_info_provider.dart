import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_provider.dart';


// * PROVIDER PARA TRAER UNA SOLA PELICULA Y GUARDAR EN CACHE
final movieInfoProvider = StateNotifierProvider<MovieInfoNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieInfoNotifier(getMovie: getMovie);
});

typedef GetMovieCallBack = Future<Movie> Function(String id);

class MovieInfoNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;
  bool isLoading = false;

  MovieInfoNotifier({required this.getMovie}) : super({});

  Future<void> loadMovieInfo(String id) async {
    if (isLoading) return;
    isLoading = true;

    if (state[id] != null) {
      isLoading = false;
      return;
    }

    final movie = await getMovie(id);
    state = {...state, id: movie};
    isLoading = false;
  }
}
