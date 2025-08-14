import 'package:app_flutter_the_movie/presentation/providers/movies/movies_providers_states.dart';
import 'package:app_flutter_the_movie/presentation/widgets/movies/masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesPopularProvider);
    super.build(context);
    return Scaffold(
      body: MovieMasonry(
        loadNextPage: ref.read(moviesPopularProvider.notifier).loadNextPage,
        movies: movies,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
