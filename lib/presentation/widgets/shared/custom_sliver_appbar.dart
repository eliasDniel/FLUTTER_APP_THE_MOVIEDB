import 'package:app_flutter_the_movie/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delagate.dart';

class CustomSliverAppbar2 extends StatelessWidget {
  const CustomSliverAppbar2({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Icon(Icons.movie_outlined),
      floating: true,
      title: Text('EK FilmApp', style: Theme.of(context).textTheme.titleMedium),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            final searchMoviesRepository = ref.read(searchQueryMoviesProvioder);
            final searchQuery = ref.read(searchQueryProvider);
            showSearch<Movie?>(
              query: searchQuery,
              context: context,
              delegate: SearchMovieDelagate(
                initialMovies: searchMoviesRepository,
                searchMoviesCallback: ref
                    .read(searchQueryMoviesProvioder.notifier)
                    .searchMovieByQuery,
              ),
            ).then((movie) {
              if (movie == null) return;
              if (context.mounted) {
                context.push('/home/0/movie/${movie.id}');
              }
            });
          },
        ),
      ],
      // flexibleSpace: const FlexibleSpaceBar(
      //   title: CustomAppbar()),
    );
  }
}
