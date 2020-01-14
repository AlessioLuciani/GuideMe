import 'dart:math';

import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/review.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class Itinerary {
  // Dirty id of the class
  static int _id = 0;
  // Itinerary id
  int id;
  // Heading section
  String title;
  DateTime duration;
  int length;
  String coverImage;
  String priceRange;
  User author;
  bool isFavourite;
  // Details section
  String longDescription;
  List<Review> _reviews = [];
  List<ItineraryStop> _stops = [];

  Itinerary(
      {@required this.author,
      @required this.coverImage,
      @required this.title,
      @required this.duration,
      @required this.longDescription,
      @required this.length,
      @required this.priceRange,
      this.isFavourite = false}) {
    id = _id;
    _id++;
  }

  String get lengthKm => '$length km';

  String get _hourWord => duration.hour > 1 ? "ore" : "ora";
  String get _minuteWord => duration.minute > 1 ? "minuti" : "minuto";

  String get durationString =>
      '${duration.hour} $_hourWord ${duration.minute} $_minuteWord';

  List<Review> get reviews {
    if (_reviews.isEmpty) {
      Random generator = new Random();
      int samples = generator.nextInt(globalReviews.length - 4) + 4;
      for (int i = 0; i < samples; i++) {
        Review currentReview =
            globalReviews[generator.nextInt(globalReviews.length)];
        if (currentReview.user != author) {
          _reviews.add(currentReview);
        }
      }
    }
    return _reviews;
  }

  List<ItineraryStop> get stops {
    if (_stops.isEmpty) {
      Random generator = new Random();
      int samples = generator.nextInt(globalStops.length - 8) + 4;
      for (int i = 0; i < samples; i++) {
        ItineraryStop currentStop =
            globalStops[generator.nextInt(globalStops.length)];
        if (!_stops.contains(currentStop)) {
          _stops.add(currentStop);
        }
      }
    }
    return _stops;
  }

  double get avgReview {
    if (reviews.length == 0) {
      return 0;
    }
    int sum = 0;
    for (Review review in reviews) {
      sum += review.rating;
    }
    return sum / reviews.length;
  }

  set addReview(Review review) => _reviews.add(review);

  String authorName() => '${author.name} ${author.surname}';

  void toggleFavourite() => isFavourite = !isFavourite;
}
