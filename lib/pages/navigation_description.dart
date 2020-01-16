import 'package:GuideMe/pages/navigation_maps.dart';
import 'package:flutter/material.dart';

class NavigationDescriptionPage extends StatefulWidget {
  final NavigationData navigationData;
  final Function previousStopCallback;
  final Function nextStopCallback;

  const NavigationDescriptionPage(
      {Key key,
      @required this.navigationData,
      @required this.previousStopCallback,
      @required this.nextStopCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NavigationDescriptionPageState();
}

class NavigationDescriptionPageState extends State<NavigationDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: widget.navigationData.currentStop > 0
                            ? Colors.black
                            : Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.navigationData.previousStop();
                        });
                        widget.previousStopCallback(widget
                            .navigationData
                            .itinerary
                            .stops[widget.navigationData.currentStop].coord);
                      },
                    ),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
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
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(
                              widget.navigationData.playingAudio
                                  ? Icons.stop
                                  : Icons.record_voice_over,
                              color: Colors.black,
                              size: 40.0,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.navigationData.toggleAudio();
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: widget.navigationData.currentStop <
                                widget.navigationData.itinerary.stops.length - 1
                            ? Colors.black
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.navigationData.nextStop();
                        });
                        widget.nextStopCallback(widget.navigationData.itinerary
                            .stops[widget.navigationData.currentStop].coord);
                      },
                    )
                  ],
            ),
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
              )),
        ],
      ),
    );
  }
}
