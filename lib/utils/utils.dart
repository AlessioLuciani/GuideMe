import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/foundation.dart';

class Utils {
  
  // Function used to retrieve the corresponding index of '_itinerary' among itineraries list located in data
  static Itinerary getItineraryRef(Itinerary _itinerary) {
    int index = Data.itineraries.indexWhere((Itinerary it) => it.author.id == _itinerary.author.id);
    debugPrint('$index');
    return Data.itineraries[index];
  }
}