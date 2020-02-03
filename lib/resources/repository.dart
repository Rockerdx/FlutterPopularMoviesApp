import 'dart:async';
import 'api_service.dart';
import '../models/data.dart';

class Repository {
  final moviesApiProvider = ApiService();

  Future<List<Result>> fetchAllMovies(String sort) =>
      moviesApiProvider.getMovies(sort);
}
