import 'package:flutter_haber/data/Model/article_model.dart';
import 'package:flutter_haber/data/Service/news_api_service.dart';

class NewsRepository {
  final NewsApiService newsApiService;

  NewsRepository({required this.newsApiService});

  Future<List<Article>> getTopHeadlines({String category = 'general'}) {
    return newsApiService.fetchNews(category: category);
  }

  Future<List<Article>> searchNews(String query) {
    return newsApiService.searchNews(query);
  }
}
