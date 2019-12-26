import 'package:GuideMe/utils/Itinerary.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Itinerary itinerary;

  const DetailsPage({Key key, this.itinerary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(itinerary.title)),
      body: Container(
        child: Center(
          child: Text(itinerary.longDescription),
        ),
      ),
    );
  }
}
