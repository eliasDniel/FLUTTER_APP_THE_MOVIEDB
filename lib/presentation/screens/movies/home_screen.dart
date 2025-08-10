import 'package:app_flutter_the_movie/presentation/providers/providers.dart';
import 'package:app_flutter_the_movie/presentation/screens/screens.dart';
import 'package:app_flutter_the_movie/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delagate.dart';
import '../../widgets/shared/custom_bottom_navigator.dart';
import '../../widgets/shared/custom_sliver_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigator(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
    ref.read(moviesUpcomingProvider.notifier).loadNextPage();
    ref.read(moviesPopularProvider.notifier).loadNextPage();
    ref.read(moviesTopRatedProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) {
      return const FullScreenLoader();
    }

    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final popularMovies = ref.watch(moviesPopularProvider);
    final upcomingMovies = ref.watch(moviesUpcomingProvider);
    final topRatedMovies = ref.watch(moviesTopRatedProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(
      slivers: [
        CustomSliverAppbar2(ref: ref,),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // CustomAppbar(),
                MoviesSlideShow(movies: moviesSlideShow),
                MoviesHorizontalListview(
                  title: 'En cines',
                  subtitle: '20 En cines',
                  loadnextPage: ref
                      .read(nowPlayingMovieProvider.notifier)
                      .loadNextPage,
                  movies: nowPlayingMovies,
                ),

                MoviesHorizontalListview(
                  title: 'Proximamente',
                  // subtitle: '20 Populares',
                  loadnextPage: ref
                      .read(moviesUpcomingProvider.notifier)
                      .loadNextPage,
                  movies: upcomingMovies,
                ),
                MoviesHorizontalListview(
                  title: 'Populares',
                  // subtitle: '20 Populares',
                  loadnextPage: ref
                      .read(moviesPopularProvider.notifier)
                      .loadNextPage,
                  movies: popularMovies,
                ),

                MoviesHorizontalListview(
                  title: 'Mejor Calificadas',
                  // subtitle: '20 Populares',
                  loadnextPage: ref
                      .read(moviesTopRatedProvider.notifier)
                      .loadNextPage,
                  movies: topRatedMovies,
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}


