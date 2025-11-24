import 'package:untitled/domain/article.dart';

import '../../domain/repository/news_repository.dart';
import '../sources/local/favourite_local_data_source.dart';
import '../sources/services/news_service.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService newsService;
  final FavouriteLocalDataSource localDataSource;

  NewsRepositoryImpl(this.newsService, this.localDataSource);

  @override
  Future<List<Article>> getTopHeadlines({
    required String country,
    String? category,
    required int page,
  }) async {
    final response = await newsService.getTopHeadlines(
      country: country,
      category: category,
      page: page,
    );

    final articles = response.articles.map((e) => e.toDomainModel()).toList();
    final favUrls = (await localDataSource.getFavourites())
        .map((a) => a.url)
        .toSet();

    for (var article in articles) {
      if (favUrls.contains(article.url)) {
        article.isFavourite = true;
      }
    }

    return articles;
  }

  @override
  Future<List<Article>> getFavourites() => localDataSource.getFavourites();

  @override
  Future<bool> isFavourite(String url) => localDataSource.isFavourite(url);

  @override
  Future<void> removeFavourite(String url) =>
      localDataSource.removeFavourite(url);

  @override
  Future<void> saveFavourite(Article article) =>
      localDataSource.saveFavourite(article);
}
