import 'package:MoviesApp/src/Widgets/CardSwipper.dart';
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
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas(),
          ],
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
}
