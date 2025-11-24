import '../../domain/article.dart';

abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String country;
  final bool loadMore;

  FetchNews({this.country = 'us', this.loadMore = false});
}

class ToggleFavourite extends NewsEvent {
  final Article article;
  ToggleFavourite(this.article);
}