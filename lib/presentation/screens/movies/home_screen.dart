import 'package:app_flutter_the_movie/presentation/providers/movies/movies_providers_states.dart';
import 'package:app_flutter_the_movie/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _HomeView());
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
    return Column(
      children: [
        CustomAppbar(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: nowPlayingMovies.length,
            itemBuilder: (context, index) {
              final movie = nowPlayingMovies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.overview),
                leading: Image.network(movie.posterPath!,fit: BoxFit.cover,),
              );
            },
          ),
        ),
      ],
    );
  }
}
