import '../../domain/entities/comic.dart';
import '../../domain/entities/episodes.dart';
import '../../domain/entities/photos.dart';

abstract class ComicRemoteDataSource {
  Future<List<Comic>> getRecentComic();
  Future<List<Comic>> getHotComic();
  Future<List<Comic>> getCompleteComic();
  Future<List<Episodes>> getEpisodes(String comicId);
  Future<List<String>> getPhotos(String comicId, String episodeName);
}
