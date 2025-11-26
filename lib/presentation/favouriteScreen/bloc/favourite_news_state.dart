import 'package:equatable/equatable.dart';

import '../../../domain/article.dart';

abstract class FavouriteNewsState extends Equatable {
  @override
  List<Object?> get props => [];

  get articles => null;
}

class NewsInitial extends FavouriteNewsState {}

class FavouriteNewsLoading extends FavouriteNewsState {}

class FavouriteNewsLoaded extends FavouriteNewsState {
  final List<Article> articles;

  FavouriteNewsLoaded({required this.articles});

  @override
  List<Object?> get props => [articles];
}

class FavouriteNewsError extends FavouriteNewsState {
  final String errorMessage;

  FavouriteNewsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
