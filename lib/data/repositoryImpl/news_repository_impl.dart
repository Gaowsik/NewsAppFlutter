import 'package:untitled/domain/article.dart';

import '../../domain/repository/news_repository.dart';
import '../services/news_service.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService newsService;

  NewsRepositoryImpl(this.newsService);

  @override
  Future<List<Article>> getTopHeadlines({
    required String country,
    String? category,
    required int page,
  }) async {
    final response = await newsService.getTopHeadlines(
      country: country,
      category: category,
      page: page
    );

    return response.articles.map((e) => e.toDomainModel()).toList();
  }
}
