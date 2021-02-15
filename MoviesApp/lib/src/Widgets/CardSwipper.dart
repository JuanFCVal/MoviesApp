import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwipper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Swiper(
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network("http://via.placeholder.com/350x150",
                fit: BoxFit.cover),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(alignment: Alignment.topRight),
        //control: new SwiperControl(),
      ),
    );
  }
}
