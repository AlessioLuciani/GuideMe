import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/visited_card.dart';
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

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 8),
      child: Center(
        child: ListView.builder(
          itemCount: this._visits.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return VisitCard(
              visit: this._visits.elementAt(index),
            );
          },
        ),
      ),
    );
  }

}