import 'package:app_flutter_the_movie/domain/entities/actor.dart';
import 'package:app_flutter_the_movie/presentation/providers/actores/actores_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorNotifier, Map<String, List<Actor>>>((ref) {
      final getActores = ref.watch(actorsRepositoryProvider).getCredits;
      return ActorNotifier(getActors: getActores);
    });

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);
class ActorNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;
  bool isLoading = false;

  ActorNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
