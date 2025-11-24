import '../../../domain/article.dart';

abstract class FavouriteLocalDataSource {
  Future<void> saveFavourite(Article article);
  Future<void> removeFavourite(String url);
  Future<List<Article>> getFavourites();
  Future<bool> isFavourite(String url);
}