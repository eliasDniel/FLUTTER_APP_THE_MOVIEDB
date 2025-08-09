




import 'package:app_flutter_the_movie/infrastructure/datasources/credits_actor_datasources.dart';
import 'package:app_flutter_the_movie/infrastructure/repositories/credits_actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// * INSTANCIA DE MI DATASOURCE IMPLEMENTATION

final actorsRepositoryProvider = Provider((ref) {
  return CreditsActorRepositoryImpl( datasources: CreditsActorDatasources() );
});