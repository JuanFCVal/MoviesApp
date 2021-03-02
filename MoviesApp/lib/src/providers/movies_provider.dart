import 'dart:async';

import 'package:MoviesApp/src/models/movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  String _apiKey = "7772c1372c74f7e1759c17b13a6189c1";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _popularesPage = 0;
  bool _cargando = false;

  List<Movie> _populares = new List();
  final _popularesStreamController = StreamController<List<Movie>>.broadcast();
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  Future<List<Movie>> _procesarRespuesta(Uri uri) async {
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final peliculas = new Movies.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

//Using Future for FutureBuilder
  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url);
  }

//Using Stream for Stream Builder
  Future<List<Movie>> getPopular() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }
}
