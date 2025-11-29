

import '../../../domain/article.dart';

abstract class FavouriteNewsEvent {}

class GetFavouriteNews extends FavouriteNewsEvent {
  GetFavouriteNews();
}

class ToggleFavouriteInFavouriteDetail extends FavouriteNewsEvent {
  final Article article;
  ToggleFavouriteInFavouriteDetail(this.article);
}
