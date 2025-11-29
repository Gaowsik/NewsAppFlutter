import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/favouriteScreen/bloc/favourite_news_bloc.dart';
import 'package:untitled/presentation/favouriteScreen/bloc/favourite_news_state.dart';

import '../../domain/article.dart';
import 'bloc/favourite_news_event.dart';

class FavouriteNewsDetailScreen extends StatelessWidget {
  final String articleUrl;

  const FavouriteNewsDetailScreen({required this.articleUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteNewsBloc, FavouriteNewsState>(
      builder: (context, state) {
        final state = context.read<FavouriteNewsBloc>().state;

        Article? article;

        if (state is FavouriteNewsLoaded) {
          try {
            article = state.articles.firstWhere((a) => a.url == articleUrl);
          } catch (e) {
            article = null;
          }
        }

        if (article == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Article Detail")),
            body: const Center(child: Text("Article not found")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(article.title)),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.imageUrl ?? "",
                  width: double.infinity, // match parent width
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<FavouriteNewsBloc>().add(
                            ToggleFavouriteInFavouriteDetail(article!),
                          );
                        },
                        icon: Icon(
                          article.isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: article.isFavourite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    article.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
