import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/commons/review.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

int currentUserIndex = -1;
const int RATING_STARS = 5;

int get currentMonth => DateTime.now().month;

List<User> users = [
  User(name: "Test", surname: "Test", email: "test"),
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
  User(name: "Luke", surname: "Skywalker", email: "luke@skywalker.com"),
  User(name: "Leyla", surname: "Skywalker", email: "leyla@skywalker.com"),
  User(name: "Darth", surname: "Vader", email: "luke@iamyourfather.com"),
  User(name: "Mr", surname: "Yoda", email: "yoda@mryoda.com"),
  User(name: "Han", surname: "Solo", email: "han@solo.com"),
  User(name: "Rafael", surname: "Nadal", email: "rafael@nadal.com"),
];

List<String> _descriptions = [
  "Bellissimo ed impegnativo percorso in Val Squaranto da Montorio/Ferrazze. Il giro propone due salite e due discese più alcuni mangia e bevi di collegamento. La prima salita porta da Montorio a Maroni. Ci sono ovviamente molte alternative per portarsi a Maroni, io ne propongo qui una che limita al minimo l’asfalto e ritengo (a mio parere) una delle più belle. Da Maroni prendere a dx una mulattiera/sentiero che taglia in costa (versante Squaranto) la montagna.",
  "Un incantevole complesso di edifici e palazzine che merita di essere visitato è senza dubbio il quartiere Coppedé, chiamato così dall’architetto che lo ha progettato e realizzato nei primi anni del 1900: Gino Coppedé.",
  "A dare il benvenuto è un enorme lampadario in ferro battuto posto all’ingresso, ed entrando a Coppedé i visitatori saranno rapiti dai mille dettagli e architetture in stile medievale, liberty, barocchi, con richiami addirittura risalenti all’Antica Grecia.",
  "Mozza il fiato al tramonto, nelle sere d’estate o d’autunno, quando gli alberi sottostanti, sul Lungotevere, si tingono dei colori caldi della Città Eterna. Il Giardino è situato proprio sul colle Aventino, sopra il Circo Massimo, per intenderci, ed è stato da poco incluso nella lista dei luoghi dove è possibile celebrare matrimoni con rito civile!"
];

const int MAX_ITINERARY_LENGTH = 40;
const int MAX_ITINERARY_DURATION_MIN = 60 * 6;
//const Duration MAX_ITINERARY_DURATION = Duration(hours: 24, minutes: 0);

const String MIN_DATETIME = '2020-12-12 00:00:00';
const String MAX_DATETIME = '2020-12-13 23:59:59';
const String INIT_DATETIME = '2020-12-12 12:30:00';
const String DATE_FORMAT = "HHh:mmm";

// Static list of itineraries uploaded by users
List<Itinerary> _itineraries = [
  Itinerary(
      author: users[0],
      coverImage: coverImages[0],
      title: "Giro de Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[0]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[1],
      title: "Magna a Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[3],
      coverImage: coverImages[2],
      title: "Tour al tramonto",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[2]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[3],
      title: "Misteri a Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[3]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[4],
      title: "Tour romano",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[0]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[5],
      title: "Lungo il Tevere",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[6],
      title: "Pantheon e dintorni",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[2]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[7],
      title: "Zone vaticane",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[3]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[8],
      title: "Segreti della roma antica",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[0]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[9],
      title: "Arte barocca a Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[10],
      title: "Le chiese capitoline",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[2]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[11],
      title: "Le cripte nascoste",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[3]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[12],
      title: "Nei sotterranei di Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[0]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[13],
      title: "La Roma nascosta",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[14],
      title: "Luoghi storici a Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[15],
      title: "Antiche residenze romane",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[2]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[16],
      title: "Il luogo dei romani",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[3]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[17],
      title: "L'occhio segreto di Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[0]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[18],
      title: "Un aperitivo a Roma",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[1]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[19],
      title: "Un tuffo nel passato",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[2]),
  Itinerary(
      author: users[1],
      coverImage: coverImages[20],
      title: "Una visita fuoriporta",
      duration: DateTime.parse(MIN_DATETIME).add(Duration(
          hours: generator.nextInt(7) + 1, minutes: generator.nextInt(60))),
      length: generator.nextInt(MAX_ITINERARY_LENGTH - 4) + 4,
      longDescription: _descriptions[3]),
];

