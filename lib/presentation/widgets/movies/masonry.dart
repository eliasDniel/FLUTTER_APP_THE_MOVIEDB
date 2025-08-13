import 'package:app_flutter_the_movie/presentation/widgets/movies/movies_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../domain/entities/movie.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((_controller.position.pixels + 100) >=
          _controller.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: _controller,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: widget.movies.length,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                SizedBox(height: 30),
                MoviesPosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return MoviesPosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
