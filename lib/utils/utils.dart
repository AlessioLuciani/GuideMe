import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/pages/confirmation.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


  // Function used to retrieve the corresponding index of '_itinerary' among itineraries list located in data
  Itinerary getItineraryRef(Itinerary _itinerary) {
    int index =
        Data.itineraries.indexWhere((Itinerary it) => it.id == _itinerary.id);
    debugPrint('$index');
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