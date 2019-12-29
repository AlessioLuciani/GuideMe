import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/image_loader.dart';
import 'package:GuideMe/commons/rating.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class FeedbackFragment extends StatelessWidget {
  final String title = "Giro de Roma";

  final Itinerary itinerary;

  FeedbackFragment({Key key, @required this.itinerary}) : super(key:key);

  static Function instance = ({Key key,Itinerary itinerary}) => new FeedbackFragment(key: key,itinerary: itinerary,);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Clicca una stella per recensire",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Rating(
              stars: Data.rating_stars,
            ),
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
              _getTextfield("Cose più importanti da condividere",
                  "Non scrivere più di 50 parole. TODO", 2),
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
                  "Non scrivere più di 50000 parole. TODO",
                  4),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Foto",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                  onPressed: () => {},
                ),
              ]),),
        ],
      ),
    );
  }

  Widget _getTextfield(String hintText, String helperText, int lines) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
        primaryColorDark: Colors.grey,
      ),
      child: Container(
          child: TextField(
        minLines: lines,
        maxLines: lines,
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
