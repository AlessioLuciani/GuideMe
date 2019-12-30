import 'dart:io';

import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 20, top: 20),
        child: Platform.isAndroid ? null : Text("Esplora", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
      SizedBox(height: Platform.isAndroid ? 10 : 20),
      Expanded(child:
      ListView.builder(
        itemCount: Data.itineraries.length,
        itemBuilder: (_, index) => Container(
          // Add padding to the last item of the list
          padding: index == Data.itineraries.length - 1
              ? EdgeInsets.only(bottom: 10)
              : null,
          // Form a new card from the current itinerary information
          child: ExploreCard(
            itinerary: Data.itineraries[index],
          )),
      )),]));
  }
}
