import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/data/repositoryImpl/news_repository_impl.dart';
import 'package:untitled/data/services/news_service.dart';
import 'package:untitled/presentation/bloc/news_bloc.dart';
import 'package:untitled/presentation/bloc/news_event.dart';
import 'package:untitled/presentation/news_list_screen.dart';

import 'domain/repository/news_repository.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(
        newsRepository: NewsRepositoryImpl(NewsService()),
      )..add(FetchNews()),   // fetch news on app start
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
