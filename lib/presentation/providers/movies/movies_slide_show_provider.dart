import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers_states.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
  if (nowPlayingMovies.isEmpty)return [];
  return nowPlayingMovies.sublist(0,6);
});
