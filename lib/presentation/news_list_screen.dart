import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/news_bloc.dart';
import 'bloc/news_event.dart';
import 'bloc/news_state.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    leading: Image.network(
                      article.imageUrl,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(article.title ?? 'No title'),
                    subtitle: Text(article.publishedDate ?? 'Unknown source'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NewsDetailScreen(articleUrl: article.url),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text("Welcome to News App"));
        },
      ),
    );
  }
}
