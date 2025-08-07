import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMovieProvider = StateNotifierProvider<MovieNotifier,List<Movie>>(
  (ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlayingMovies;

    return MovieNotifier(fetchMoreMovies: fetchMoreMovies);
  }
);


typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MovieNotifier extends StateNotifier<List<Movie>>{
  final MovieCallBack fetchMoreMovies;
  MovieNotifier({required this.fetchMoreMovies}):super([]);

  int currentPage = 0;
  bool isLoading = false;


  Future<void> loadNextPage() async{
    if (isLoading) return;
    isLoading = true;
    currentPage++;

    final newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
    isLoading = false;
  }
}