List<String> coverImages = [
  "assets/images/colosseo.jpg",
  "assets/images/barberini.jpg",
  "assets/images/rome-sun.jpg",
  "assets/images/rome-night.jpg",
  "assets/images/piazza_navona.jpg",
  "assets/images/rome-1.jpg",
  "assets/images/rome-2.jpg",
  "assets/images/rome-3.jpg",
  "assets/images/rome-4.jpg",
  "assets/images/rome-5.jpg",
  "assets/images/rome-6.jpg",
  "assets/images/rome-7.jpg",
  "assets/images/rome-8.jpg",
  "assets/images/rome-9.jpg",
  "assets/images/rome-10.jpg",
  "assets/images/rome-11.jpg",
  "assets/images/rome-12.jpg",
  "assets/images/rome-13.jpg",
  "assets/images/rome-14.jpg",
  "assets/images/rome-15.jpg",
  "assets/images/rome-16.jpg",
  "assets/images/rome-17.jpg"
];

Random generator = new Random();

List<ItineraryVisit> _visits = [
  new ItineraryVisit(_itineraries[0], users[0], _getRandomDate),
  new ItineraryVisit(_itineraries[3], users[0], _getRandomDate),
  new ItineraryVisit(_itineraries[1], users[0], _getRandomDate),
  new ItineraryVisit(_itineraries[4], users[0], _getRandomDate),
  new ItineraryVisit(_itineraries[7], users[1], _getRandomDate),
  new ItineraryVisit(_itineraries[6], users[2], _getRandomDate),
  new ItineraryVisit(_itineraries[5], users[3], _getRandomDate),
  new ItineraryVisit(_itineraries[8], users[3], _getRandomDate),
  new ItineraryVisit(_itineraries[10], users[3], _getRandomDate),
  new ItineraryVisit(_itineraries[12], users[3], _getRandomDate),
  new ItineraryVisit(_itineraries[13], users[3], _getRandomDate),
];

List<Itinerary> get shuffledItineraries {
  _itineraries.shuffle();
  return _itineraries;
}

List<Itinerary> get itineraries => _itineraries;

void appendItinerary(Itinerary itinerary) => _itineraries.insert(0, itinerary);

DateTime get _getRandomDate =>
    DateTime.now().subtract(new Duration(days: generator.nextInt(365)));

String tempTitle;
String tempDesc;
int tempHours;
int tempMinutes;
List<Itinerary> tempStops;


const String _firstReview =
    "E' una settimana che lo uso, mi sento di confermare la miglioria riguardo alla batteria. Altre funzioni rispetto al precedente oltre a possedere un display a colori, è che si può regolare la sveglia direttamente dal display dello smartband, ci sono svariate possibilità di personalizzazione del proprio display e il lettore del battito cardiaco rileva sul display sin da subito il battito in corso oltre quello medio a conclusione della misurazione. Acquisto consigliato, anche se attualmente mi sento di dire che costa ancora un po tantino.";
const String _secondReview =
    "Le attività monitorabili sono aumentate ed addirittura arriviamo anche al monitoraggio del nuoto con la possibilità di contare le vasche e con il display che, automaticamente, blocca il touch per evitare poblemi a contatto con l’acqua. Durante le attività che richiedono l’utilizzo del GPS, la Mi Band si aggancia al GPS del proprio Smartphone.";
const String _thirdReview =
    "Provengo dalla Mi band 1 con i suoi led di notifica, che mi ha fatto scoprire l’importanza di avere un Tracker al polso. Poi mi sono evoluto e sono divenuto video leggibile (al sole non tanto) ed ho preso la Miband 2 che avevo al polso fino ad ieri, e di cui ne ero soddisfattissimo e strafelice delle sue funzioni. Ho saltato la Miband3 perché non mi piaceva inizialmente la sua forma bombata e che poi in fin dei conti aggiungeva poco alla mia Miband 2. Oggi invece sono passato alla versione Four (come i Fantastici Quattro) ed è adesso un Vero Best Buy!";
