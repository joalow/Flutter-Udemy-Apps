import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: 10,
          layout: SwiperLayout.STACK,
          itemHeight: size.height * 0.4,
          itemWidth: size.width * 0.5,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: 'movie-instance'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
