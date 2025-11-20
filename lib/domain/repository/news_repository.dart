import '../article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    required String country,
    String? category,
    required int page
  });
}