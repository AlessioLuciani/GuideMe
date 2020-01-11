import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/pages/navigation_description.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class NavigationMapsPage extends StatefulWidget {
  final Itinerary itinerary;

  const NavigationMapsPage({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavigationMapsPageState();
}

class NavigationMapsPageState extends State<NavigationMapsPage> {
  Set<Marker> _markers = Set();
  final Set<Polyline> _polyline = Set();
  GoogleMapController controller;
  NavigationData navigationData;
  GoogleMapController mapController;

  @override
  void initState() {
    navigationData = NavigationData(
        itinerary: widget.itinerary, currentStop: 0, playingAudio: false);
    super.initState();
  }

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
            SizedBox(
              height: 2,
            ),
            Text(
              'Creato da ${widget.itinerary.authorName()}',
              style: TextStyle(fontSize: 13, color: Colors.white70),
              textAlign: TextAlign.left,
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () {
            stopTextToSpeech(navigationData.tts);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Expanded(child:
          Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.terrain,
                //that needs a list<Polyline>
                polylines: _polyline,
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: widget.itinerary.stops[0].coord, zoom: 14.0),
              ),
              Positioned(
                  bottom: 20,
                  right: 16,
                  child: FloatingActionButton.extended(
                    onPressed: moveCamToClosestStop,
                    icon: Icon(Icons.nature_people),
                    label: Text("Nearby"),
                  )),
            ],
          ),),
          SafeArea(
            child: Padding(padding: EdgeInsets.symmetric(vertical:15.0, horizontal:0.0),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.navigate_before,
                          color: navigationData.currentStop > 0
                              ? Colors.black
                              : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            navigationData.previousStop();
                          });
                        },
                      ),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                Text(
                                  widget.itinerary
                                      .stops[navigationData.currentStop].name,
                                  style: new TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  (navigationData.currentStop + 1).toString() +
                                      "/" +
                                      (widget.itinerary.stops.length).toString(),
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ])),
                        
                              IconButton(
                                icon: Icon(
                                  Icons.description,
                                  size: 40.0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (
                                          BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                        ) =>
                                            NavigationDescriptionPage(
                                          navigationData: navigationData,
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
                                },
                              ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                                icon: Icon(
                                  navigationData.playingAudio
                                      ? Icons.stop
                                      : Icons.record_voice_over,
                                  size: 40.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    navigationData.toggleAudio();
                                  });
                                }
                              ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          size: 30,
                          color: navigationData.currentStop <
                                  navigationData.itinerary.stops.length - 1
                              ? Colors.black
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            navigationData.nextStop();
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    mapController = controllerParam;

    setState(() {
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

  /// Generates a marker for every pin.
  void _generateMarkers() {
    _markers = Set();
    for (int i = 0; i < widget.itinerary.stops.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(widget.itinerary.stops[i].coord.toString()),
        icon: i == navigationData.currentStop
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: widget.itinerary.stops[i].coord,
        onTap: () {
          setState(() {
            navigationData.currentStop = i;
          });
        },
        infoWindow: InfoWindow(
          title: widget.itinerary.stops[i].name,
        ),
      ));
    }
  }

  /// Moves the camera to the user's closest stop.
  void moveCamToClosestStop() async {
    var perm = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (perm != PermissionStatus.granted) {
      return;
    }
    var location = new Location();
    var curLocation = await location.getLocation();

    double minDist =
        10000000000; // Smallest distance found between user's location and a stop
    int closestStop = 0;

    for (int i = 0; i < widget.itinerary.stops.length; i++) {
      var stop = widget.itinerary.stops[i];
      double curDist;
      if ((curDist = distanceInKmBetweenEarthCoordinates(
              curLocation.latitude,
              curLocation.longitude,
              stop.coord.latitude,
              stop.coord.longitude)) <
          minDist) {
        minDist = curDist;
        closestStop = i;
      }
    }

    mapController.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.itinerary.stops[closestStop].coord.latitude,
            widget.itinerary.stops[closestStop].coord.longitude),
        14.0));
    setState(() {
      navigationData.currentStop = closestStop;
    });
  }
}

/// Class that contains data for the current navigation.
class NavigationData {
  Itinerary itinerary;
  int currentStop;
  bool playingAudio;
  Future<FlutterTts> tts;

  NavigationData({this.itinerary, this.currentStop, this.playingAudio});

  // Goes to the next stop
  void nextStop() {
    if (currentStop == itinerary.stops.length - 1) {
      return;
    }
    currentStop++;
  }

// Goes to the previous stop
  void previousStop() {
    if (currentStop == 0) {
      return;
    }
    currentStop--;
  }

// Toggle the audio
  void toggleAudio() {
    if (playingAudio) {
      stopTextToSpeech(tts);
    } else {
      tts = playTextToSpeech(itinerary.stops[currentStop].description);
    }
    tts.then((val) => val.setCompletionHandler(
        () => playingAudio = false));
    playingAudio = !playingAudio;
  }
}
