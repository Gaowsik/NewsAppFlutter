import 'package:flutter/foundation.dart';

import '../models/news_model.dart';
import '../services/news_service.dart';

enum ViewState { idle, loading, loaded, error }

class NewsViewModel extends ChangeNotifier {
  final NewsService _newsService = NewsService();
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  int _page = 1;
  bool _isLoadingMore = false;
  bool _isLastPage = false;

  Future<void> fetchBooks({
    String country = 'us',
    bool loadMore = false,
  }) async {
    if (loadMore) {
    } else {
      _setState(ViewState.loading);
    }
    try {
      final response = await _newsService.getTopHeadlines(
        country: country,
        page: _page,
      );

      if (response.articles.isEmpty) {
        _isLastPage = true;
        _setState(ViewState.loaded);
        return;
      }
      if (loadMore) {
        _articles.addAll(response.articles);
      } else {
        _articles = response.articles;
      }
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    _setState(ViewState.idle);
  }

  void loadMore() {
    if (_isLoadingMore || _isLastPage) return;
    _isLoadingMore = true;
    _page++;
    fetchBooks(loadMore: true);
  }
}
