import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationMaps extends StatefulWidget {
  final Itinerary itinerary;

  const NavigationMaps({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavigationMapsState();
}

class NavigationMapsState extends State<NavigationMaps> {
   Set<Marker> _markers =Set();
  final Set<Polyline> _polyline = Set();
  GoogleMapController controller;
  int currentStop = 0;

  @override
  Widget build(BuildContext context) {
    _generateMarkers();

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

          SafeArea(
            child: Container(
              height: 100,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 30,
                    child: IconButton(
                      icon: Icon(Icons.navigate_before,) ,
                      onPressed: _previousStop,
                    ),
                  ),
                  Positioned(
                    left: 60,
                    top: 30,
                    child: Text(
                      widget.itinerary.stops[currentStop].name,
                      style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                   Positioned(
                    left: 60,
                    top: 60,
                    child: Text(
                      (currentStop+1).toString() + "/" + (widget.itinerary.stops.length).toString(),
                      style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Positioned(
                    right: 110,
                    top: 25,
                    child: IconButton(
                      icon: Icon(
                        Icons.record_voice_over,
                        color: Colors.redAccent,
                        size: 40.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    right: 50,
                    top: 25,
                    child: IconButton(
                      icon: Icon(
                          Icons.description,
                          size: 40.0,
                        ),
                        onPressed: () {},
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 30,
                    child: IconButton(
                      icon: Icon(Icons.navigate_next) ,
                      onPressed: _nextStop,
                    ),
                  )
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {

    
    setState(() {
      controller = controllerParam;

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

  // Goes to the next stop
  void _nextStop() {
    if (currentStop == widget.itinerary.stops.length - 1) {
      return;
    }
    setState(() {
      currentStop++;
    });
  }

// Goes to the previous stop
  void _previousStop() {
    if (currentStop == 0) {
      return;
    }
    setState(() {
      currentStop--;
    });
  }

  /// Generates a marker for every pin.
    void _generateMarkers() {
      _markers = Set();
      for (int i = 0; i < widget.itinerary.stops.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(widget.itinerary.stops[i].coord.toString()),
          icon: i == currentStop
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), 
          position: widget.itinerary.stops[i].coord,
          onTap: () {
            setState(() {
              currentStop = i;
            });
          },
          infoWindow: InfoWindow(
            title: widget.itinerary.stops[i].name,
          ),
        ));
   }

  

  }
  }
