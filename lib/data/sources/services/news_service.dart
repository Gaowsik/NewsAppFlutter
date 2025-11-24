import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../../models/news_model.dart';
import 'dio.dart';

class NewsService {
  final _apiKey = dotenv.env['API_KEY'];

  final Dio _dio = DioClient().dio;

  Future<NewsResponse> getTopHeadlines({
    required String country,
    String? category,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        "v2/top-headlines",
        queryParameters: {
          "country": country,
          if (category != null) "category": category,
          "page": page,
          "pageSize": pageSize,
          "apiKey": _apiKey,
        },
      );

      return NewsResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        throw Exception(
          "Failed to load news: ${e.response?.statusCode} ${e.response?.statusMessage}",
        );
      } else {
        throw Exception("Failed to load news: ${e.message}");
      }
    }
  }
}
