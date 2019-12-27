import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Data {
  static int currentUserIndex = 0;
  static int rating_stars = 5;

  static List<User> users = [
    User(name: "John", surname: "Smith", email: "john@smith.com"),
    User(name: "Luca", surname: "Rossi", email: "luca@rossi.com"),
    User(name: "Luigi", surname: "Bianchi", email: "luigi@bianchi.com"),
    User(name: "Chris", surname: "Milly", email: "chris@milly.com"),
    User(
        name: "Leonardo",
        surname: "Emili",
        email: "emili.1802989@studenti.uniroma1.it"),
    User(
        name: "Alessio",
        surname: "Luciani",
        email: "luciani.1797637@studenti.uniroma1.it"),
    User(
        name: "Giorgio",
        surname: "Belli",
        email: "belli.1797941@studenti.uniroma1.it"),
    User(
        name: "Giorgio",
        surname: "Agosta",
        email: "agosta.1795537@studenti.uniroma1.it"),
  ];

  // Static list of itineraries uploaded by users
  static List<Itinerary> itineraries = [
    Itinerary(
        author: users[0],
        coverImage: "assets/images/colosseo.jpg",
        title: "Giro de Roma",
        duration: "1.10 ore",
        distance: "7 km",
        priceRange: "0-15",
        stops: [stops[0], stops[1], stops[2]],
        longDescription:
            "Bellissimo ed impegnativo percorso in Val Squaranto da Montorio/Ferrazze. Il giro propone due salite e due discese più alcuni mangia e bevi di collegamento. La prima salita porta da Montorio a Maroni. Ci sono ovviamente molte alternative per portarsi a Maroni, io ne propongo qui una che limita al minimo l’asfalto e ritengo (a mio parere) una delle più belle. Da Maroni prendere a dx una mulattiera/sentiero che taglia in costa (versante Squaranto) la montagna."),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-sun.jpg",
        title: "Magna a Roma",
        duration: "1.50 ore",
        distance: "10 km",
        priceRange: "0-32",
        stops: [stops[3], stops[2], stops[1]],
        longDescription: "asd"),
    Itinerary(
        author: users[3],
        coverImage: "assets/images/rome-night.jpg",
        title: "Tour al tramonto",
        duration: "7 minuti",
        distance: "0.2 km",
        priceRange: "0-1024",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: "asd"),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/piazza_navona.jpg",
        title: "Misteri a Roma",
        duration: "42 minuti",
        distance: "4 km",
        priceRange: "0-1024",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: "asd"),
  ];

  static List<ItineraryVisit> visits = [
    new ItineraryVisit(itineraries[0], users[0]),
    new ItineraryVisit(itineraries[1], users[0]),
    new ItineraryVisit(itineraries[2], users[0]),
    new ItineraryVisit(itineraries[1], users[1]),
    new ItineraryVisit(itineraries[2], users[2]),
    new ItineraryVisit(itineraries[3], users[3]),
  ];

  // static List<ItineraryVisit> visits = [];

  //final List<ItineraryStop> = [name: ItineraryStop("Colosseo", coord: LatLng(3.0, 4.0))];
  static List<ItineraryStop> stops = [
    ItineraryStop(name: "Colosseo", coord: LatLng(41.890447, 12.492420)),
    ItineraryStop(name: "Fori imperiali", coord: LatLng(41.898505, 12.476890)),
    ItineraryStop(name: "Arco di traiano", coord: LatLng(41.892446, 12.485346)),
    ItineraryStop(
        name: "Piazza di spagna", coord: LatLng(41.900890, 12.483260)),
    ItineraryStop(
        name: "Mole antonelliana", coord: LatLng(41.906479, 12.453602)),
  ];
}
