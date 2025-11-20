abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String country;
  final bool loadMore;

  FetchNews({this.country = 'us', this.loadMore = false});
}