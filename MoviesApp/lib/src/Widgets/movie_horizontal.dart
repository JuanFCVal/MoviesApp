import 'package:MoviesApp/src/models/movies.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function siguientePagina;
  MovieHorizontal({@required this.movies, @required this.siguientePagina});
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.30,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        //children: _tarjetas(context),
        itemBuilder: (context, i) {
          return _tarjeta(context, movies[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Movie pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 14),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                fit: BoxFit.contain,
                height: 160,
                image: NetworkImage(pelicula.getPoster())),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, "detalle", arguments: pelicula);
      },
    );
  }

/*
  List<Widget> _tarjetas(BuildContext context) {
    return movies.map((pelicula) {
      return Container(
        // height: 120,
        //  width: 20,
        margin: EdgeInsets.only(right: 14),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.contain,
                  height: 160,
                  image: NetworkImage(pelicula.getPoster())),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }*/
}