const String _fourthReview =
    "Grazie alla forma degli auricolari, è possibile ascoltarli per ore senza alcun fastidio (modelli di marche più conosciute sono risultati molto più scomodi e, ad un certo punto, dolorosi!). Rimangono sempre ben saldi e non tendono mai a cadere. Il pairing tra auricolari e telefono è un'operazione molto veloce, tanto che il manuale l'ho consultato solo dopo qualche ora di utilizzo ma ormai era già inutile nel senso che il funzionamento degli auricolari è così semplice che non occorre nemmeno mettersi a leggere istruzioni. Per iniziare ad utilizzare le cuffie, è sufficiente rimuoverle dalla custodia di ricarica e IN UN ATTIMO gli auricolari si collegano al telefono via Bluetooth, davvero velocissimi! Anche l'ascolto mono, utilizzando solo un auricolare è possibile: basta estrarre solo l'auricolare destro (che funge da auricolare main) dalla custodia e la musica/chiamata verrà trasferita solo a tale auricolare; rimuovendo anche l'altro auricolare, si potrà ascoltare la musica da entrambi, senza dover fare altre operazioni. Ritornare all'ascolto mono è altrettanto semplice, basta reinserire l'auricolare sinistro nel contenitore di ricarica e la musica continua senza interruzioni.";
const String _fifthReview =
    "Appena si inseriscono gli auricolari nella custodia di ricarica, la musica viene interrotta e, se inseriti entrambi, verrà interrotta la riproduzione in automatico. La basetta di ricarica permette la ricarica anche di un solo auricolare alla volta o di tutti e due insieme. Sugli auricolari è presente un LED che si colora di rosso mentre la ricarica è in corso e diventa bianco una volta completata la ricarica. Gli auricolari sono piccoli, non ingombranti e non attirano l'attenzione negativamente, a differenza di altri prodotti della stessa fascia di prezzo. Durante il funzionamento il LED non si accende e non attira inutilmente l'attenzione. La custodia di ricarica permette circa 5 ricariche complete delle cuffie, pari a una ventina di ore di utilizzo degli auricolari, nonostante sia comunque compatta e leggera. Collocare gli auricolari all'interno della custodia di ricarica è semplicissimo, grazie all'attacco magnetico: è impossibile sbagliare e risulta sempre veloce reinserire gli auricolari, in ogni situazione; infine, grazie ai magneti, che assicurano una presa solida, gli auricolari non usciranno mai dalla basetta di ricarica. Dal momento che è sufficiente rimuovere gli auricolari dalla basetta di ricarica per iniziare ad utilizzarli per ascoltare musica o chiamare e basta reinserirli per interromperne l'utilizzo e farli ricaricare, utilizzare questi auricolari risulta davvero semplice e l'operazione è molto veloce.";
const String _sixthReview =
    "Cuffiette acquistate per uso in treno. Di ottimo materiale resistente. Le ho ricaricate ed utilizzate in treno. Grazie ai gommini presenti fatti di ottimo silicone si adattano ai miei padiglioni. Il suono risulta pulito e hai dei bassi davvero potenti nonostante le dimensioni. Il riconoscimento bluetooth è immediato e se ne può usare anche solo una magari in auto come auricolare. Le telefonate inizialmente non capivo perchè sembrassero ovattate poi erano le impostazioni del cellulare e infatti le chiamate risultano chiare, la voce si sente bene. La ricarica delle cuffiette è tramite il supporto che funge anche da power bank. A ricarica piena sono riuscito a ricaricarle altre 3 volte circa e ho avuto un uso di circa 8 ore quindi ottima autonomia se si usano in viaggio. Comode non danno fastidio anche dopo circa 1 ora di utilizzo continuo. Le consiglio sia per il prezzo ma anche per la qualità della musica e della voce.";
const String _seventhReview =
    "Davvero perfette. Per il prezzo mi aspettavo un prodotto mediocre invece sono davvero meglio di quelle di marche famose, si sente fortissimo e la cosa più bella è che insonorizzano completamente da rumori esteri. Il suono è nitido e le due cuffie sono perfettamente sincronizzate. Inoltre sono leggere anche con tutta la custodia da tenere in tasca all'interno c'è una piccola calamita che le tiene ferme quindi non scappano. Non scappano dalle orecchie e basta toccarle che si accendono e si collegano facilmente allo smartphone io mi ci sto trovando molto bene e senza un costo eccessivo le consiglio davvero tanto.";
