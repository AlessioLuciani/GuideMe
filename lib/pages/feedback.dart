import 'package:GuideMe/commons/image_loader.dart';
import 'package:GuideMe/commons/rating.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';


class FeedbackFragment extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Quanto ti è piaciuto l'itinerario?",
                  style: TextStyle(
                    color: Colors.blue
                  ),
                ),
                Rating(stars: Data.rating_stars,),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 5),
                  child: Text(
                    "Recensione",
                    style: TextStyle(
                    fontSize: 18
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
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25
                        ),
                      ),
                      TextField(
                        maxLines: 1, //constant
                        maxLength: 35, //constant
                        decoration: InputDecoration(
                          hintText: "Giro nel bel mezzo di roma!", //constant
                        ),
                      ),
                    ] 
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Descrizione",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        maxLength: 300, //constant
                        decoration: InputDecoration(
                          hintText: "Il giro è stato entusiasmante e ....", //constant
                        ),
                      ),
                    ] 
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Aggiungi Immagini",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ImageLoader()
                      ),
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

  
}

