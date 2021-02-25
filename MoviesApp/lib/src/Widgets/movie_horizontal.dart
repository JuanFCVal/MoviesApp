import 'package:MoviesApp/src/models/movies.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  MovieHorizontal({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.30,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _tarjetas(context),
      ),
    );
  }

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
  }
}
