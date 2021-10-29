part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchEpisode extends DetailsEvent {
  final String comicId;

  const FetchEpisode(this.comicId);

  @override
  List<Object> get props => [comicId];
}

class FetchGenre extends DetailsEvent {
  final String comicId;

  const FetchGenre(this.comicId);

  @override
  List<Object> get props => [comicId];
}

class ReadNextChapter extends DetailsEvent {
  final String comicId;
  final String episodeName;
  final int episodeNumber;
  final bool next;
  final bool initial;
  final bool prev;

  const ReadNextChapter(this.comicId, this.episodeName, this.episodeNumber,
      this.next, this.initial, this.prev);

  @override
  List<Object> get props =>
      [comicId, episodeName, episodeNumber, next, initial, prev];
}

class CheckPdfOrImagesEvent extends DetailsEvent {
  final String comicId;
  final String episodeName;
  final int episodeNumber;

  const CheckPdfOrImagesEvent(
      this.comicId, this.episodeName, this.episodeNumber);

  @override
  List<Object> get props => [comicId, episodeName, episodeNumber];
}

class FetchImages extends DetailsEvent {
  final String comicId;
  final String episodeName;

  const FetchImages(this.comicId, this.episodeName);

  @override
  List<Object> get props => [comicId, episodeName];
}
