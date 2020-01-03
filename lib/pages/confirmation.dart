import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final Itinerary itinerary;

  const ConfirmationPage({Key key, this.itinerary}) : super(key: key);

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
                  confirmMsg,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ))),
          FlatButton(
            child: Text(
              "Chiudi",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              if (itinerary != null) {
                // In case this is a confirmation of a sent review
                reviewItinerary(itinerary);
              }
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
