import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/services/news_service.dart';
import '../../domain/repository/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  int _page = 1;
  bool _isLastPage = false;
  bool _isLoading = false;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
  }

  get currentState => null;

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    if (_isLoading) return;  // Prevent multiple calls
    _isLoading = true;
    try {
      emit(NewsLoading());
      if (event.loadMore) {
        _page++;
      } else {
        _page = 1;
      }

      final response = await newsRepository.getTopHeadlines(
        country: event.country,
        page: _page,
      );

      if (response.isEmpty) {
        _isLastPage = true;
        emit(NewsLoaded(articles: [], isLastPage: true));
        return;
      }


      emit(NewsLoaded(articles: response, isLastPage: false));


    } catch (error) {
      emit(NewsError(errorMessage: "Something Went Wrong"));
    }finally {
      _isLoading = false;
    }
  }
}
