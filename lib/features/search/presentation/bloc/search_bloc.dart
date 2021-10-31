import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/strings/constants.dart';
import '../../../home/domain/entities/comic.dart';

import '../../../../core/error/failure.dart';

import '../../domain/usecases/search_comic_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchComicUseCase _searchComicUseCase;
  SearchBloc(this._searchComicUseCase) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchComicEvent) {
      yield SearchLoading();

      final failureOrSuccess =
          await _searchComicUseCase.call(query: event.query);

      yield* _eitherSuccessOrErrorState(failureOrSuccess);
    }
  }

  Stream<SearchState> _eitherSuccessOrErrorState(
    Either<Failure, List<Comic>> failureOrSuccess,
  ) async* {
    yield failureOrSuccess.fold(
      (failure) => SearchError(message: _mapFailureToMessage(failure)),
      (searchComics) => SearchLoaded(searchComics: searchComics),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverMessage;

      default:
        return 'Unexpected Error';
    }
  }
}
