import 'package:GuideMe/base_layouts/android_layout.dart';
import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/pages/review_page.dart';
import 'package:flutter/material.dart';

class VisitCard extends StatelessWidget{

  ItineraryVisit _visit;

  VisitCard({Key key, @required ItineraryVisit visit}) : super(key:key){
    this._visit = visit;
  }

  void navigateToReviewRoute(BuildContext context){
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FeedbackFragment(itinerary: _visit.itinerary,)),
                //builder: (context) => TestMapPolyline()),
          );
    //Navigator.push(context, MaterialPageRoute(builder: (context) => AndroidLayout.fromIndex(5, {#itinerary: this._visit.itinerary})));
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.asset(
            this._visit.itinerary.coverImage,
            fit: BoxFit.cover,
            )
          ),
          ListTile(
                
                contentPadding: EdgeInsets.only(left: 10, top: 2),
                title: Text(
                  this._visit.itinerary.title,
                  style: TextStyle(fontSize: 22),
                ),

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Visitato il ${this._visit.dateTime.day}/${this._visit.dateTime.month}/${this._visit.dateTime.year}"),
                    GestureDetector(
                      onTap: () => true,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FlatButton(
                          child: Text("Recensisci"),
                          onPressed: () => navigateToReviewRoute(context),
                          color: Colors.blue,
                          textColor: Colors.white,
                          
                        ),
                      )
                    )
                  ]
                )
              )
            ],
          )
    );

  }

}