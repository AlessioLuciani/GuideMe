import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: ListView(
        children: <Widget>[
          _getCard(),
          _getCard(),
          _getCard(),
          _getCard(),
          _getCard(),
        ],
      ),
    );
  }
}

Card _getCard() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    color: Colors.orange,
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _getImage(),
        _getTitle(),
        _getDuration(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_getDistance(), _getRating()]),
      ],
    ),
  );
}

Widget _getTitle() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 10),
      ),
      Text(
        "Giro de Roma",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _getDuration() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 8),
      ),
      Icon(Icons.access_time),
      Text(
        "1.30 ore",
        style: TextStyle(fontSize: 17),
      ),
    ],
  );
}

Widget _getDistance() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 8, top: 20),
      ),
      Icon(Icons.directions_walk),
      Text(
        "7 km",
        style: TextStyle(fontSize: 17),
      ),
    ],
  );
}

Widget _getRating() {
  return Row(
    children: <Widget>[
      Text(
        "3.2",
        style: TextStyle(fontSize: 20),
      ),
      Icon(Icons.star),
      Padding(
        padding: EdgeInsets.only(left: 5, top: 20, bottom: 10, right: 8),
      ),
    ],
  );
}

Widget _getImage() {
  return Container(
      child: Image.network(
    'https://placeimg.com/1080/470/any',
  ));
}

Widget _getInfo() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 10),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _getTitle(),
          _getDuration(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_getDistance(), _getRating()],
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.only(right: 10),
      ),
    ],
  );
}
