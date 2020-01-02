import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/pages/confirmation.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';


  // Function used to retrieve the corresponding index of '_itinerary' among itineraries list located in data
  Itinerary getItineraryRef(Itinerary _itinerary) {
    int index =
        Data.itineraries.indexWhere((Itinerary it) => it.id == _itinerary.id);
    return Data.itineraries[index];
  }

  // Super secret authentication
  int userExists(String email) {
    return Data.users.indexWhere((user) => user.email == email);
  }

  // Grant one time access to new users with their email
  bool addTempUser(final User user) {
    bool alreadyExists =
        Data.users.indexWhere((_user) => _user.email == user.email) >= 0;
    if (alreadyExists) {
      return false;
    } else {
      Data.users.add(user);
      return true;
    }
  }

  List<Itinerary> get favouriteItineraries =>
      Data.itineraries.where((it) => it.isFavourite).toList();

  void createUserSession(int userIndex) {
    Data.currentUserIndex = userIndex;
    Data.resetUserVisits();
  }

  void favourite(Itinerary itinerary) {
    getItineraryRef(itinerary).toggleFavourite();
  }

  void showReviewConfirm(BuildContext context) {
    Data.currentMsgIndex = 0;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ConfirmationPage()));
  }

  void showAdditionConfirm(BuildContext context) {
    Data.currentMsgIndex = 1;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ConfirmationPage()));
  }

  void setStatusBarDarkColor() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor: Colors.black, // Color for Android
   statusBarBrightness: Brightness.light // Dark == white status bar -- for IOS.
));
}

Future<FlutterTts> playTextToSpeech(String text) async {

  FlutterTts tts = FlutterTts();
  await tts.setLanguage("it-IT");
  await tts.speak(text);

  return tts;
}

Future stopTextToSpeech(Future<FlutterTts> tts) async {
  if (tts == null) {
    return;
  }
  tts.then((val) => {
    val.stop()
  });

}

 double degreesToRadians(degrees) {
  return degrees * pi / 180;
}

double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2-lat1);
  var dLon = degreesToRadians(lon2-lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat/2) * sin(dLat/2) +
          sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2); 
  var c = 2 * atan2(sqrt(a), sqrt(1-a)); 
  return earthRadiusKm * c;
}