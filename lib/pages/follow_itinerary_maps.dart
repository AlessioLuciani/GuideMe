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
  final Set<Marker> _markers =Set();
  final Set<Polyline> _polyline = Set();
  GoogleMapController controller;
  int currentStop = 0;

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
                IconButton(
                    icon: Icon(Icons.navigate_before,) ,
                    onPressed: () {},
                  ),
                Container(
                  height: 140,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        widget.itinerary.coverImage,
                        height: 80,
                        width: 100,
                        fit: BoxFit.fitHeight
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 30,),
                            Text(
                              widget.itinerary.stops[currentStop].name,
                              style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              (currentStop+1).toString() + "/" + (widget.itinerary.stops.length).toString(),
                              style: new TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                        ],
                        
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        icon: Icon(
                          Icons.record_voice_over,
                          color: Colors.redAccent,
                          size: 40.0,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        icon: Icon(
                            Icons.description,
                            size: 40.0,
                          ),
                          onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.navigate_next) ,
                        onPressed: () {},
                      ),
                    ],
                    ),
                  )
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
