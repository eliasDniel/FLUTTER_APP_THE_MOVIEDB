import 'package:app_flutter_the_movie/presentation/providers/storage/favorite_movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriotesMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriotesMoviesProvider).values.toList();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Favorites View')),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(title: Text(movie.title));
        },
      ),
    );
  }
}
