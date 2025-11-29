import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/favouriteScreen/bloc/favourite_news_bloc.dart';
import 'package:untitled/presentation/favouriteScreen/bloc/favourite_news_state.dart';
import 'package:untitled/presentation/favouriteScreen/favourite_news_detail_screen.dart';

import '../util/network_image_widget.dart';
import 'bloc/favourite_news_event.dart';

class NewsFavouriteScreen extends StatelessWidget {
  const NewsFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteNewsBloc>();
    if (bloc.state is NewsInitial || bloc.state is FavouriteNewsLoaded) {
      bloc.add(GetFavouriteNews());
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Top Headlines")),
      body: BlocBuilder<FavouriteNewsBloc, FavouriteNewsState>(
        builder: (BuildContext context, FavouriteNewsState state) {
          if (state is FavouriteNewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteNewsError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is FavouriteNewsLoaded) {
            final articles = state.articles;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: NetworkImageWidget(
                    imageUrl: article.imageUrl,
                    width: 60,
                  ),
                  title: Text(article.title ?? 'No title'),
                  subtitle: Text(article.publishedDate ?? 'Unknown source'),
                  trailing: Icon(
                    article.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: article.isFavourite ? Colors.red : Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            FavouriteNewsDetailScreen(articleUrl: article.url),
                      ),
                    ).then((_) {
                      // This block runs when returning from SecondScreen
                      context.read<FavouriteNewsBloc>().add(GetFavouriteNews());
                    });
                  },
                );
              },
            );
          }

          return const Center(child: Text("Welcome to News App1"));
        },
      ),
    );
  }
}
