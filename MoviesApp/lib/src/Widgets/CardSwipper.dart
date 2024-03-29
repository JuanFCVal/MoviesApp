import 'package:MoviesApp/src/models/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> peliculas;

  CardSwipper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    if (this.peliculas.length == 0) {
      return Container(
        width: _screenSize.width * 0.65,
        height: _screenSize.height * 0.5,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Swiper(
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detalle',
                arguments: peliculas[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                fit: BoxFit.cover,
                image: NetworkImage(peliculas[index].getPoster()),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(alignment: Alignment.topRight),
        //control: new SwiperControl(),
      ),
    );
  }
}
