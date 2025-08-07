import 'package:app_flutter_the_movie/presentation/providers/providers.dart';
import 'package:app_flutter_the_movie/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/shared/custom_bottom_navigator.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideShow(movies: moviesSlideShow),
        MoviesHorizontalListview(
          title: 'En cines',
          subtitle: '20 En cines',
          loadnextPage: ref.read(nowPlayingMovieProvider.notifier).loadNextPage,
          movies: nowPlayingMovies,
        ),
      ],
    );
  }
}
