import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class FavouritesFragment extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    List<Itinerary> data = Utils.favouriteItineraries;
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) => Container(
            // Add padding to the last item of the list
            padding: index == data.length - 1
                ? EdgeInsets.only(bottom: 10)
                : null,
            // Form a new card from the current itinerary information
            child: ExploreCard(
              itinerary: data[index],
            )),
      ),
    );
  }

}