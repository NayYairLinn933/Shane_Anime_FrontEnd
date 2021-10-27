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

class CheckPdfOrImagesEvent extends DetailsEvent {
  final String comicId;
  final String episodeName;

  const CheckPdfOrImagesEvent(this.comicId, this.episodeName);

  @override
  List<Object> get props => [comicId, episodeName];
}

class FetchImages extends DetailsEvent {
  final String comicId;
  final String episodeName;

  const FetchImages(this.comicId, this.episodeName);

  @override
  List<Object> get props => [comicId, episodeName];
}
