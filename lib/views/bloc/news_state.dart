import 'package:equatable/equatable.dart';

import '../../models/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final bool isLastPage;

  NewsLoaded({required this.articles, this.isLastPage = false});

  @override
  List<Object?> get props => [articles, isLastPage];
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
