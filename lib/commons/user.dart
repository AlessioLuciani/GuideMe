import 'package:flutter/material.dart';

class User {
  // Dirty id of the class
  static int _id = 0;
  // User id
  int id;
  String name;
  String surname;
  String email;
  String photo;

  User({
    @required this.name,
    @required this.surname,
    @required this.email,
    this.photo,
  }) {
    id = _id;
    _id++;
  }
}
