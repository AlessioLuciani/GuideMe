import 'package:GuideMe/commons/user.dart';
import 'package:flutter/material.dart';

class Review {
  final User user;
  final int rating;
  final String description;
  final List<String> photos = List();
  final DateTime time;

  Review(
      {@required this.user,
      @required this.rating,
      @required this.description,
      @required this.time});

  set addPhoto(String photo) => photos.add(photo);
}