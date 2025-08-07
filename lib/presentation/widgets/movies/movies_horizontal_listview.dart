import 'package:animate_do/animate_do.dart';
import 'package:app_flutter_the_movie/config/helpers/human_formats.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? loadnextPage;
  final List<Movie> movies;
  const MoviesHorizontalListview({
    super.key,
    this.title,
    this.subtitle,
    this.loadnextPage,
    required this.movies,
  });

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.loadnextPage == null) return;
      if ((_scrollController.position.pixels + 200) >=
          _scrollController.position.maxScrollExtent) {
        debugPrint('Cargando siguiente pagina');
        widget.loadnextPage!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return _Slide(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* IMAGEN
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(
                movie.posterPath!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return FadeIn(child: child);
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),

          //* tiotulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_sharp, color: Colors.yellow.shade800),
                SizedBox(width: 3),
                Text(
                  movie.voteAverage.toString(),
                  style: textStyle.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                Spacer(),
                Text(
                  HumanFormats.formatNumber(movie.popularity),
                  style: textStyle.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
