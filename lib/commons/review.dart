import 'package:GuideMe/commons/user.dart';

class Review {
  User user;
  int rating;
  String title;
  String description;
  List<String> _photos;

  Review({this.user, this.rating, this.title, this.description}) {
    assert(rating >= 1 && rating <= 5);
  }

  List<String> get photos => _photos;

  set addPhoto(String photo) => _photos.add(photo);
}
