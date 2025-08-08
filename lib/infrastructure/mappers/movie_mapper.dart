


import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_details.dart';
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


  static Movie fromMovieDetails(MovieDetails movieDetails) {
    return Movie(
      id: movieDetails.id,
      title: movieDetails.title,
      adult: movieDetails.adult,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      genreIds: movieDetails.genres.map((genre) => genre.name).toList(),
      popularity: movieDetails.popularity,
      video: movieDetails.video,
      overview: movieDetails.overview,
      posterPath: movieDetails.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
          : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      backdropPath: movieDetails.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}'
          : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      releaseDate: movieDetails.releaseDate,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount,
    );
  }
}