import 'package:MoviesApp/src/models/actors.dart';
import 'package:MoviesApp/src/models/movies.dart';
import 'package:MoviesApp/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie pelicula = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _crearAppBar(pelicula),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            height: 10,
          ),
          _posterTitle(pelicula, context),
          _descripcion(pelicula),
          _descripcion(pelicula),
          _descripcion(pelicula),
          _descripcion(pelicula),
          _crearCasting(pelicula),
        ]))
      ],
    ));
  }

  Widget _crearAppBar(Movie pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 20),
        ),
        background: FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(pelicula.getBackground()),
            placeholder: AssetImage('assets/loading.gif')),
      ),
    );
  }

  Widget _posterTitle(Movie pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.getPoster()),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _descripcion(Movie pelicula) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Text(pelicula.overview, textAlign: TextAlign.justify),
    );
  }

  _crearCasting(Movie pelicula) {
    final peliprovider = new MoviesProvider();
    /*FutureBuilder(
      future: peliprovider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActores(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );*/
  }

  Widget _crearActores(List<Actor> actores) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemCount: actores.length,
          itemBuilder: (context, i) {
            return Text("hola");
          }),
    );
  }
}
