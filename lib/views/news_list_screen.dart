import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/news_service.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_event.dart';
import 'bloc/news_state.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsBloc(newsService: NewsService())..add(FetchNews()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Top Headlines")),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is NewsLoaded) {
              final articles = state.articles;
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!state.isLastPage &&
                      scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                    context.read<NewsBloc>().add(FetchNews(loadMore: true));
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ListTile(
                      leading: article.urlToImage != null
                          ? Image.network(
                              article.urlToImage!,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.article),
                      title: Text(article.title ?? 'No title'),
                      subtitle: Text(article.source?.name ?? 'Unknown source'),
                    );
                  },
                ),
              );
            }

            return const Center(child: Text("Welcome to News App"));
          },
        ),
      ),
    );
  }
}
