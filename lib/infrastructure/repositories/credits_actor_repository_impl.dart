import 'package:app_flutter_the_movie/domain/datasources/credits_datasources.dart';
import 'package:app_flutter_the_movie/domain/entities/actor.dart';
import 'package:app_flutter_the_movie/domain/repositories/credits_repository.dart';

class CreditsActorRepositoryImpl extends ActorRepository {
  final CreditsDatasources datasources;

  CreditsActorRepositoryImpl({required this.datasources});
  @override
  Future<List<Actor>> getCredits(String movieId) {
    return datasources.getCredits(movieId);
  }
}
