import 'package:flutter_movies_app/models/data.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "http://api.themoviedb.org";
  static const String API_PARAM = "api_key";
  static const String API_KEY = "9c11e1693a8fbaa62bb4172d6f2132c8";
  Client client = Client();

  Future<List<Result>> getMovies(String sort) async {
    final response = await client
        .get("$baseUrl/3/movie/" + sort + "?" + API_PARAM + "=" + API_KEY);
    if (response.statusCode == 200) {
      Data data = dataFromJson(response.body);
      print(response.body);
      return data.results;
    } else {
      return null;
    }
  }
}
