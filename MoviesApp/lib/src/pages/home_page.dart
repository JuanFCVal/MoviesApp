import 'package:MoviesApp/src/Widgets/CardSwipper.dart';
import 'package:MoviesApp/src/Widgets/movie_horizontal.dart';
import 'package:MoviesApp/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
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
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

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
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
