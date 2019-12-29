import 'package:flutter/material.dart';

class ConfirmationReviewPage extends StatelessWidget {
  @override
  Widget builda(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: Colors.green,
                ),
                Text(
                  "Recensione inviata!",
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: FlatButton(
                child: Text("Chiudi"),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

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
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
