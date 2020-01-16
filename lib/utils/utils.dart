import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/pages/confirmation.dart';
import 'package:GuideMe/pages/login.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

// Function used to retrieve the corresponding index of '_itinerary' among itineraries list located in data
Itinerary getItineraryRef(Itinerary _itinerary) {
  int index = itineraries.indexWhere((Itinerary it) => it.id == _itinerary.id);
  return itineraries[index];
}

Itinerary getitineraryFromId(int id) =>
    itineraries.firstWhere((Itinerary itinerary) => itinerary.id == id);

// Super secret authentication
int userExists(String email) {
  return users.indexWhere((user) => user.email == email);
}

// Grant one time access to new users with their email
bool addTempUser(final User user) {
  bool alreadyExists =
      users.indexWhere((_user) => _user.email == user.email) >= 0;
  if (alreadyExists) {
    return false;
  } else {
    users.add(user);
    return true;
  }
}

List<Itinerary> get favouriteItineraries =>
    itineraries.where((it) => it.isFavourite).toList();

Future createUserSession(int userIndex) async {
  currentUserIndex = userIndex;
  resetUserVisits();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.setInt("current_user_index", userIndex);
}

User get currentUser => users[currentUserIndex];

void favourite(Itinerary itinerary) {
  getItineraryRef(itinerary).toggleFavourite();
}

void showReviewConfirm(BuildContext context, Itinerary itinerary) {
  currentMsgIndex = 0;
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ConfirmationPage(
                itinerary: itinerary,
              )));
}

void showAdditionConfirm(BuildContext context) {
  currentMsgIndex = 1;
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ConfirmationPage()));
}

/// Starts playing the given text with text to speech
Future<FlutterTts> playTextToSpeech(String text) async {
  FlutterTts tts = FlutterTts();
  await tts.setLanguage("it-IT");
  await tts.speak(text);

  return tts;
}

/// Stops playing the given text to speech
Future stopTextToSpeech(Future<FlutterTts> tts) async {
  if (tts == null) {
    return;
  }
  tts.then((val) => val.stop());
}

/// Turns degrees into radians
double degreesToRadians(degrees) {
  return degrees * pi / 180;
}

/// Calculates the distance in Km between two Earth coordinates
double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadiusKm * c;
}

void publishItinerary(
    {@required String title,
    @required String description,
    @required int length,
    @required List<ItineraryStop> stops}) {
  int currentMinutes = timeFromItineraryLength(length);
  appendItinerary(Itinerary(
      author: currentUser,
      coverImage: coverImages[generator.nextInt(coverImages.length)],
      title: title,
      stops: stops,
      duration: DateTime.parse(MIN_DATETIME).add(
          Duration(hours: currentMinutes ~/ 60, minutes: currentMinutes % 60)),
      length: length,
      longDescription: description));
}

int timeFromItineraryLength(int length) =>
    length * 30 + generator.nextInt((1 + length) * 8);

List<Itinerary> get itinerariesCopy {
  List<Itinerary> resultList = new List();
  resultList.addAll(itineraries);
  return resultList;
}

/// Logs the user out of the current session
Future logout(BuildContext context) async {
  currentUserIndex = -1;
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.setInt("current_user_index", -1);
  Route route = MaterialPageRoute(builder: (context) => LoginPage());
  Navigator.pushReplacement(context, route);
}
