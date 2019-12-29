import 'dart:io';

import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Star {
  final Color color;
  final Function onTap;

  Star({this.color, this.onTap});
}

class FeedbackFragment extends StatefulWidget {
  final Itinerary itinerary;
  final List<String> msgs = [
    "Clicca una stella per recensire",
    "Orribile",
    "Scarso",
    "Medio",
    "Buono",
    "Eccellente"
  ];

  FeedbackFragment({Key key, @required this.itinerary}) : super(key: key);

  static Function instance =
      ({Key key, Itinerary itinerary}) => new FeedbackFragment(
            key: key,
            itinerary: itinerary,
          );

  @override
  State<StatefulWidget> createState() => FeedbackFragmentState();
}

class FeedbackFragmentState extends State<FeedbackFragment> {
  int _currentStars = -1;
  List<File> images = [null, null, null, null];

  _getStars() {
    List<Star> stars = [];

    for (var i = 0; i < Data.RATING_STARS; i++) {
      stars.add(new Star(
        color: (i <= _currentStars) ? Colors.yellow : Colors.grey[300],
        onTap: () => setState(() => _currentStars = i),
      ));
    }

    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars.map((star) {
          return Flexible(
            child: GestureDetector(
                onTap: star.onTap,
                child: Icon(
                  Icons.star,
                  size: 54,
                  color: star.color,
                )),
          );
        }).toList(),
      ),
    );
  }

  Future _getImage(int index) async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 120);

    setState(() {
      images[index] = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.itinerary.title),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => FlatButton(
                textColor: Colors.white,
                onPressed: () => Utils.showReviewConfirm(context),
                child: Text("Invia", style: TextStyle(fontSize: 17),),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.msgs[_currentStars >= 0 && _currentStars <= 4
                      ? _currentStars + 1
                      : 0],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: _getStars(),
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Titolo",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _getTextfield("Le cose più importanti che vuoi condividere.",
                      "La tua esperienza in non più di 50 caratteri.", 2, 50),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Descrizione",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _getTextfield(
                      "Cosa ti è piaciuto e cosa non ti è piaciuto? A chi lo consiglieresti?",
                      "La tua esperienza in non più di 300 caratteri.",
                      4,
                      300),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Foto",
                style: TextStyle(fontSize: 20),
              ),
              _getGalleryPickers(),
            ],
          ),
        ));
  }

  Widget _getGalleryPickers() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (images[index] == null) {
            return Padding(
              padding: EdgeInsets.only(right: 0),
              child: IconButton(
                iconSize: 60,
                alignment: Alignment.center,
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 70,
                  color: Colors.black87,
                ),
                onPressed: () => _getImage(index),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: 100,
                width: 100,
                child: Image.file(images[index]),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _getTextfield(
      String hintText, String helperText, int lines, int maxChars) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
        primaryColorDark: Colors.grey,
      ),
      child: Container(
          child: TextField(
        minLines: lines,
        maxLines: lines,
        maxLength: maxChars,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          hintText: hintText,
          helperText: helperText,
        ),
      )),
    );
  }
}
