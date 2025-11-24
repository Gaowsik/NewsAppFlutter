import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled/data/repositoryImpl/news_repository_impl.dart';
import 'package:untitled/data/sources/local/favourite_local_data_source_impl.dart';
import 'package:untitled/presentation/bloc/news_bloc.dart';
import 'package:untitled/presentation/bloc/news_event.dart';
import 'package:untitled/presentation/news_list_screen.dart';
import 'package:untitled/utils/app_strings.dart';

import 'data/sources/local/entities/article_entity.dart';
import 'data/sources/services/news_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleEntityAdapter());
  await Hive.openBox<ArticleEntity>(favouriteBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(
        newsRepository: NewsRepositoryImpl(
          NewsService(),
          FavouriteLocalDataSourceImpl(),
        ),
      )..add(FetchNews()), // fetch news on app start
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const NewsScreen(),
      ),
    );
  }
}
