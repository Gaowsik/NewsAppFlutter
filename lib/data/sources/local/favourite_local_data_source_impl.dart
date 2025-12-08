import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/domain/article.dart';

import '../../../utils/app_strings.dart';
import 'entities/article/article_entity.dart';
import 'favourite_local_data_source.dart';

class FavouriteLocalDataSourceImpl implements FavouriteLocalDataSource {
  @override
  Future<List<Article>> getFavourites() async {
    final box = await Hive.openBox<ArticleEntity>(favouriteBox);
    return box.values.map((e) => e.toDomain()).toList();
  }

  @override
  Future<bool> isFavourite(String url) async {
    final box = await Hive.openBox<ArticleEntity>(favouriteBox);
    return box.containsKey(url);
  }

  @override
  Future<void> removeFavourite(String url) async {
    final box = await Hive.openBox<ArticleEntity>(favouriteBox);
    await box.delete(url);
  }

  @override
  Future<void> saveFavourite(Article article) async {
    final box = await Hive.openBox<ArticleEntity>(favouriteBox);
    await box.put(article.url, ArticleEntity.fromDomain(article));
  }
}
