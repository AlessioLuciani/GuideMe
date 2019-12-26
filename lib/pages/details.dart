import 'package:GuideMe/commons/Itinerary.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Itinerary itinerary;

  const DetailsPage({Key key, this.itinerary}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.itinerary.title)),
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage(widget.itinerary.coverImage),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              widget.itinerary.longDescription,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: 10,
            ),
            _displayCard(widget.itinerary.duration, Icons.access_time),
            _displayCard(widget.itinerary.distance, Icons.directions_walk),
            SizedBox(
              width: 10,
            ),
          ]),
          SizedBox(
            height: 6,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: 10,
            ),
            _displayCard(widget.itinerary.priceRange, Icons.euro_symbol),
            _displayCard("TODO", Icons.restaurant),
            SizedBox(
              width: 10,
            ),
          ]),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: IconButton(
                      icon: new Icon(
                        widget.itinerary.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 36,
                      ),
                      onPressed: () => widget.itinerary.isFavourite = true,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.red)),
                    borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    onPressed: () => {},
                    child: Text("AVVIA"),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

Widget _displayCard(String text, IconData icon) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        side: BorderSide(color: Colors.blueGrey, width: 1)),
    child: SizedBox(
      height: 50,
      width: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    ),
  );
}
