import 'package:dio/dio.dart';
import 'package:flutter_movies_app/interceptor/logging_interceptor.dart';
import 'package:flutter_movies_app/models/data.dart';

class ApiService {
  final String baseUrl = "http://api.themoviedb.org";
  static const String API_PARAM = "api_key";
  static const String API_KEY = "9c11e1693a8fbaa62bb4172d6f2132c8";
  Dio _dio;
  ApiService() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<List<Result>> getMovies(String sort) async {
    final response =
        await _dio.get("$baseUrl/3/movie/$sort?$API_PARAM=$API_KEY");
    if (response.statusCode == 200) {
      Data data = dataFromJson(response.data);
//      print(response.data);
      return data.results;
    } else {
      return null;
    }
  }
}
