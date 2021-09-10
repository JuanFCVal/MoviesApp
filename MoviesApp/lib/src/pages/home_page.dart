import 'package:MoviesApp/src/Widgets/CardSwipper.dart';
import 'package:MoviesApp/src/Widgets/movie_horizontal.dart';
import 'package:MoviesApp/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    final moviesnewProvider = Provider.of<MoviesProvider>(context);
    print(moviesnewProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movies app"),
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //_swiperTarjetas(), //Utilizamos este metodo para construir mediante un future builder haciendo la consulta directamente en la clase.
              CardSwipper(peliculas: moviesnewProvider.onDisplayMovies),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

// Future Builder que construye la clase utilizando el provider de la clase no el global
  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: moviesProvider.getEnCines(),
        //initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CardSwipper(peliculas: snapshot.data);
          } else {
            return Center(
              child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text("Populares",
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 10,
          ),
          MovieHorizontal(movies: moviesProvider.popularMovies),
          // MovieHorizontal(movies: moviesProvider.popularMovies, siguientePagina: moviesProvider.getPopularMovies())
          /*StreamBuilder(
            stream: moviesProvider.popularesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  siguientePagina: moviesProvider.getPopular,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),*/
        ],
      ),
    );
  }
}
