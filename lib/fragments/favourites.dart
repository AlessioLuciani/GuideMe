import 'dart:io';

import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class FavouritesFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Itinerary> data = favouriteItineraries;

    if (data.length == 0) {
      return SafeArea(
          child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Platform.isAndroid
                ? Text("")
                : Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Preferiti",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)))),
        SizedBox(height: Platform.isAndroid ? 10 : 20),
        Expanded(
            child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Text(
                "Non ci sono itinerari tra i tuoi preferiti. \nPuoi aggiungerne uno selezionandolo dalla sezione Esplora.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18)),
          ),
        ))
      ]));
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Platform.isIOS ? 20 : 0,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Platform.isAndroid
                  ? Text("")
                  : Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Preferiti",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)))),
          SizedBox(height: Platform.isAndroid ? 0 : 20),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) => Container(
                  // Add padding to the last item of the list
                  padding: index == data.length - 1
                      ? EdgeInsets.only(bottom: 10)
                      : EdgeInsets.only(bottom: 0),
                  // Form a new card from the current itinerary information
                  child: ExploreCard(
                    itinerary: data[index],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