const String _eigthReview =
    "Ottime cuffie , forse le migliori per me sul mercato tra la fascia economica , si presentano in uno scatolino con manuale di istruzioni, cavo per la ricarica e gommini di diverse grandezze per adattare le cuffiette al proprio orecchio. Si agganciano in modo perfetto all’orecchio senza incertezze .Hanno il Bluetooth 5.0 quindi rapido accoppiamento con lo smartphone se si clicca in maniera prolungata su una delle 2 cuffie parte l’assistente vocale ,un click per stop 2 click per passare avanti al prossimo brano musicale. In chiamata sono ottime la persona dall’altra parte sente bene e senza disturbo.";
const String _ninthReview =
    "Semplicemente perfetto. Questa soluzione da 2 metri ti permette di ricaricare i tuoi dispositivi anche con le prese più distanti dalla scrivania, il divno ecc. Cavo resistentissimo grazie ai materiali utilizzati, discorso valido anche per le prese, protette da materiali rigidi, anche nei punti dove cvi più scadenti tendono a rovinarsi e spezzarsi. La velocità della USB 3.0 poi è davvero appagante e rende questo cavo la prima scelta su ogni fronte. Comodità, resistenza, velocità ed design ottimo, Aukey si riconferma una delle migliori in questa categoria.";
const String _tenthReview =
    "Ho comprato questo cavo perché ne avevo letto bene e perché in passato ho comprato altri prodotti di questa marca e ne sono sempre rimasto soddisfatto. Mi serviva un cavo USB type C per tenere in carica lo smartphone collegandolo al notebook in ufficio e fuori. In passato ho usato cavi da pochi soldi, non di marca e purtroppo erano davvero economici e dopo un po' si rovinavano. Questo cavo invece è bello robusto, la fibra di nylon lo fa percepire davvero robusto fin dal primo impatto e poi non si intreccia facilmente come i cavi normali e poi ha un cinturino che permette di avvolgerlo quando non serve. Lo consiglio vivamente a tutti coloro che cercano un cavo usb C di qualità nettamente superiore alla media.";

final List<String> _reviewDescription = [
  _firstReview,
  _secondReview,
  _thirdReview,
  _fourthReview,
  _fifthReview,
  _sixthReview,
  _seventhReview,
  _eigthReview,
  _ninthReview,
  _tenthReview
];

List<Review> globalReviews = [
  new Review(
      user: users[0],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[0]),
  new Review(
      user: users[1],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[1]),
  new Review(
      user: users[2],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[2]),
  new Review(
      user: users[3],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[3]),
  new Review(
      user: users[4],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[4]),
  new Review(
      user: users[9],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[5]),
  new Review(
      user: users[10],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[6]),
  new Review(
      user: users[11],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[7]),
  new Review(
      user: users[12],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[8]),
  new Review(
      user: users[13],
      time: _getRandomDate,
      rating: generator.nextInt(4) + 2,
      description: _reviewDescription[9]),
];

List<ItineraryVisit> _userVisits = [];

const int MAX_VISITED_ITINERARIES = 7;

void resetUserVisits() => _userVisits.clear();

List<ItineraryVisit> get userVisits {
  if (_userVisits.isEmpty) {
    // Generate at least 3 samples
    int samples = generator.nextInt(MAX_VISITED_ITINERARIES - 6) + 6;
    for (int i = 0; i < samples; i++) {
      ItineraryVisit _visit = _visits[generator.nextInt(_visits.length)];
      if (!_userVisits.contains(_visit)) {
        _userVisits.add(_visit);
      }
    }
    _userVisits.sort((a, b) => b.date.compareTo(a.date));
    return _userVisits;
  }
  return _userVisits;
}

void reviewItinerary(Itinerary itinerary) =>
    _userVisits.removeWhere((visit) => visit.itinerary == itinerary);

