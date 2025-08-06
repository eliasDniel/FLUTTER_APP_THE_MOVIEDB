import 'package:app_flutter_the_movie/domain/datasources/movies_datasources.dart';
import 'package:app_flutter_the_movie/domain/entities/movie.dart';
import 'package:app_flutter_the_movie/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../mappers/movie_mapper.dart';

class MoviedbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.apiKey, 'language': 'en-US'},
    ),
  );

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map((result) => MovieMapper.fromMovieTheMovieDb(result)).toList();
    return movies;
  }

  @override
  Future<List<Movie>> getPopularMovies() {
    throw UnimplementedError();
  }
}
