import 'dart:ui';

import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/pages/itinerary_maps.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsPage extends StatefulWidget {
  final Itinerary itinerary;

  const DetailsPage({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> segment = [];
  GoogleMapController controller;

  @override
  void initState() {
    super.initState();
    for (ItineraryStop stop in widget.itinerary.stops) {
      segment.add(stop.coord);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.itinerary.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 160,
              child: GoogleMap(
                mapType: MapType.terrain,
                //that needs a list<Polyline>
                polylines: _polyline,
                markers: _markers,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: segment[0],
                  zoom: 13.0,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Descrizione",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Text(
              widget.itinerary.longDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time, size: 30),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "3 ore e 40 minuti",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 18),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Icon(Icons.directions_walk, size: 30),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "7 km",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 18, top: 4),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Icon(Icons.euro_symbol, size: 30),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "0 - 30",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 18, top: 4),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Icon(Icons.restaurant, size: 30),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Ristoranti tipici",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 18, top: 4),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: IconButton(
                      icon: new Icon(
                        widget.itinerary.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 36,
                      ),
                      onPressed: () =>
                          //setState(() => widget.itinerary.isFavourite = !widget.itinerary.isFavourite),
                          setState(() => Utils.getItineraryRef(widget.itinerary)
                              .toggleFavourite()),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.red)),
                    borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItineraryMaps(
                                  itinerary: widget.itinerary,
                                ))),
                    child: Text("AVVIA"),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      for (int i = 0; i < segment.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(segment[i].toString()),
          position: segment[i],
          infoWindow: InfoWindow(
            title: 'Awesome Polyline tutorial',
            snippet: 'This is a snippet',
          ),
        ));
      }

      _polyline.add(Polyline(
        polylineId: PolylineId('itinerary'),
        visible: true,
        //latlng is List<LatLng>
        points: segment,
        width: 2,
        color: Colors.blue,
      ));
    });
  }
}
