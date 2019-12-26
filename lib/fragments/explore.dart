import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ), // insisible box
          getCard(),
          getCard(),
          getCard(),
          getCard(),
          getCard(),
        ],
      ),
    );
  }
}

Widget getCard() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 4),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: () => print("ciao"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: _getImage()),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10, top: 2),
              title: Text(
                "Giro de Roma",
                style: TextStyle(fontSize: 22),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _getDuration(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_getDistance(), _getRating()])
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Card _getCard() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
      Icon(Icons.access_time),
      SizedBox(
        width: 4,
      ),
      Text(
        "1.30 ore",
      ),
    ],
  );
}

Widget _getDistance() {
  return Row(
    children: <Widget>[
      Icon(Icons.directions_walk),
      SizedBox(
        width: 4,
      ),
      Text(
        "7 km",
      ),
    ],
  );
}

Widget _getRating() {
  return Row(
    children: <Widget>[
      Text(
        "3.2",
      ),
      Icon(Icons.star),
      SizedBox(width: 10,)
    ],
  );
}

Widget _getImage() {
  return Container(
      child: Image(image: AssetImage("assets/images/colosseo.jpg")));
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
