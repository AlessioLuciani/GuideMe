
import 'package:GuideMe/commons/review.dart';
import 'package:flutter/material.dart';

class Itinerary {
  // Heading section
  String title;
  String duration;
  String distance;
  String coverImage;
  String priceRange;
  bool isFavourite;
  // Details section
  String longDescription;
  List<Review> _reviews;

  Itinerary(
      {@required this.coverImage,
      @required this.title,
      @required this.duration,
      @required this.longDescription,
      @required this.distance,
      @required this.priceRange,
      this.isFavourite = false});

  List<Review> get reviews => _reviews;

  // TODO: implement 1 <= avg review <= 5
  String get avgReview => "3.2";

  set addReview(Review review) => _reviews.add(review);
}