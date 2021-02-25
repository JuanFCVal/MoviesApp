import 'package:MoviesApp/src/models/movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  String _apiKey = "7772c1372c74f7e1759c17b13a6189c1";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Movie>> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final peliculas = new Movies.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url);
  }
}
