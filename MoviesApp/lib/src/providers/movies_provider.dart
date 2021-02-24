import 'package:MoviesApp/src/models/movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  String _apiKey = "7772c1372c74f7e1759c17b13a6189c1";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Movies.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
