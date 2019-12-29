import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/visited_card.dart';
import 'package:flutter/material.dart';

class ExploreVisitedFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Data.userVisits.isEmpty)
      return Center(
          child: Text(
        "Sembra che tu non abbia ancora seguito nessun itinerario.\nChe aspetti!!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ));

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 8),
      child: Center(
        child: ListView.builder(
          itemCount: Data.userVisits.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return VisitCard(
              visit: Data.userVisits.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}