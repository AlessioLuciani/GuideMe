import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
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
      ),
    );
  }
}
