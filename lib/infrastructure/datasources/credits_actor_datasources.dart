import 'package:app_flutter_the_movie/config/constants/environment.dart';
import 'package:app_flutter_the_movie/domain/datasources/credits_datasources.dart';
import 'package:app_flutter_the_movie/domain/entities/actor.dart';
import 'package:app_flutter_the_movie/infrastructure/mappers/actor_mapper.dart';
import 'package:app_flutter_the_movie/infrastructure/models/moviedb/credits_moviedb.dart';
import 'package:dio/dio.dart';

class CreditsActorDatasources extends CreditsDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.apiKey, 'language': 'es-mx'},
    ),
  );

  List<Actor> _jsonForMovies(Map<String, dynamic> json) {
    final movieResponse = CreditsResponse.fromJson(json);
    final List<Actor> movies = movieResponse.cast
        .map((result) => ActorMapper.castToEntity(result))
        .toList();
    return movies;
  }

  @override
  Future<List<Actor>> getCredits(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    return _jsonForMovies(response.data);
  }
}
