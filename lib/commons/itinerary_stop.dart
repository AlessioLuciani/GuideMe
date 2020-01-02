import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItineraryStop {
  final String name;
  final LatLng coord;
  final String description;

  ItineraryStop({this.name, this.coord, this.description});
}