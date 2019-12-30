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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Aggiungi luoghi all'itinerario"),
          leading: new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _myLocation,
              myLocationEnabled: true,
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
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FloatingActionButton(
                    backgroundColor:
                        _markers.isEmpty ? Colors.grey : Colors.redAccent,
                    heroTag: "btn1",
                    child: Icon(Icons.undo),
                    onPressed: () {
                      if (_markers.isNotEmpty) {
                        setState(() {
                          _polyline.clear();
                          _markers.removeLast();
                          widget.removeLastMarker();
                          _polyline.add(Polyline(
                            polylineId: PolylineId("Il tuo itinerario"),
                            visible: true,
                            points: _markers
                                .map((marker) => marker.position)
                                .toList(),
                            width: 3,
                            color: Colors.green,
                          ));
                        });
                      }
                    },
                  ),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    child: Icon(Icons.done),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                )),
          ],
        ));
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
