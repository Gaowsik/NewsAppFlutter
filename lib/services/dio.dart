import 'package:dio/dio.dart' show Dio, BaseOptions, LogInterceptor;

class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        connectTimeout: Duration(milliseconds: 10000),
        receiveTimeout: Duration(milliseconds: 3000),
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio _dio;

  Dio get dio => _dio;
}