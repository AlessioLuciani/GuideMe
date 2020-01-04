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
  int _duration;
  int length;
  String coverImage;
  String priceRange;
  User author;
  bool isFavourite;
  // Details section
  String longDescription;
  List<Review> _reviews = [];
  List<ItineraryStop> stops;

  Itinerary(
      {@required this.stops,
      @required this.author,
      @required this.coverImage,
      @required this.title,
      @required duration,
      @required this.longDescription,
      @required this.length,
      @required this.priceRange,
      this.isFavourite = false}) {
    _duration = duration;
    id = _id;
    _id++;
  }

  String get lengthKm => '$length km';

  String get duration => '$_hours ore $_minutes minuti';

  int get _hours => (_duration / 60).floor();

  int get _minutes => _duration - _hours * 60;

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
