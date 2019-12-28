import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyMaps extends StatefulWidget {

  final Set<Polyline> polyline;
  final Set<Marker> markers;
  final Function onMapCreated;
  final LatLng target;
  final double zoom;

  const MyMaps({Key key, this.onMapCreated, this.target, this.polyline, this.markers, this.zoom}) : super(key: key);

  @override
  _MyMapsState createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GoogleMap(
          mapType: MapType.terrain,
          //that needs a list<Polyline>
          polylines: widget.polyline,
          markers: widget.markers,
          onMapCreated: widget.onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget.target,
            zoom: widget.zoom,
          ),
        )
    );
  }
}