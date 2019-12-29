import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItineraryMaps extends StatefulWidget {
  final Itinerary itinerary;

  const ItineraryMaps({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItineraryMapsState();
}

class ItineraryMapsState extends State<ItineraryMaps> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.itinerary.title),
            SizedBox(height: 2,),
            Text(
              'Creato da ${widget.itinerary.authorName()}',
              style: TextStyle(fontSize: 13, color: Colors.white70),
              textAlign: TextAlign.left,
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              //that needs a list<Polyline>
              polylines: _polyline,
              markers: _markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: widget.itinerary.stops[0].coord, zoom: 13.0),
            )
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Barra di informazioni",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      for (int i = 0; i < widget.itinerary.stops.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(widget.itinerary.stops[i].coord.toString()),
          position: widget.itinerary.stops[i].coord,
          infoWindow: InfoWindow(
            title: widget.itinerary.stops[i].name,
          ),
        ));
      }

      _polyline.add(Polyline(
        polylineId: PolylineId('itinerary'),
        visible: true,
        //latlng is List<LatLng>
        points: widget.itinerary.stops.map((ItineraryStop s)=>s.coord).toList(),
        width: 2,
        color: Colors.blue,
      ));
    });
  }
}
