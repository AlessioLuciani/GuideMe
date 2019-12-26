import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreFragment extends StatelessWidget {
  static User author =
      User(name: "John", surname: "Smith", email: "john@smith.com");

  //final List<ItineraryStop> = [name: ItineraryStop("Colosseo", coord: LatLng(3.0, 4.0))];
  static List<ItineraryStop> stops = [
    ItineraryStop(name: "Colosseo", coord: LatLng(41.890447, 12.492420)),
    ItineraryStop(name: "Fori imperiali", coord: LatLng(41.898505, 12.476890)),
    ItineraryStop(name: "Arco di traiano", coord: LatLng(41.892446, 12.485346)),
    ItineraryStop(name: "Piazza di spagna", coord: LatLng(41.900890, 12.483260)),
    ItineraryStop(name: "Mole antonelliana", coord: LatLng(41.906479, 12.453602)),
  ];
  // Static list of itineraries uploaded by users
  final List<Itinerary> itineraries = [
    Itinerary(
        author: author,
        coverImage: "assets/images/colosseo.jpg",
        title: "Giro de Roma",
        duration: "1.10 ore",
        distance: "7 km",
        priceRange: "0-15",
        stops: [stops[0], stops[1], stops[2]],
        longDescription:
            "Bellissimo ed impegnativo percorso in Val Squaranto da Montorio/Ferrazze. Il giro propone due salite e due discese più alcuni mangia e bevi di collegamento. La prima salita porta da Montorio a Maroni. Ci sono ovviamente molte alternative per portarsi a Maroni, io ne propongo qui una che limita al minimo l’asfalto e ritengo (a mio parere) una delle più belle. Da Maroni prendere a dx una mulattiera/sentiero che taglia in costa (versante Squaranto) la montagna."),
    Itinerary(
        author: author,
        coverImage: "assets/images/rome-sun.jpg",
        title: "Magna a Roma",
        duration: "1.50 ore",
        distance: "10 km",
        priceRange: "0-32",
        stops: [stops[3], stops[2], stops[1]],
        longDescription: "asd"),
    Itinerary(
        author: author,
        coverImage: "assets/images/barberini.jpg",
        title: "Fori tour",
        duration: "50 minuti",
        distance: "4 km",
        priceRange: "0-1024",
        stops: [stops[2], stops[3], stops[1]],
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
