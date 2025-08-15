import 'package:animate_do/animate_do.dart';
import 'package:app_flutter_the_movie/config/helpers/human_formats.dart';
import 'package:app_flutter_the_movie/presentation/providers/actores/actores_provider_state.dart';
import 'package:app_flutter_the_movie/presentation/providers/movies/movie_info_provider.dart';
import 'package:app_flutter_the_movie/presentation/providers/storage/favorite_movies_repository.dart';
import 'package:app_flutter_the_movie/presentation/providers/storage/local_storage_provider.dart';
import 'package:app_flutter_the_movie/presentation/widgets/movies/movie_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../widgets/movies/movie_similar.dart';
import '../../widgets/videos/videos_from_movie.dart';

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
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null && ref.read(movieInfoProvider.notifier).isLoading) {
      return Scaffold(
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(strokeWidth: 2.0),
              SizedBox(height: 10),
              Text('Loading movie...'),
            ],
          ),
        ),
      );
    }
    if (movie == null) {
      return Scaffold(body: const Center(child: Text('Movie not found')));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          CustomSliverAppbar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Build your list items here
                return _MovieDetails(movie: movie);
              },
              childCount: 1, // Number of items in the list
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndOverview(movie: movie, size: size, textStyle: textStyle),
        // * CATEGORIAS
        _Genres(movie: movie),
        // * ACTORES
        _ActorsByMovie(movieId: movie.id.toString()),

        //* Videos de la película (si tiene)
        VideosFromMovie(movieId: movie.id),

        //* Películas similares
        SimilarMovies(movieId: movie.id),
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((genre) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyle,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * IMAGEN
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(movie.posterPath!, width: size.width * 0.3),
          ),
          const SizedBox(width: 10),

          // * TITULO
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleLarge),
                Text(movie.overview),
                SizedBox(height: 10),
                MovieRating(voteAverage: movie.voteAverage),
                Row(
                  children: [
                    Text(
                      'Estreno: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 3),
                    Text(HumanFormats.shortDate(movie.releaseDate)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 50),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: FadeInImage(
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                        'assets/loaders/bottle-loader.gif',
                      ),
                      image: NetworkImage(actor.profilePath),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteRepositoryProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final localStorageRepository = ref.watch(localStorageProvider);
  return localStorageRepository.datasource.isFavorite(movieId);
});

class CustomSliverAppbar extends ConsumerWidget {
  final Movie movie;
  const CustomSliverAppbar({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFvavoriteFuture = ref.watch(isFavoriteRepositoryProvider(movie.id));
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      centerTitle: false,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriotesMoviesProvider.notifier)
                .toogleFavorite(movie);
            ref.invalidate(isFavoriteRepositoryProvider(movie.id));
          },
          icon: isFvavoriteFuture.when(
            data: (isFvorite) => isFvorite
                ? Icon(Icons.favorite_rounded, color: Colors.red)
                : Icon(Icons.favorite_border_rounded),
            error: (_, __) => throw UnimplementedError(),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 0),
        centerTitle: false,
        title: _CustomGradients(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            _CustomGradients(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black87, Colors.transparent],
            ),

            _CustomGradients(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              end: Alignment.centerRight,
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradients extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradients({
    required this.begin,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
