import 'package:app_flutter_the_movie/domain/datasources/movies_datasources.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/infrastructure/models/moviedb/movie_details.dart';
import 'package:app_flutter_the_movie/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../mappers/movie_mapper.dart';

class MoviedbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.apiKey, 'language': 'es-mx'},
    ),
  );

  List<Movie> _jsonForMovies(Map<String, dynamic> json) {
    final movieResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((result) => MovieMapper.fromMovieTheMovieDb(result))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonForMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonForMovies(response.data);
  }

  @override
  Future<List<Movie>> getToRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonForMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonForMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie details not found $id');
    }
    final movieDetail = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.fromMovieDetails(movieDetail);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    return _jsonForMovies(response.data);
  }
}
