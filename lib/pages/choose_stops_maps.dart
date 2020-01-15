import 'dart:io';

import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseStopsMaps extends StatefulWidget {
  final void Function(Marker marker) addMarker;
  final void Function() removeLastMarker;
  final List<Marker> initMarkers;

  const ChooseStopsMaps(
      {Key key, this.addMarker, this.removeLastMarker, this.initMarkers})
      : super(key: key); 

  @override
  _ChooseStopsMapsState createState() => _ChooseStopsMapsState();
}

class _ChooseStopsMapsState extends State<ChooseStopsMaps> {
    List<Marker> _prevMarkers;
  GoogleMapController controller;
  final Set<Polyline> _polyline = Set();
  final CameraPosition _myLocation =
      CameraPosition(target: LatLng(41.890447, 12.492420), zoom: 13.0);

  final List<Marker> _markers = List();

  String nextMarkerId() {
    int currentMax = 0;
    for (Marker marker in _markers) {
      int markerId = int.parse(marker.infoWindow.title.substring(1));
      if (markerId > currentMax) {
        currentMax = markerId;
      }
    }
    return '#${currentMax + 1}';
  }

  @override
  void initState() {
    _prevMarkers = List.from(widget.initMarkers);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.initMarkers.removeRange(0, widget.initMarkers.length);
        widget.initMarkers.addAll(_prevMarkers);
        Navigator.pop(context);
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add stops"),          
          actions: <Widget>[
            FlatButton(
                    child: Text("Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),),
                    onPressed: () => Navigator.pop(context),
                  )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _myLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              polylines: _polyline,
              markers: _markers.toSet(),
              onTap: (LatLng point) => setState(() {
                Marker marker = Marker(
                  markerId: MarkerId(point.toString()),
                  position: point,
                  infoWindow: InfoWindow(
                    title: nextMarkerId(),
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                );
                _markers.add(marker);
                widget.addMarker(marker);
                _polyline.add(Polyline(
                  polylineId: PolylineId("Il tuo itinerario"),
                  visible: true,
                  points: _markers.map((marker) => marker.position).toList(),
                  width: 3,
                  color: Colors.green,
                ));
              }),
              onMapCreated: _onMapCreated,
              mapType: MapType.terrain,
              
            ),
                    Positioned(
                    bottom: 40,
                    right: 16,
                    child: FloatingActionButton.extended(
                      onPressed: () => _undoLastMarker(),
                      icon: Icon(Icons.undo),
                      label: Text("Undo"),
                    )
                    ),
          ],
        )));
  }

  void _undoLastMarker() {
    if (_markers.isNotEmpty) {
      setState(() {
        _polyline.clear();
        _markers.removeLast();
        widget.removeLastMarker();
        _polyline.add(Polyline(
          polylineId: PolylineId("Your itinerary"),
          visible: true,
          points: _markers.map((marker) => marker.position).toList(),
          width: 3,
          color: Colors.green,
        ));
      });
    }
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      for (int i = 0; i < widget.initMarkers.length; i++) {
        _markers.add(Marker(
          markerId: widget.initMarkers[i].markerId,
          position: widget.initMarkers[i].position,
          infoWindow: InfoWindow(
            title: widget.initMarkers[i].infoWindow.title,
          ),
        ));
      }

      _polyline.add(Polyline(
        polylineId: PolylineId("Il tuo itinerario"),
        visible: true,
        points: _markers.map((marker) => marker.position).toList(),
        width: 3,
        color: Colors.green,
      ));
    });
  }
}
