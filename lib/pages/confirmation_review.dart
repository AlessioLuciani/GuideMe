import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class ConfirmationReviewPage extends StatelessWidget {
  final Itinerary itinerary;

  const ConfirmationReviewPage({Key key, this.itinerary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
                  child: Container(
            height: 170,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Recensione inviata!",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
          ))),
          FlatButton(
            child: Text(
              "Chiudi",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Data.reviewItinerary(itinerary);
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
