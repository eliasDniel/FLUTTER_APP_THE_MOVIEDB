import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../widgets/movies/movies_horizontal_listview.dart';
import '../../widgets/movies/movies_slide_show.dart';
import '../../widgets/shared/custom_sliver_appbar.dart';
import '../../widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{
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
    super.build(context);
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
        CustomSliverAppbar2(ref: ref),

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
  
  @override
  bool get wantKeepAlive => true;
}
