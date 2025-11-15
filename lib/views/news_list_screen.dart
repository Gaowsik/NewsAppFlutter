import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/news_viewmodel.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  late final NewsViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = NewsViewModel();
    vm.fetchBooks(country: 'us');
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        vm.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Scaffold(
        appBar: AppBar(title: const Text("Top Headlines")),
        body: Consumer<NewsViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.state) {
              case ViewState.loading:
                return const Center(child: CircularProgressIndicator());
              case ViewState.error:
                return Center(
                  child: Text(
                    viewModel.errorMessage ?? "Something went wrong",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              case ViewState.loaded:
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: viewModel.articles.length,
                  itemBuilder: (context, index) {
                    final article = viewModel.articles[index];
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
                );
              case ViewState.idle:
              default:
                return const Center(child: Text("Welcome to News App"));
            }
          },
        ),
      ),
    );
  }
}
