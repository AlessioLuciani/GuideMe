import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/pages/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final Itinerary itinerary;
  final String pageTitle;

  ExploreCard({
    @required this.itinerary,
    this.pageTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 4),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            Platform.isIOS
            ? CupertinoPageRoute(
              builder: (context) => DetailsPage(
                      itinerary: itinerary,
                      prevPageTitle: pageTitle,
                    )
            )
            : MaterialPageRoute(
                builder: (context) => DetailsPage(
                      itinerary: itinerary,
                      prevPageTitle: pageTitle,
                    )),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  itinerary.coverImage,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 10, top: 2),
                title: Text(
                  itinerary.title,
                  style: TextStyle(fontSize: 21),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _getDuration(itinerary.durationString),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getDistance(itinerary.lengthKm),
                          _getRating(itinerary.avgReview.toStringAsFixed(1))
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _getDuration(String duration) {
  return Row(
    children: <Widget>[
      Icon(Icons.access_time),
      SizedBox(
        width: 4,
      ),
      Text(
        duration,
      ),
    ],
  );
}

Widget _getDistance(String distance) {
  return Row(
    children: <Widget>[
      Icon(
        Icons.directions_walk,
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        distance,
      ),
    ],
  );
}

Widget _getRating(String rating) {
  return Row(
    children: <Widget>[
      Text(
        rating,
        style: TextStyle(fontSize: 17),
      ),
      SizedBox(
        width: 2,
      ),
      Icon(
        Icons.star,
        color: Colors.red,
        size: 30,
      ),
      SizedBox(
        width: 10,
      )
    ],
  );
}
