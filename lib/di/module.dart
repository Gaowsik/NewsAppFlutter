import 'package:injectable/injectable.dart';

import '../data/repositoryImpl/news_repository_impl.dart';
import '../data/sources/local/favourite_local_data_source.dart';
import '../data/sources/local/favourite_local_data_source_impl.dart';
import '../data/sources/services/news_service.dart';
import '../domain/repository/news_repository.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  NewsService get newsService => NewsService();

  @lazySingleton
  FavouriteLocalDataSource get localDataSource => FavouriteLocalDataSourceImpl();

  @lazySingleton
  NewsRepository get newsRepository => NewsRepositoryImpl(newsService, localDataSource);
}