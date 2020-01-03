import 'package:GuideMe/pages/navigation_maps.dart';
import 'package:flutter/material.dart';

class NavigationDescriptionPage extends StatefulWidget {
  final NavigationData navigationData;

  const NavigationDescriptionPage({Key key, this.navigationData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NavigationDescriptionPageState();
}

class NavigationDescriptionPageState extends State<NavigationDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.navigationData.itinerary.title),
            SizedBox(
              height: 2,
            ),
            Text(
              'Creato da ${widget.navigationData.itinerary.authorName()}',
              style: TextStyle(fontSize: 13, color: Colors.white70),
              textAlign: TextAlign.left,
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.keyboard_arrow_up),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(widget.navigationData.itinerary.coverImage),
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.navigationData.previousStop();
                      });
                    },
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget
                                      .navigationData
                                      .itinerary
                                      .stops[widget.navigationData.currentStop]
                                      .name,
                                  style: new TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  (widget.navigationData.currentStop + 1)
                                          .toString() +
                                      "/" +
                                      (widget.navigationData.itinerary.stops
                                              .length)
                                          .toString(),
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5, right: 15),
                          child: IconButton(
                            icon: Icon(
                              widget.navigationData.playingAudio
                                  ? Icons.stop
                                  : Icons.record_voice_over,
                              color: Colors.redAccent,
                              size: 40.0,
                            ),
                            onPressed: () =>
                                widget.navigationData.toggleAudio(this),
                          )),
                    ],
                  )),
                  IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.navigationData.nextStop();
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Text(
                widget.navigationData.itinerary
                    .stops[widget.navigationData.currentStop].description,
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
