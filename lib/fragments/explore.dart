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

Widget getCard() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 4),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: () => print("ciao"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: _getImage()),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10, top: 2),
              title: Text(
                "Giro de Roma",
                style: TextStyle(fontSize: 22),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _getDuration(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_getDistance(), _getRating()])
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _getTitle() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 10),
      ),
      Text(
        "Giro de Roma",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _getDuration() {
  return Row(
    children: <Widget>[
      Icon(Icons.access_time),
      SizedBox(
        width: 4,
      ),
      Text(
        "1.30 ore",
      ),
    ],
  );
}

Widget _getDistance() {
  return Row(
    children: <Widget>[
      Icon(Icons.directions_walk),
      SizedBox(
        width: 4,
      ),
      Text(
        "7 km",
      ),
    ],
  );
}

Widget _getRating() {
  return Row(
    children: <Widget>[
      Text(
        "3.2",
      ),
      Icon(Icons.star),
      SizedBox(
        width: 10,
      )
    ],
  );
}

Widget _getImage() {
  return Image(image: AssetImage("assets/images/colosseo.jpg"));
}

Widget _getInfo() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 10),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _getTitle(),
          _getDuration(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_getDistance(), _getRating()],
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.only(right: 10),
      ),
    ],
  );
}
