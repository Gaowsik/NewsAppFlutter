import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/news_repository.dart';
import 'favourite_news_event.dart';
import 'favourite_news_state.dart';

@injectable
class FavouriteNewsBloc extends Bloc<FavouriteNewsEvent, FavouriteNewsState> {
  final NewsRepository newsRepository;
  bool _isLoading = false;

  FavouriteNewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<GetFavouriteNews>(_onGetFavouriteNews);
  }

  Future<void> _onGetFavouriteNews(
    GetFavouriteNews event,
    Emitter<FavouriteNewsState> emit,
  ) async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      emit(FavouriteNewsLoading());
      final response = await newsRepository.getFavourites();

      if (response.isEmpty) {
        emit(FavouriteNewsLoaded(articles: []));
        return;
      }

      emit(FavouriteNewsLoaded(articles: response));
    } catch (error) {
      emit(FavouriteNewsError(errorMessage: error.toString()));
    } finally {
      _isLoading = false;
    }
  }
}
