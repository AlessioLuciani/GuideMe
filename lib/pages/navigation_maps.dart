import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/pages/navigation_description.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationMapsPage extends StatefulWidget {
  final Itinerary itinerary;

  const NavigationMapsPage({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavigationMapsPageState();
}

class NavigationMapsPageState extends State<NavigationMapsPage> {
  
   Set<Marker> _markers =Set();
  final Set<Polyline> _polyline = Set();
  GoogleMapController controller;
  NavigationData navigationData;
  GoogleMapController mapController;

  
  @override
  void initState() {
    
   navigationData = 
    NavigationData(itinerary: widget.itinerary, currentStop: 0, playingAudio: false);
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
          onPressed: () {
              stopTextToSpeech(navigationData.tts);
              Navigator.of(context).pop();
            },
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
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
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
                      onPressed: () {
                        setState(() {
                          navigationData.previousStop();
                        });
                      },
                    ),
                  ),
                  Positioned(
                    left: 60,
                    top: 30,
                    child: Text(
                      widget.itinerary.stops[navigationData.currentStop].name,
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
                      (navigationData.currentStop+1).toString() + "/" + (widget.itinerary.stops.length).toString(),
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
                        navigationData.playingAudio
                        ? Icons.volume_off
                        : Icons.record_voice_over,
                        color: Colors.redAccent,
                        size: 40.0,
                      ),
                      onPressed:() =>
                        navigationData.toggleAudio(this)
                      ,
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
                        onPressed: () {
                          Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) =>
                                  NavigationDescriptionPage(navigationData: navigationData,),
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
                  ),
                  Positioned(
                    right: 0,
                    top: 30,
                    child: IconButton(
                      icon: Icon(Icons.navigate_next) ,
                      onPressed: () {
                        setState(() {
                          navigationData.nextStop();
                        });
                      },
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

    mapController = controllerParam;
    
    setState(() {
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
  }

  /// Class that contains data for the current navigation.
  /// */
  class NavigationData {

    Itinerary itinerary;
    int currentStop;
    bool playingAudio;
    Future<FlutterTts> tts;

    NavigationData ({this.itinerary, this.currentStop, this.playingAudio});

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
  void toggleAudio(State state) {
    if (playingAudio) {
      stopTextToSpeech(tts);
    } else {
      tts = playTextToSpeech(itinerary.stops[currentStop].description);                        
    }
    tts.then((val) => {
      val.setCompletionHandler(() {
        state.setState(() {
          playingAudio = false;
        });
      })
    });
    state.setState(() {
      playingAudio = !playingAudio;
    });
  }
  }

