import 'package:flutter/material.dart';
import 'package:films_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          elevation: 10.0,
          actions: [
            IconButton(
                onPressed: () => print(''), icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: CardSwiper(),
            ),
            SizedBox(
              height: 5.0,
            ),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
          ]),
        ));
  }
}
