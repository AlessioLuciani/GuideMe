import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItineraryStop {
  final String name;
  final LatLng coord;
  final String description;

  ItineraryStop(
      {@required this.name, @required this.coord, @required this.description});
}
