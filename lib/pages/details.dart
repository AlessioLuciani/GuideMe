import 'dart:ui';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/pages/navigation_maps.dart';
import 'package:GuideMe/pages/review_list.dart';
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
  final Set<Marker> _markers = Set();
  final Set<Polyline> _polyline = Set();
  GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.itinerary.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Container(
                  height: 200,
                  child: GoogleMap(
                    mapType: MapType.terrain,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    polylines: _polyline,
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: widget.itinerary.stops[0].coord,
                      zoom: 13.0,
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  widget.itinerary.durationString,
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
                  widget.itinerary.lengthKm,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: InkWell(
                      onTap: () => _goToList(context),
                      child: Row(
                        children: <Widget>[
                          Text(
                            widget.itinerary.avgReview.toStringAsFixed(1),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 36,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 36,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: IconButton(
                          icon: new Icon(
                            widget.itinerary.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.redAccent,
                            size: 36,
                          ),
                          onPressed: () =>
                              setState(() => favourite(widget.itinerary)),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FlatButton(
                        child: Text(
                          "Avvia",
                          style: TextStyle(fontSize: 15),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) =>
                                  NavigationMapsPage(
                                itinerary: widget.itinerary,
                              ),
                              transitionsBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child,
                              ) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            )),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
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
        points:
            widget.itinerary.stops.map((ItineraryStop s) => s.coord).toList(),
        width: 2,
        color: Colors.blue,
      ));
    });
  }

  void _goToList(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              ReviewListPage(
            itinerary: widget.itinerary,
          ),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ));
  }
}
