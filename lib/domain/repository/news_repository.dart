import '../article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    required String country,
    String? category,
    required int page,
  });

  Future<void> saveFavourite(Article article);

  Future<void> removeFavourite(String url);

  Future<List<Article>> getFavourites();

  Future<bool> isFavourite(String url);
}
