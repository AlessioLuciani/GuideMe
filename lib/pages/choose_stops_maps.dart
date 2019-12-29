import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseStopsMaps extends StatefulWidget {
  @override
  _ChooseStopsMapsState createState() => _ChooseStopsMapsState();
}

class _ChooseStopsMapsState extends State<ChooseStopsMaps> {
  GoogleMapController controller;
  final CameraPosition _myLocation =
      CameraPosition(target: LatLng(41.890447, 12.492420), zoom: 13.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cerca i posti da visitare"),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GoogleMap(
          initialCameraPosition: _myLocation,
          polylines: null,
          markers: null,
          mapType: MapType.terrain,
          onMapCreated: (GoogleMapController controller) {
            controller = controller;
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
