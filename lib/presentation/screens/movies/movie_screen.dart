import 'package:app_flutter_the_movie/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String routeName = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovieInfo(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null && ref.read(movieInfoProvider.notifier).isLoading) {
      return Scaffold(
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(strokeWidth: 2.0),SizedBox(height: 10,),Text('Loading movie...')],
          ),
        ),
      );
    }
    if (movie == null) {
      return Scaffold(body: const Center(child: Text('Movie not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Movie Details - ${movie.title}')),
    );
  }
}
