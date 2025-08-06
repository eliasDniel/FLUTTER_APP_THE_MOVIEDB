


import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie fromMovieTheMovieDb(MovieTheMovieDb movie) {
    return Movie(
      id: movie.id,
      title: movie.title,
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      genreIds: movie.genreIds.map((id) => id.toString()).toList(),
      popularity: movie.popularity,
      video: movie.video,
      overview: movie.overview,
      posterPath: movie.posterPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
      : 'no-poster',
      backdropPath: movie.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
      : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }
}