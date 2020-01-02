import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class Data {
  static int currentUserIndex = 0;
  static const int RATING_STARS = 5;

  static int get currentMonth => DateTime.now().month;

  static List<User> users = [
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
    ItineraryStop(name: "Colosseo", coord: LatLng(41.890447, 12.492420), 
      description: "Chiamato dagli antichi Romani, 'Anphitheatrum Flavlum' (Anfiteatro Flavio), il Colosseo è il più famoso e imponente monumento della Roma Antica, nonchè il più grande anfiteatro del mondo.\nIl nome è sicuramente legato alle grandi dimensioni dell'edificio ma deriva, soprattutto, dal fatto che nelle vicinanze era presente una statua colossale di Nerone in bronzo.\nNel 1990, il Colosseo, insieme a tutto il Centro storico di Roma, le Zone extraterritoriali del Vaticano in Italia e la Basilica di San Paolo fuori le mura, è stato inserito nella lista dei Patrimoni dell'umanità dall'UNESCO, mentre nel luglio del 2007 è stato inserito fra le Nuove sette meraviglie del mondo.\nL'edificazione avvenne nell'area occupata dall'enorme casa di Nerone, la Domus Aurea, costruita dopo il grande incendio di Roma del 64, che doveva essere una valle racchiusa tra i colli della Velia, Palatino,Celio, Oppio, e Fagutale ed era attraversata da un corso d'acqua che correva in direzione del Tevere lungo un percorso che segue grosso modo l'attuale via di San Gregorio.\nLa presenza del laghetto fu abbondantemente sfruttata per risparmiare sulle fondamenta, realizzate in pilastri di travertino poggianti su un anello di calcestruzzo continuo, intervallato solo da alcuni fognoli per lo scorrimento delle acque di falda che, altrimenti, avrebbero allagato tutta l'area.\nDopo l'uccisione dell'imperatore la statua venne rimodellata per raffigurare il dio del Sole, aggiungendo l'appropriata corona solare. Il Colosseo venne quindi spostato dalla sua originale collocazione per far posto al tempio di Venere e Roma sotto Adriano. Il sito del basamento della statua colossale dopo lo spostamento e' attualmente segnato da un moderno basamento in tufo.\nL'Anfiteatro Flavio è di forma ellittica, con una circonferenza di 527 metri, l'asse maggiore lungo 188 metri e l'asse minore 156 alto 57 metri.\nPoteva contenere fino a 70.000 posti e l'arena era di 76 metri x 46. I primi 3 piani erano costituiti da arcate inquadrate da semicolonne, il quarto piano e' scompartito da lesene e vi erano inseriti i pali che sorreggevano il grande velario a spicchi per riparare gli spettatori dal sole."),
    ItineraryStop(name: "Fori imperiali", coord: LatLng(41.898505, 12.476890),
      description: "I Fori Imperiali di Roma raccolgono una serie di piazze monumentali edificate tra il 46 a.C. e il 113 d.C. Vengono considerati il centro dell'attività politica di Roma antica, un luogo che nel corso dei secoli si è arricchito di strutture ed edifici.\nLa prima struttura che si incontra in questo sontuoso complesso è il Foro di Cesare. Questa piazza, voluta da Giulio Cesare per motivi propagandistici, fu inaugurata nel 46 a.C. e terminata dall'imperatore Ottaviano Augusto. La piazza presenta due portici sul lato est e ovest mentre in fondo troneggia il tempio dedicato a Venere Genitrice.\nIl terreno sul quale fu edificata la struttura fu acquistatodirettamente da Cesare; il foro venne accostato alle strutture del vecchio centro politico per attribuirgli maggiore visibilità e prestigio. Proseguendo nel nostro itinerario incontriamo il Foro di Augusto.\nFu realizzato per volere di Ottaviano Augusto, unitamente al tempio di Marte Ultore (dal lat. ultor - vendicatore). Il tempio era stato promesso dall'imperatore in voto al dio in occasione della vittoria nella battaglia di Filippi (42 a.C.). Fu tuttavia inaugurato solo 40 anni dopo e inserito in una seconda piazza monumentale, intitolata appunto ad Augusto.\nLa pianta del foro è ortogonale; sul versante nord si ergeva il tempio di Marte, appoggiato ad un muro (ancora oggi visibile) che divideva il foro dal quartiere popolare della Suburra. \nIl foro è alternato da ampie esedre, destinate a ospitare le attività dei tribunali. Ad arricchire l'area vi erano statue ispirate alla storia di Roma, ai membri della gens Giulia, a Enea e a Romolo.\nÈ il 75 d.C. Vespasiano ha appena conquistato Gerusalemme. Tra il Foro di Augusto e quello di Cesare sorge uno spazio dedicato all'imperatore, inizialmente non compreso all'interno dei Fori e conosciuto come Tempio della Pace. Questo luogo a pianta quadrata aveva le sembianze di un giardino-museo, con vasche d'acqua e basamenti per le statue. L'area, distrutta da un incendio, fu ricostruita durante l'epoca severiana (III sec. d.C.) per ospitare la Forma Urbis Severiana, una pianta di Roma antica incisa su lastre di marmo giunta a noi solo in parte.\nFu Domiziano a realizzare una piazza per unificare lo spazio rimasto libero tra il Tempio della Pace e i Fori di Cesare e di Augusto. L'imperatore non riuscì a inaugurare la propria opera: morì nel 96 d.C., lasciando il trono a Nerva. Nacque così il Foro di Nerva con annesso il tempio di Minerva, protettrice dell'imperatore.  Il foro prese inoltre l'attributo di 'transitorio' per la sua funzione di passaggio.\nI lavori iniziati da Domiziano furono in parte continuati da Traiano, al quale è intitolato il quarto Foro. La piazza veniva utilizzata per accogliere accampamenti militari e, in minima parte, per lo svolgimento delle attività forensi. Alle sue spalle sorge ancora oggi la Colonna di Traiano che racconta le gesta dell'imperatore nella guerra contro i Daci. All'edificazione del Foro seguirono la realizzazione della Basilica Argentaria, dei Mercati Traianei e la ricostruzione del tempio di Venere Genitrice. Si giunge infine alla Basilica Ulpia, la più grande del periodo romano. Costruita su progetto di Apollodoro di Damasco tra il 106 e il 113 d.C. fu inserita nel Foro Traianeo. Lo spazio aveva funzioni forensi e commerciali ma era anche luogo della cosiddetta manomissione (dal lat. manumissio - condono, affrancamento), ossia l'atto pubblico di liberazione di uno schiavo da parte del padrone."),
    ItineraryStop(name: "Arco di traiano", coord: LatLng(41.892446, 12.485346),
      description: "L'arco di Traiano di Roma era un arco del quale si hanno testimonianze letterarie e monetali, ma del quale non si conosce con certezza la collocazione. Forse non venne mai effettivamente eretto. Secondo i cataloghi regionari si trovava nella Regio I Porta Capena.\nUn arco in onore dell'imperatore Traiano è ricordato come decretato dal Senato nel 117. Durante il XIX secolo gli studiosi formularono varie ipotesi sulla sua collocazione, che sembrava più probabile entro il Foro di Traiano stesso, forse dell'ingresso monumentale del Foro, in collegamento col Foro di Augusto, forse come struttura indipendente.\nEsiste infatti un aureo con la raffigurazione di un arco, a fornice unico e sormontato dal carro trionfale imperiale, scandito verticalmente in cinque sezioni scandite da sei colonne; accanto al fornice centrale sono raffigurate due nicchie con timpano per ciascun lato, dove si supposero conservate le statue dei prigionieri Daci (presenti oggi nell'arco di Costantino). Sopra le nicchie vi erano altrettanti scudi con ritratto (imagines clipeatae). Il carro trionfale era trainato da sei cavalli e fiancheggiato da trofei con vittorie.\nIn realtà la raffigurazione monetale non rappresenterebbe nemmeno un arco, ma forse la recinzione meridionale della piazza (forse i resti rimessi in luce nei recenti scavi del Giubileo, mentre nella stessa occasione non furono ritrovate tracce di archi); può darsi che l'accesso sud alla piazza fosse stato monumentalizzato come arco trionfale e dedicato poi effettivamente come tale dal Senato al Traiano, eventualmente con la semplice apposizione di un'iscrizione. Altre interpretazioni sono tuttora in discussione, con parecchie diverse ipotesi, dato che la cosa coinvolge l'aspetto dei lati nord e sud della piazza e la posizione del tempio del Divo Traiano e Plotina, un altro monumento la cui collocazione tradizionale è stata discussa durante i recenti scavi."),
    ItineraryStop(
        name: "Piazza di spagna", coord: LatLng(41.900890, 12.483260),
          description: "Splendido fondale alla via dei Condotti, piazza di Spagna è una delle immagini più famose al mondo, oltre che uno dei complessi urbanistici più monumentali e scenografici di Roma.\nPolo turistico fin dal XVI secolo, quando attirava artisti e letterati ed era già ricca di alberghi, locande ed eleganti edifici residenziali, la piazza assunse l'aspetto attuale soprattutto tra il Sei e il Settecento, con la caratteristica forma 'ad ali di farfalla' , costruita dai due triangoli col vertice in comune. Inizialmente intitolata alla Trinità, dalla chiesa che la domina, venne poi detta piazza di Spagna in riferimento alla residenza dell'ambasciatore spagnolo qui situata.\nAl centro della piazza è la fontana della Barcaccia, del 1629, di Pietro Bernini(padre di GianLorenzo, che collaborò all'opera). Venne realizzata in ricordo dell'alluvione del Tevere del 1598 e la sua forma di barca semisommersa fu un espediente per dissimulare il problema tecnico della scarsa pressione dell'acqua.\nAl centro del triangolo sud-est della piazza si innalza la colonna dell'Immacolata Concezione, rinvenuta nel 1777 nel monastero di S. Maria della Concezione in Campo Marzio e qui collocata nel 1856, a commemorazione del dogma proclamato da Pio IX. Sulla sommità della colonna in cipollino venato, è posta la statua bronzea della Vergine. Poco più avanti, si trova il palazzo di Propaganda Fide, sede dell'omonima congregazione istituita da Gregorio XV nel 1622.\nNel 1644 Bernini ne modificò la facciata sulla piazza mentre Borromini, subentrato come architetto della congregazione nel 1646, realizzò l'ampliamento sulle vie di Propaganda e di Capo le Case: il prospetto sulla via è una delle più innovative e geniali creazioni barocche, con il suo vibrante corpo centrale a elementi curvilinei, l'ordine gigante di lesene tra cui si inseriscono le complesse finestre concave e il contrasto tra il corpo centrale del prospetto, concavo, e il coronamento del finestrone convesso.\nDalla parte opposta della piazza, a partire dal triangolo nord-ovest, si sviluppa la lunga e rettilinea direttrice di Via del Babuino - dal nome della statua a lato della chiesa di S. Anastasio - tracciata tra il 1525 e il 1543, e da sempre considerata la via degli antiquari. Parallelamente si percorre via Margutta, tra le più caratteristiche strade di Roma, tuttora - ma soprattutto durante gli anni '60 - sede di botteghe e di studi di famosi artisti.\nMa è la scalinata centrale che rende la piazza uno degli scenari più spettacolari della città. Fu realizzata da Francesco De Sanctis, nel 1723-26, per volere di Innocenzo XIII, e diede una definitiva sistemazione al notevole dislivello tra la piazza e la superiore chiesa della Trinità. L'ardita soluzione architettonica sostituì un gioco di rampe e di scale che si intersecano e si aprono a ventaglio, alle ripide strade alberate preesistenti.\nIn primavera la scalinata della piazza si colora di meravigliose decorazioni floreali, realizzando un'immagine di rara suggestione, cara ai turisti di tutto il mondo."),
    ItineraryStop(
        name: "Mole antonelliana", coord: LatLng(41.906479, 12.453602),
          description: "La Mole Antonelliana è un edificio monumentale di Torino, situato nel centro storico, simbolo della città e uno dei simboli d'Italia.\nIl nome deriva dal fatto che, in passato, fu la costruzione in muratura più alta del mondo, mentre il suo aggettivo deriva dall'architetto che la concepì, Alessandro Antonelli. Tuttavia, nel corso del XX secolo, subì importanti ristrutturazioni con cemento armato e travi di acciaio, per cui essa non può più considerarsi una struttura esclusivamente in muratura.\nCon un'altezza di 167,5 metri, fu l'edificio in muratura più alto del mondo dal 1889 al 1908. Per anni fu l'edificio più alto di Torino, ma oggi, dopo la costruzione di altre due moderne torri, resta l'edificio più alto del solo profilo centrale urbano della città. Dall'anno 2000 al suo interno ha sede il Museo nazionale del cinema."),
  ];

  static int currentMsgIndex = 0;
  static List<String> _confirmMsgs = [
    "Recensione inviata!",
    "Itinerario creato!"
  ];

  static String get confirmMsg => _confirmMsgs[currentMsgIndex];
}
