import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_haber/bloc/news/news_bloc.dart';
import 'package:flutter_haber/bloc/news/news_event.dart';
import 'package:flutter_haber/data/Service/news_api_service.dart';
import 'package:flutter_haber/data/repositories/news_repository.dart';
import 'package:flutter_haber/presentation/screens/home_screen.dart';

void main() {
  // Repos & Services
  final newsApiService = NewsApiService();
  final newsRepository = NewsRepository(newsApiService: newsApiService);

  runApp(MyApp(newsRepository: newsRepository));
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository;

  const MyApp({super.key, required this.newsRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => NewsBloc(newsRepository)..add(FetchNewsEvent()),
        child: HomeScreen(),
      ),
    );
  }
}
