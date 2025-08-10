import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delagate.dart';
import '../../providers/providers.dart';

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
            final searchRepository = ref.read(movieRepositoryProvider);
            showSearch<Movie?>(
              context: context,
              delegate: SearchMovieDelagate(searchRepository.searchMovie),
            ).then((movie) {
              if (movie == null) return;
              if (context.mounted) {
                context.push('/home/movie/${movie.id}');
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
