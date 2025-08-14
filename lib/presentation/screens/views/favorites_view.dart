import 'package:app_flutter_the_movie/presentation/providers/storage/favorite_movies_repository.dart';
import 'package:app_flutter_the_movie/presentation/widgets/movies/masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> with AutomaticKeepAliveClientMixin{
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    final movies = await ref
        .read(favoriotesMoviesProvider.notifier)
        .loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final movies = ref.watch(favoriotesMoviesProvider).values.toList();
    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp,color: colors.primary,size: 60,),
          Text('Ohh no!!', style: TextStyle(fontSize: 30,color: colors.primary),),
          Text('No tienes peliculas favoritas', style: TextStyle(color: Colors.black45,fontSize: 20),),
          SizedBox(height: 20,),
          FilledButton.tonal(onPressed: () => context.go('/home/0'), child: Text('Empieza ya!'))
          ],
        ));
    }
    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: movies),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
