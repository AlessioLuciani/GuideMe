import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:GuideMe/widgets/maps.dart';

class ChooseStopsMaps extends StatefulWidget {
  @override
  _ChooseStopsMapsState createState() => _ChooseStopsMapsState();
}

class _ChooseStopsMapsState extends State<ChooseStopsMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2,),
            
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}