import 'package:GuideMe/explore_card.dart';
import 'package:GuideMe/utils/Itinerary.dart';
import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  // Static list of itineraries uploaded by users
  final List<Itinerary> itineraries = [
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Giro de Roma",
        duration: "1.10 ore",
        distance: "7 km",
        longDescription: "asd"),
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Magna a Roma",
        duration: "1.50 ore",
        distance: "10 km",
        longDescription: "asd"),
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Fori tour",
        duration: "50 minuti",
        distance: "4 km",
        longDescription: "asd"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: itineraries.length,
        itemBuilder: (_, index) => Container(
            // Add padding to the last item of the list
            padding: index == itineraries.length - 1
                ? EdgeInsets.only(bottom: 10)
                : null,
            // Form a new card from the current itinerary information
            child: ExploreCard(
              itinerary: itineraries[index],
            )),
      ),
    );
  }
}
