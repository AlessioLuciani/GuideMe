import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';

class ExploreVisitedFragment extends StatelessWidget{

  List<ItineraryVisit> _visits = [];

  ExploreVisitedFragment({Key key}) : super(key:key);

  ExploreVisitedFragment.fromList({Key key, @required List<ItineraryVisit> visits}) : super(key:key){
    this._visits = visits;
  }

  @override
  Widget build(BuildContext context) {

    if(Data.visits.isEmpty) return Center(
      child: Text(
        "Sembra che tu non abbia ancora seguito nessun itinerario.\nChe aspetti!!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blue, //constant
          fontSize: 18,
        ),
      ));

    this._visits = Data.visits.where((visit) => visit.user == Data.users[Data.currentUserIndex]).toList();

    return Center(
      child: ListView.builder(
        itemCount: this._visits.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return VisitCard(
            visit: this._visits.elementAt(index),
          );
        },
      ),
    );
  }

}


class VisitCard extends StatelessWidget{

  ItineraryVisit _visit;

  VisitCard({Key key, @required ItineraryVisit visit}) : super(key:key){
    this._visit = visit;
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            this._visit.itinerary.coverImage,
            fit: BoxFit.cover,
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
                          onPressed: () => true,
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