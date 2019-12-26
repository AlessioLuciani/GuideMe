import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class ExploreFragment extends StatelessWidget {
  // Static list of itineraries uploaded by users
  final List<Itinerary> itineraries = [
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Giro de Roma",
        duration: "1.10 ore",
        distance: "7 km",
        priceRange: "0-15",
        longDescription:
            "Bellissimo ed impegnativo percorso in Val Squaranto da Montorio/Ferrazze. Il giro propone due salite e due discese più alcuni mangia e bevi di collegamento. La prima salita porta da Montorio a Maroni. Ci sono ovviamente molte alternative per portarsi a Maroni, io ne propongo qui una che limita al minimo l’asfalto e ritengo (a mio parere) una delle più belle. Da Maroni prendere a dx una mulattiera/sentiero che taglia in costa (versante Squaranto) la montagna."),
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Magna a Roma",
        duration: "1.50 ore",
        distance: "10 km",
        priceRange: "0-32",
        longDescription: "asd"),
    Itinerary(
        coverImage: "assets/images/colosseo.jpg",
        title: "Fori tour",
        duration: "50 minuti",
        distance: "4 km",
        priceRange: "0-1024",
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
