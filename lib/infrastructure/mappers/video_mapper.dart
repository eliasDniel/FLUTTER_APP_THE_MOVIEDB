import '../../domain/entities/video.dart';
import '../models/moviedb/movie_videos.dart';

class VideoMapper {
  static moviedbVideoToEntity(Result moviedbVideo) => Video(
    id: moviedbVideo.id,
    name: moviedbVideo.name,
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
  );
}
