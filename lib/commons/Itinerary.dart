import 'dart:math';

import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/review.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:flutter/material.dart';

class Itinerary {
  // Dirty id of the class
  static int _id = 0;
  // Itinerary id
  int id;
  // Heading section
  String title;
  String duration;
  String distance;
  String coverImage;
  String priceRange;
  User author;
  bool isFavourite;
  // Details section
  String longDescription;
  List<Review> _reviews = [];
  List<ItineraryStop> stops;
  double _cachedAvgRating = 0;

  Itinerary(
      {@required this.stops,
      @required this.author,
      @required this.coverImage,
      @required this.title,
      @required this.duration,
      @required this.longDescription,
      @required this.distance,
      @required this.priceRange,
      this.isFavourite = false}) {
    id = _id;
    _id++;
  }

  List<Review> get reviews => _reviews;

  double _avgReview() {
    // Ideally would be the total rating of the itinerary divided by the number of reviews, but ..
    if (_cachedAvgRating == 0) {
      // Generate mock average rating value
      _cachedAvgRating = Random().nextInt(4) + Random().nextDouble() + 1;
    }
    return _cachedAvgRating;
  }

  String get avgReview => _avgReview().toStringAsFixed(1);

  set addReview(Review review) => _reviews.add(review);

  String authorName() => '${author.name} ${author.surname}';

  void toggleFavourite() => isFavourite = !isFavourite;
}
