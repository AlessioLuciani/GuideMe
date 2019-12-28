import 'package:GuideMe/commons/image_loader.dart';
import 'package:GuideMe/commons/rating.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class FeedbackFragment extends StatelessWidget {
  final String title = "Giro de Roma";

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

  @override
  Widget builda(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Clicca una stella per recensire",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                Rating(
                  stars: Data.rating_stars,
                ),
                Divider(),
                Text(
                  "Titolo",
                  textAlign: TextAlign.start,
                ),
                Container(
                  height: 200,
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.all(10.0),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200.0,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SizedBox(
                          height: 190.0,
                          child: new TextField(
                            maxLines: 100,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add your text here',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Titolo",
                          style: TextStyle(fontSize: 25),
                        ),
                        TextField(
                          maxLines: 1, //constant
                          maxLength: 35, //constant
                          decoration: InputDecoration(
                            hintText: "Giro nel bel mezzo di roma!", //constant
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Descrizione",
                          style: TextStyle(color: Colors.blue, fontSize: 25),
                        ),
                        TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          maxLength: 300, //constant
                          decoration: InputDecoration(
                            hintText:
                                "Il giro è stato entusiasmante e ....", //constant
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Aggiungi Immagini",
                            style: TextStyle(color: Colors.blue, fontSize: 25),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ImageLoader()),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
