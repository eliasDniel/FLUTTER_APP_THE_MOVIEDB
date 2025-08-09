


import 'package:app_flutter_the_movie/domain/entities/actor.dart';


abstract class ActorRepository {
  Future<List<Actor>> getCredits( String movieId );
}
