import '../../domain/entities/actor.dart';
import '../models/moviedb/credits_moviedb.dart';

class ActorMapper {
  static Actor castToEntity(Cast actor) => Actor(
    id: actor.id,
    name: actor.name,
    profilePath: actor.profilePath != ''
        ? 'https://image.tmdb.org/t/p/w500${actor.profilePath}'
        : 'https://st.depositphotos.com/2101611/3925/v/450/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
    character: actor.character,
  );
}