List<ItineraryStop> globalStops = [
  ItineraryStop(
      name: "Colosseo",
      coord: LatLng(41.890447, 12.492420),
      description:
          "Chiamato dagli antichi Romani, 'Anphitheatrum Flavlum' (Anfiteatro Flavio), il Colosseo è il più famoso e imponente monumento della Roma Antica, nonchè il più grande anfiteatro del mondo.\nIl nome è sicuramente legato alle grandi dimensioni dell'edificio ma deriva, soprattutto, dal fatto che nelle vicinanze era presente una statua colossale di Nerone in bronzo.\nNel 1990, il Colosseo, insieme a tutto il Centro storico di Roma, le Zone extraterritoriali del Vaticano in Italia e la Basilica di San Paolo fuori le mura, è stato inserito nella lista dei Patrimoni dell'umanità dall'UNESCO, mentre nel luglio del 2007 è stato inserito fra le Nuove sette meraviglie del mondo.\nL'edificazione avvenne nell'area occupata dall'enorme casa di Nerone, la Domus Aurea, costruita dopo il grande incendio di Roma del 64, che doveva essere una valle racchiusa tra i colli della Velia, Palatino,Celio, Oppio, e Fagutale ed era attraversata da un corso d'acqua che correva in direzione del Tevere lungo un percorso che segue grosso modo l'attuale via di San Gregorio.\nLa presenza del laghetto fu abbondantemente sfruttata per risparmiare sulle fondamenta, realizzate in pilastri di travertino poggianti su un anello di calcestruzzo continuo, intervallato solo da alcuni fognoli per lo scorrimento delle acque di falda che, altrimenti, avrebbero allagato tutta l'area.\nDopo l'uccisione dell'imperatore la statua venne rimodellata per raffigurare il dio del Sole, aggiungendo l'appropriata corona solare. Il Colosseo venne quindi spostato dalla sua originale collocazione per far posto al tempio di Venere e Roma sotto Adriano. Il sito del basamento della statua colossale dopo lo spostamento e' attualmente segnato da un moderno basamento in tufo.\nL'Anfiteatro Flavio è di forma ellittica, con una circonferenza di 527 metri, l'asse maggiore lungo 188 metri e l'asse minore 156 alto 57 metri.\nPoteva contenere fino a 70.000 posti e l'arena era di 76 metri x 46. I primi 3 piani erano costituiti da arcate inquadrate da semicolonne, il quarto piano e' scompartito da lesene e vi erano inseriti i pali che sorreggevano il grande velario a spicchi per riparare gli spettatori dal sole."),
  ItineraryStop(
      name: "Fori imperiali",
      coord: LatLng(41.898505, 12.476890),
      description:
          "I Fori Imperiali di Roma raccolgono una serie di piazze monumentali edificate tra il 46 a.C. e il 113 d.C. Vengono considerati il centro dell'attività politica di Roma antica, un luogo che nel corso dei secoli si è arricchito di strutture ed edifici.\nLa prima struttura che si incontra in questo sontuoso complesso è il Foro di Cesare. Questa piazza, voluta da Giulio Cesare per motivi propagandistici, fu inaugurata nel 46 a.C. e terminata dall'imperatore Ottaviano Augusto. La piazza presenta due portici sul lato est e ovest mentre in fondo troneggia il tempio dedicato a Venere Genitrice.\nIl terreno sul quale fu edificata la struttura fu acquistatodirettamente da Cesare; il foro venne accostato alle strutture del vecchio centro politico per attribuirgli maggiore visibilità e prestigio. Proseguendo nel nostro itinerario incontriamo il Foro di Augusto.\nFu realizzato per volere di Ottaviano Augusto, unitamente al tempio di Marte Ultore (dal lat. ultor - vendicatore). Il tempio era stato promesso dall'imperatore in voto al dio in occasione della vittoria nella battaglia di Filippi (42 a.C.). Fu tuttavia inaugurato solo 40 anni dopo e inserito in una seconda piazza monumentale, intitolata appunto ad Augusto.\nLa pianta del foro è ortogonale; sul versante nord si ergeva il tempio di Marte, appoggiato ad un muro (ancora oggi visibile) che divideva il foro dal quartiere popolare della Suburra. \nIl foro è alternato da ampie esedre, destinate a ospitare le attività dei tribunali. Ad arricchire l'area vi erano statue ispirate alla storia di Roma, ai membri della gens Giulia, a Enea e a Romolo.\nÈ il 75 d.C. Vespasiano ha appena conquistato Gerusalemme. Tra il Foro di Augusto e quello di Cesare sorge uno spazio dedicato all'imperatore, inizialmente non compreso all'interno dei Fori e conosciuto come Tempio della Pace. Questo luogo a pianta quadrata aveva le sembianze di un giardino-museo, con vasche d'acqua e basamenti per le statue. L'area, distrutta da un incendio, fu ricostruita durante l'epoca severiana (III sec. d.C.) per ospitare la Forma Urbis Severiana, una pianta di Roma antica incisa su lastre di marmo giunta a noi solo in parte.\nFu Domiziano a realizzare una piazza per unificare lo spazio rimasto libero tra il Tempio della Pace e i Fori di Cesare e di Augusto. L'imperatore non riuscì a inaugurare la propria opera: morì nel 96 d.C., lasciando il trono a Nerva. Nacque così il Foro di Nerva con annesso il tempio di Minerva, protettrice dell'imperatore.  Il foro prese inoltre l'attributo di 'transitorio' per la sua funzione di passaggio.\nI lavori iniziati da Domiziano furono in parte continuati da Traiano, al quale è intitolato il quarto Foro. La piazza veniva utilizzata per accogliere accampamenti militari e, in minima parte, per lo svolgimento delle attività forensi. Alle sue spalle sorge ancora oggi la Colonna di Traiano che racconta le gesta dell'imperatore nella guerra contro i Daci. All'edificazione del Foro seguirono la realizzazione della Basilica Argentaria, dei Mercati Traianei e la ricostruzione del tempio di Venere Genitrice. Si giunge infine alla Basilica Ulpia, la più grande del periodo romano. Costruita su progetto di Apollodoro di Damasco tra il 106 e il 113 d.C. fu inserita nel Foro Traianeo. Lo spazio aveva funzioni forensi e commerciali ma era anche luogo della cosiddetta manomissione (dal lat. manumissio - condono, affrancamento), ossia l'atto pubblico di liberazione di uno schiavo da parte del padrone."),
  ItineraryStop(
      name: "Foro di traiano",
      coord: LatLng(41.892446, 12.485346),
      description:
          "Il Foro di Traiano, ricordato anche come Forum Ulpium in alcune fonti, è il più esteso e monumentale dei Fori Imperiali di Roma, l'ultimo in ordine cronologico. Costruito dall'imperatore Traiano con il bottino di guerra ricavato dalla conquista della Dacia[2], e inaugurato, secondo i Fasti ostiensi[3], nel 112, il foro si disponeva parallelamente al Foro di Cesare e perpendicolarmente a quello di Augusto. Il progetto della struttura è attribuito all'architetto Apollodoro di Damasco."),
  ItineraryStop(
      name: "Piazza di spagna",
      coord: LatLng(41.900890, 12.483260),
      description:
          "Splendido fondale alla via dei Condotti, piazza di Spagna è una delle immagini più famose al mondo, oltre che uno dei complessi urbanistici più monumentali e scenografici di Roma.\nPolo turistico fin dal XVI secolo, quando attirava artisti e letterati ed era già ricca di alberghi, locande ed eleganti edifici residenziali, la piazza assunse l'aspetto attuale soprattutto tra il Sei e il Settecento, con la caratteristica forma 'ad ali di farfalla' , costruita dai due triangoli col vertice in comune. Inizialmente intitolata alla Trinità, dalla chiesa che la domina, venne poi detta piazza di Spagna in riferimento alla residenza dell'ambasciatore spagnolo qui situata.\nAl centro della piazza è la fontana della Barcaccia, del 1629, di Pietro Bernini(padre di GianLorenzo, che collaborò all'opera). Venne realizzata in ricordo dell'alluvione del Tevere del 1598 e la sua forma di barca semisommersa fu un espediente per dissimulare il problema tecnico della scarsa pressione dell'acqua.\nAl centro del triangolo sud-est della piazza si innalza la colonna dell'Immacolata Concezione, rinvenuta nel 1777 nel monastero di S. Maria della Concezione in Campo Marzio e qui collocata nel 1856, a commemorazione del dogma proclamato da Pio IX. Sulla sommità della colonna in cipollino venato, è posta la statua bronzea della Vergine. Poco più avanti, si trova il palazzo di Propaganda Fide, sede dell'omonima congregazione istituita da Gregorio XV nel 1622.\nNel 1644 Bernini ne modificò la facciata sulla piazza mentre Borromini, subentrato come architetto della congregazione nel 1646, realizzò l'ampliamento sulle vie di Propaganda e di Capo le Case: il prospetto sulla via è una delle più innovative e geniali creazioni barocche, con il suo vibrante corpo centrale a elementi curvilinei, l'ordine gigante di lesene tra cui si inseriscono le complesse finestre concave e il contrasto tra il corpo centrale del prospetto, concavo, e il coronamento del finestrone convesso.\nDalla parte opposta della piazza, a partire dal triangolo nord-ovest, si sviluppa la lunga e rettilinea direttrice di Via del Babuino - dal nome della statua a lato della chiesa di S. Anastasio - tracciata tra il 1525 e il 1543, e da sempre considerata la via degli antiquari. Parallelamente si percorre via Margutta, tra le più caratteristiche strade di Roma, tuttora - ma soprattutto durante gli anni '60 - sede di botteghe e di studi di famosi artisti.\nMa è la scalinata centrale che rende la piazza uno degli scenari più spettacolari della città. Fu realizzata da Francesco De Sanctis, nel 1723-26, per volere di Innocenzo XIII, e diede una definitiva sistemazione al notevole dislivello tra la piazza e la superiore chiesa della Trinità. L'ardita soluzione architettonica sostituì un gioco di rampe e di scale che si intersecano e si aprono a ventaglio, alle ripide strade alberate preesistenti.\nIn primavera la scalinata della piazza si colora di meravigliose decorazioni floreali, realizzando un'immagine di rara suggestione, cara ai turisti di tutto il mondo."),
  ItineraryStop(
      name: "Vittoriano",
      coord: LatLng(41.896697, 12.483267),
      description:
          "Il Monumento nazionale a Vittorio Emanuele II o (Mole del) Vittoriano, impropriamente detto Altare della Patria, è un complesso monumentale nazionale italiano situato a Roma in piazza Venezia, sul versante settentrionale del colle del Campidoglio, opera degli architetti Ettore Ferrari e Pio Piacentini, che idearono il progetto di massima, e Giuseppe Sacconi, che fu l'artefice del progetto di dettaglio."),
  ItineraryStop(
      name: "Ara Pacis",
      coord: LatLng(41.906200, 12.475484),
      description:
          "L'Ara Pacis Augustae (Altare della pace di Augusto) è un altare dedicato da Augusto nel 9 a.C. alla Pace, nell'accezione di divinità, e originariamente posto in una zona del Campo Marzio consacrata alla celebrazione delle vittorie, luogo emblematico perché posto a un miglio romano (1.472 m) dal pomerium, limite della città dove il console di ritorno da una spedizione militare perdeva i poteri ad essa relativi (imperium militiae) e rientrava in possesso dei propri poteri civili (imperium domi). Questo monumento rappresenta una delle più significative testimonianze pervenuteci dell'arte augustea ed intende simboleggiare la pace e la prosperità raggiunte come risultato della Pax Romana."),
  ItineraryStop(
      name: "Arco di Costantino",
      coord: LatLng(41.889778, 12.490536),
      description:
          "L'arco di Costantino è un arco trionfale a tre fornici (con un passaggio centrale affiancato da due passaggi laterali più piccoli), situato a Roma, a breve distanza dal Colosseo. Oltre alla notevole importanza storica come monumento, l'Arco può essere considerato come un vero e proprio museo di scultura romana ufficiale, straordinario per ricchezza e importanza[1]. Le dimensioni generali del prospetto sono di 21 m di altezza, 25,9 metri di larghezza e 7,4 m di profondità."),
  ItineraryStop(
      name: "Arco di Tito",
      coord: LatLng(41.890677, 12.488616),
      description:
          "L'arco di Tito è un arco di trionfo ad un solo fornice (ossia con una sola arcata), posto sulle pendici settentrionali del Palatino, nella parte orientale del Foro di Roma. Capolavoro dell'arte romana, si tratta del monumento-simbolo dell'epoca flavia, grazie alle sostanziali innovazioni sia in campo architettonico-strutturale, sia in campo artistico-scultoreo."),
  ItineraryStop(
      name: "Basilica di Porta Maggiore",
      coord: LatLng(41.891748, 12.516533),
      description:
          "La basilica sotterranea di Porta Maggiore è una basilica neopitagorica che si trova a Roma, nel quartiere Prenestino-Labicano, vicino alla Porta Maggiore. È di epoca tiberiana o claudia (tra il 14 ed il 54 d.C.). La sua scoperta avvenne casualmente il 23 aprile 1917, in seguito al cedimento di una volta della basilica, sulla quale si stava costruendo il viadotto ferroviario da e per la stazione Termini e, a livello stradale, la linea tramviaria che serve i quartieri situati lungo la via Prenestina. La Basilica di Porta Maggiore è considerata la più antica basilica pagana di tutto l'Occidente."),
  ItineraryStop(
      name: "Cappella Sistina",
      coord: LatLng(41.902948, 12.454442),
      description:
          "La Cappella Sistina (Latino: Sacellum Sixtinum), dedicata a Maria Assunta in Cielo[1], è la principale cappella del palazzo apostolico, nonché uno dei più famosi tesori culturali e artistici della Città del Vaticano, inserita nel percorso dei Musei Vaticani. Fu costruita tra il 1475 e il 1481 circa, all'epoca di papa Sisto IV della Rovere, da cui prese il nome."),
  ItineraryStop(
      name: "Piramide Cestia",
      coord: LatLng(41.876422, 12.480893),
      description:
          "La Piramide Cestia (o Piramide di Caio Cestio, Sepulcrum Cestii in latino) è una piramide di stile egizio costruita a Roma tra il 18 e il 12 a.C. Si trova nelle immediate adiacenze di porta San Paolo ed è inglobata nel perimetro del posteriore cimitero acattolico, costruito tra il XVIII e il XIX secolo."),
  ItineraryStop(
      name: "Teatro Marcello",
      coord: LatLng(41.891919, 12.479898),
      description:
          "Il teatro di Marcello (in latino: Theatrum Marcelli) è un teatro della Roma antica, tuttora parzialmente conservato, innalzato per volere di Augusto nella zona meridionale del Campo Marzio (nota come Circo Flaminio) tra il fiume Tevere e il Campidoglio."),
  ItineraryStop(
      name: "Galleria Borghese",
      coord: LatLng(41.902757, 12.496356),
      description:
          "Galleria Borghese si trova in piazzale del Museo Borghese 5, all'interno di villa Borghese Pinciana a Roma in Italia. Il museo espone opere di Gian Lorenzo Bernini, Agnolo Bronzino, Antonio Canova, Caravaggio, Raffaello, Perugino, Lorenzo Lotto, Antonello da Messina, Cranach, Annibale Carracci, Pieter Paul Rubens, Bellini, Tiziano. Si può considerare unica al mondo per quel che riguarda il numero e l'importanza delle sculture del Bernini e delle tele del Caravaggio."),
  ItineraryStop(
      name: "Palazzo Venezia",
      coord: LatLng(41.896116, 12.481655),
      description:
          "Palazzo Barbo o Palazzo Venezia è un palazzo di Roma compreso tra piazza Venezia e via del Plebiscito a Roma. Vi ha sede il Museo nazionale di Palazzo Venezia e, al n. 3 della omonima piazza, la sede dell'INASA (Istituto Nazionale di Archeologia e Storia dell'Arte) con la biblioteca di Archeologia e Storia dell'Arte. Dal dicembre 2014 palazzo Venezia è divenuta la sede del Polo Museale del Lazio."),
];

int currentMsgIndex = 0;
List<String> _confirmMsgs = ["Recensione inviata!", "Itinerario creato!"];

String get confirmMsg => _confirmMsgs[currentMsgIndex];
