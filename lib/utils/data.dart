import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class Data {
  static int currentUserIndex = 0;
  static int RATING_STARS = 5;

  static List<String> months = [
    "Gennaio",
    "Febbraio",
    "Marzo",
    "Aprile",
    "Maggio",
    "Giugno",
    "Luglio",
    "Agosto",
    "Settembre",
    "Ottobre",
    "Novembre",
    "Dicembre"
  ];

  static int get currentMonth => DateTime.now().month;

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

  static List<String> _descriptions = [
    "Bellissimo ed impegnativo percorso in Val Squaranto da Montorio/Ferrazze. Il giro propone due salite e due discese più alcuni mangia e bevi di collegamento. La prima salita porta da Montorio a Maroni. Ci sono ovviamente molte alternative per portarsi a Maroni, io ne propongo qui una che limita al minimo l’asfalto e ritengo (a mio parere) una delle più belle. Da Maroni prendere a dx una mulattiera/sentiero che taglia in costa (versante Squaranto) la montagna.",
    "Un incantevole complesso di edifici e palazzine che merita di essere visitato è senza dubbio il quartiere Coppedé, chiamato così dall’architetto che lo ha progettato e realizzato nei primi anni del 1900: Gino Coppedé.",
    "A dare il benvenuto è un enorme lampadario in ferro battuto posto all’ingresso, ed entrando a Coppedé i visitatori saranno rapiti dai mille dettagli e architetture in stile medievale, liberty, barocchi, con richiami addirittura risalenti all’Antica Grecia.",
    "Mozza il fiato al tramonto, nelle sere d’estate o d’autunno, quando gli alberi sottostanti, sul Lungotevere, si tingono dei colori caldi della Città Eterna. Il Giardino è situato proprio sul colle Aventino, sopra il Circo Massimo, per intenderci, ed è stato da poco incluso nella lista dei luoghi dove è possibile celebrare matrimoni con rito civile!"
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
        longDescription: _descriptions[0]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-sun.jpg",
        title: "Magna a Roma",
        duration: "1.50 ore",
        distance: "10 km",
        priceRange: "0-32",
        stops: [stops[3], stops[2], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[3],
        coverImage: "assets/images/rome-night.jpg",
        title: "Tour al tramonto",
        duration: "7 minuti",
        distance: "0.2 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[2]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/piazza_navona.jpg",
        title: "Misteri a Roma",
        duration: "42 minuti",
        distance: "4 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[3]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-1.jpg",
        title: "Tour romano",
        duration: "12 minuti",
        distance: "13 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[0]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-2.jpg",
        title: "Lungo il Tevere",
        duration: "42 minuti",
        distance: "4 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-3.jpg",
        title: "Pantheon e dintorni",
        duration: "22 minuti",
        distance: "6 km",
        priceRange: "0-32",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[2]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-4.jpg",
        title: "Zone vaticane",
        duration: "36 minuti",
        distance: "9 km",
        priceRange: "0-32",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[3]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-5.jpg",
        title: "I segreti della roma antica",
        duration: "10 minuti",
        distance: "1 km",
        priceRange: "0-32",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[0]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-6.jpg",
        title: "Arte barocca a Roma",
        duration: "15 minuti",
        distance: "2 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-7.jpg",
        title: "Le chiese capitoline",
        duration: "140 minuti",
        distance: "7 km",
        priceRange: "0-32",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[2]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-8.jpg",
        title: "Le cripte nascoste",
        duration: "90 minuti",
        distance: "7 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[3]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-9.jpg",
        title: "Nei sotterranei di Roma",
        duration: "50 minuti",
        distance: "4 km",
        priceRange: "0-128",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[0]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-10.jpg",
        title: "La Roma nascosta",
        duration: "300 minuti",
        distance: "20 km",
        priceRange: "0-256",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-11.jpg",
        title: "Luoghi storici a Roma",
        duration: "350 minuti",
        distance: "24 km",
        priceRange: "0-512",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-12.jpg",
        title: "Le antiche residenze romane",
        duration: "400 minuti",
        distance: "30 km",
        priceRange: "0-2",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[2]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-13.jpg",
        title: "Dove si incontrano i romani",
        duration: "44 minuti",
        distance: "4 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[3]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-14.jpg",
        title: "L'occhio segreto di Roma",
        duration: "90 minuti",
        distance: "11 km",
        priceRange: "0-64",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[0]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-15.jpg",
        title: "Un aperitivo a Roma",
        duration: "38 minuti",
        distance: "2 km",
        priceRange: "0-1024",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[1]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-16.jpg",
        title: "Un tuffo nel passato",
        duration: "20 minuti",
        distance: "3 km",
        priceRange: "0-512",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[2]),
    Itinerary(
        author: users[1],
        coverImage: "assets/images/rome-17.jpg",
        title: "Una visita fuoriporta",
        duration: "15 minuti",
        distance: "5 km",
        priceRange: "0-128",
        stops: [stops[2], stops[3], stops[1]],
        longDescription: _descriptions[3]),
  ];

  static Random _generator = new Random();

  static List<ItineraryVisit> _visits = [
    new ItineraryVisit(itineraries[0], users[0],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[3], users[0],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[1], users[0],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[4], users[0],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[7], users[1],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[6], users[2],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[5], users[3],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[8], users[3],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[10], users[3],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[12], users[3],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
    new ItineraryVisit(itineraries[13], users[3],
        DateTime.now().subtract(new Duration(days: _generator.nextInt(365)))),
  ];

  static List<ItineraryVisit> _userVisits = [];

  static const int MAX_VISITED_ITINERARIES = 7;

  static void resetUserVisits() => _userVisits.clear();

  static List<ItineraryVisit> get userVisits {
    if (_userVisits.isEmpty) {
      // Generate at least 3 samples
      int samples = _generator.nextInt(MAX_VISITED_ITINERARIES - 6) + 6;
      for (int i = 0; i < samples; i++) {
        ItineraryVisit _visit = _visits[_generator.nextInt(_visits.length)];
        if (!_userVisits.contains(_visit)) {
          _userVisits.add(_visit);
        }
      }
      _userVisits.sort((a, b) => b.date.compareTo(a.date));
      return _userVisits;
    }
    return _userVisits;
  }

  static void reviewItinerary(Itinerary itinerary) =>
      _userVisits.removeWhere((visit) => visit.itinerary == itinerary);

  static List<ItineraryStop> stops = [
    ItineraryStop(name: "Colosseo", coord: LatLng(41.890447, 12.492420)),
    ItineraryStop(name: "Fori imperiali", coord: LatLng(41.898505, 12.476890)),
    ItineraryStop(name: "Arco di traiano", coord: LatLng(41.892446, 12.485346)),
    ItineraryStop(
        name: "Piazza di spagna", coord: LatLng(41.900890, 12.483260)),
    ItineraryStop(
        name: "Mole antonelliana", coord: LatLng(41.906479, 12.453602)),
  ];

  static int currentMsgIndex = 0;
  static List<String> _confirmMsgs = [
    "Recensione inviata!",
    "Itinerario creato!"
  ];

  static String get confirmMsg => _confirmMsgs[currentMsgIndex];
}
