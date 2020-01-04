import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/user.dart';

class ItineraryVisit {
  final DateTime date;
  final Itinerary itinerary;
  final User user;

  ItineraryVisit(this.itinerary, this.user, this.date);
}
