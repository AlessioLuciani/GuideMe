import 'package:flutter/material.dart';

class User {
  String name;
  String surname;
  String email;
  String photo;

  User({
    @required this.name,
    @required this.surname,
    @required this.email,
    this.photo,
  });
}
