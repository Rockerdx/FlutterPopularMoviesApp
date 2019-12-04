import 'package:flutter_movies_app/model/data.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "http://api.themoviedb.org";
  static const String API_PARAM = "api_key";
  static const String API_KEY = "";
  Client client = Client();

  Future<List<Result>> getProfiles(String sort) async {
    print("$baseUrl/3/movie/" + sort + "?" + API_PARAM + "=" + API_KEY);
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
