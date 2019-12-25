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

Widget _getCard() {
  return Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.network(
                    'https://placeimg.com/1080/470/any',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 35),
                        ),
                        Text(
                          "Giro de Roma",
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Icon(Icons.access_time),
                        Text(
                          "1.30 ore",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 30),
                              ),
                              Icon(Icons.directions_walk),
                              Text(
                                "7 km",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "3.2",
                                style: TextStyle(fontSize: 17),
                              ),
                              Icon(Icons.star),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 30),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.only(left:20, right: 20, top: 10),
          );
}