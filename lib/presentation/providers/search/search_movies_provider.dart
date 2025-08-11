import 'package:app_flutter_the_movie/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchQueryMoviesProvioder = StateNotifierProvider((ref) {
  final searchQuery = ref.watch(movieRepositoryProvider).searchMovie;
  return SearchQueryNotifier(searchQuery: searchQuery, ref: ref);
});

typedef SearchQueryCallback = Future<List<Movie>> Function(String query);

class SearchQueryNotifier extends StateNotifier<List<Movie>> {
  final SearchQueryCallback searchQuery;
  final Ref ref;
  SearchQueryNotifier({required this.searchQuery, required this.ref})
    : super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async {
    final movies = await searchQuery(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
