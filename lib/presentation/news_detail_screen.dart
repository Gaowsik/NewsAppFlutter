import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/article.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_state.dart';

class NewsDetailScreen extends StatelessWidget {
  final String articleUrl;

  const NewsDetailScreen({required this.articleUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<NewsBloc>().state;

    Article? article;

    if (state is NewsLoaded) {
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
                article.imageUrl,
                width: double.infinity, // match parent width
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          ]
      ),
      )
    );
  }
}
