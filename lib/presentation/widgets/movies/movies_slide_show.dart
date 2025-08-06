import 'package:animate_do/animate_do.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            color: colorStyle.secondary,
            activeColor: Colors.blueAccent,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return _SlideMovie(movie: movie);
        },
        // layout: SwiperLayout.STACK,
        // itemWidth: 300,
        // itemHeight: 200,
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {
  final Movie movie;
  const _SlideMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.posterPath!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return FadeIn(child: child);
              return DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
              );
            },
          ),
        ),
      ),
    );
  }
}
