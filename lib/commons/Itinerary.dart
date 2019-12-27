import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/review.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:flutter/material.dart';

class Itinerary {
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
  List<Review> _reviews;
  List<ItineraryStop> stops;

  Itinerary(
      {@required this.stops,
      @required this.author,
      @required this.coverImage,
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

  String authorName() => '${author.name} ${author.surname}';

  void toggleFavourite() => isFavourite = !isFavourite;
}
