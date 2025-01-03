import 'package:dio/dio.dart';
import 'package:flutter_haber/data/Model/article_model.dart';

class NewsApiService {
  final Dio _dio = Dio();

  // Örnek: newsapi.org üzerinden verileri çekmek için
  // kendinize ait API KEY’i eklemeyi unutmayın.
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'f1a51fc0b9774e078995ef1561e97ba6';

  Future<List<Article>> fetchNews({String category = 'general'}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/top-headlines',
        queryParameters: {
          'country': 'us',
          'category': category,
          'apiKey': _apiKey,
        },
      );

      final data = response.data['articles'] as List;
      return data.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> searchNews(String query) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/everything',
        queryParameters: {
          'q': query,
          'apiKey': _apiKey,
        },
      );

      final data = response.data['articles'] as List;
      return data.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
