import 'package:GuideMe/commons/itinerary_visit.dart';
import 'package:GuideMe/pages/details.dart';
import 'package:GuideMe/pages/review_page.dart';
import 'package:flutter/material.dart';

class VisitCard extends StatelessWidget {
  ItineraryVisit _visit;

  VisitCard({Key key, @required ItineraryVisit visit}) : super(key: key) {
    this._visit = visit;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      this._visit.itinerary.coverImage,
                      height: 150,
                      fit: BoxFit.cover,
                    )),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            itinerary: _visit.itinerary,
                          )),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 10, top: 2, bottom: 6),
                title: Row(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this._visit.itinerary.title,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                              "Visitato il ${this._visit.date.day}/${this._visit.date.month}/${this._visit.date.year}", style: TextStyle(color: Colors.black54),),
                        ]),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Align(
                        child: GestureDetector(
                            child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: FlatButton(
                            child: Text(
                              "Recensisci",
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedbackFragment(
                                        itinerary: _visit.itinerary,
                                      )),
                            ),
                            color: Colors.redAccent,
                            textColor: Colors.white,
                          ),
                        )),
                        alignment: Alignment.bottomRight,
                      ),
                    ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
