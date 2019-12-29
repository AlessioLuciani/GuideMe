import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/foundation.dart';

class Utils {
  // Function used to retrieve the corresponding index of '_itinerary' among itineraries list located in data
  static Itinerary getItineraryRef(Itinerary _itinerary) {
    int index = Data.itineraries
        .indexWhere((Itinerary it) => it.id == _itinerary.id);
    debugPrint('$index');
    return Data.itineraries[index];
  }

  // Super secret authentication
  static int userExists(String email) {
    return Data.users.indexWhere((user) => user.email == email);
  }

  // Grant one time access to new users with their email
  static bool addTempUser(final User user) {
    bool alreadyExists =
        Data.users.indexWhere((_user) => _user.email == user.email) >= 0;
    if (alreadyExists) {
      return false;
    } else {
      Data.users.add(user);
      return true;
    }
  }

  static List<Itinerary> get favouriteItineraries => Data.itineraries.where((it)=>it.isFavourite).toList();

  static void createUserSession(int userIndex) {
    Data.currentUserIndex = userIndex;
    Data.resetUserVisits();
  }

  static void favourite(Itinerary itinerary) {
    Utils.getItineraryRef(itinerary).toggleFavourite();
  }
}
