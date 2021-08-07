import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(
            height: 20.0,
          ),
          _cardTipo2(),
          SizedBox(
            height: 20.0,
          ),
          _cardTipo1(),
          SizedBox(
            height: 20.0,
          ),
          _cardTipo2(),
          SizedBox(
            height: 20.0,
          ),
          _cardTipo1(),
          SizedBox(
            height: 20.0,
          ),
          _cardTipo2(),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album_outlined, color: Colors.blue),
            title: Text('Titulo tarjeta'),
            subtitle: Text('Subtitle'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              TextButton(onPressed: () {}, child: Text('Ok'))
            ],
          )
        ],
      ),
    );
  }
}

Widget _cardTipo2() {
  final cardTipo2 = Container(
      child: Column(
    children: [
      FadeInImage(
          fadeInDuration: Duration(milliseconds: 300),
          height: 200,
          fit: BoxFit.fill,
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
              'https://wallpaperchat.com/walls/full/6/5/a/475090.jpg')),
      // Image(
      //   image: NetworkImage('https://wallpaperchat.com/walls/full/6/5/a/475090.jpg'),
      // ),
      Container(
        padding: EdgeInsets.all(5.0),
        child: Text('Texto imagen'),
      )
    ],
  ));

  return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 20.0, spreadRadius: 2.0),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: cardTipo2,
      ));
}
