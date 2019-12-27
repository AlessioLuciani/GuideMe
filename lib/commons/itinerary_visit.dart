import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/user.dart';

class ItineraryVisit{

  DateTime _dateTime;
  Itinerary _itinerary;
  User _user;

  ItineraryVisit(Itinerary itinerary, User user){
    this._dateTime = DateTime.now();
    this._itinerary = itinerary;
    this._user = user;
  }

  DateTime get dateTime {return this._dateTime;}
  void set dateTime(DateTime dateTime) {this._dateTime = dateTime;}

  Itinerary get itinerary {return this._itinerary;}
  void set itinerary(Itinerary itinerary) {this._itinerary = itinerary;}

  User get user {return this._user;}
  void set user(User user) {this._user = user;}

}