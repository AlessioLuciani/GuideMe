import 'dart:io';

import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/widgets/confirmation_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GuideMe/utils/utils.dart';

import 'package:GuideMe/pages/choose_stops_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddItinearyFragment extends StatefulWidget {
  final Function updatePage;

  const AddItinearyFragment({Key key, this.updatePage}) : super(key: key);
  @override
  _AddItinearyFragmentState createState() => _AddItinearyFragmentState();
}

class _AddItinearyFragmentState extends State<AddItinearyFragment> {
  final List<Marker> _markers = List();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: CustomScrollView(slivers: <Widget>[
              Platform.isIOS
                  ? CupertinoSliverNavigationBar(
                      largeTitle: Text("Create"),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((_, i) {
                        return Text("");
                      }, childCount: 0),
                    ),
              SliverFillRemaining(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(children: <Widget>[
                        Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: Platform.isIOS ? 20 : 14,
                                ),
                                Text(
                                  "Title",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                _getTextfield(
                                    "The name you want to give to your itinerary.",
                                    "The itinerary in not more than 20 characters.",
                                    1,
                                    20),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  "Description",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                _getTextfield(
                                    "What can you see in the itinerary? Where do you suggest stopping and spend time?",
                                    "Your experience in not more than 200 characters.",
                                    4,
                                    200),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  "Duration",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 80,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "0-24",
                                            labelText: "   Hours",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                        )),
                                    SizedBox(width: 30),
                                    Container(
                                        width: 80,
                                        child: TextField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "0-60",
                                            labelText: " Minutes",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Stops",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        iconSize: 36,
                                        icon: Icon(Icons.pin_drop,
                                            color: Colors.black87),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChooseStopsMaps(
                                                        addMarker: _addMarker,
                                                        removeLastMarker:
                                                            _removeLastMarker,
                                                        initMarkers:
                                                            _markers))),
                                      ),
                                      IconButton(
                                        iconSize: 36,
                                        color: _markers.isEmpty
                                            ? Colors.grey
                                            : Colors.black,
                                        icon: Icon(Icons.clear_all),
                                        onPressed: () =>
                                            setState(() => _markers.clear()),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Flexible(
                                child: ListView.builder(
                              itemCount: _markers.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final textController = TextEditingController(
                                    text: _markers[index].infoWindow.title);
                                return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: index == _markers.length - 1
                                            ? 90
                                            : 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.fiber_manual_record,
                                          size: 20,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: TextField(
                                                onChanged: (text) =>
                                                    _markers[index] = Marker(
                                                      markerId: _markers[index]
                                                          .markerId,
                                                      position: _markers[index]
                                                          .position,
                                                      infoWindow: InfoWindow(
                                                        title: text,
                                                      ),
                                                      icon: BitmapDescriptor
                                                          .defaultMarkerWithHue(
                                                              BitmapDescriptor
                                                                  .hueRed),
                                                    ),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                minLines: 1,
                                                maxLines: 1,
                                                controller: textController,
                                                style:
                                                    TextStyle(fontSize: 18))),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () => setState(() =>
                                                _markers.removeAt(index))),
                                      ],
                                    ));
                              },
                            )),
                            () {
                              if (Platform.isIOS) {
                                return Row(children: <Widget>[
                                  Expanded(
                                    child: Text(""),
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Publish",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Colors.redAccent,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      showAdditionConfirm(context);
                                      publishItinerary(
                                          title: _titleController.text,
                                          stops: _stops,
                                          description:
                                              _descriptionController.text,
                                          length: _length);
                                    },
                                  ),
                                ]);
                              } else {
                                return Text("");
                              }
                            }(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          right: 0,
                          child: FloatingActionButton(
                            child: Icon(Icons.send),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 1), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return ConfirmationDialog(
                                        maxSliderValue: 20,
                                        lastValue: 12,
                                        updateCallback: (value) => {});
                                  });
                              widget.updatePage(0);
                              publishItinerary(
                                  title: _titleController.text,
                                  stops: _stops,
                                  description: _descriptionController.text,
                                  length: _length);
                            },
                          ),
                        )
                      ])))
            ])));
  }

  int get _length {
    double totalLength = 0;
    for (int i = 0; i < _markers.length - 1; i++) {
      double deltaDistance = distanceInKmBetweenEarthCoordinates(
          _markers[i].position.latitude,
          _markers[i].position.longitude,
          _markers[i + 1].position.latitude,
          _markers[i + 1].position.longitude);
      totalLength += deltaDistance;
    }
    return totalLength.toInt();
  }

  List<ItineraryStop> get _stops {
    List<ItineraryStop> _resultList = new List();
    for (int i = 0; i < _markers.length; i++) {
      Marker marker = _markers[i];
      _resultList.add(ItineraryStop(
          coord: marker.position,
          name: marker.infoWindow.title,
          description: 'Itinerary stop number $i.'));
    }
    return _resultList;
  }

  void _addMarker(Marker marker) => _markers.add(marker);
  void _removeLastMarker() => _markers.removeLast();

  Widget _getTextfield(
      String hintText, String helperText, int lines, int maxChars) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
        primaryColorDark: Colors.grey,
      ),
      child: Container(
          child: TextField(
        minLines: lines,
        maxLines: lines,
        maxLength: maxChars,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(9),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          hintText: hintText,
          helperText: helperText,
        ),
      )),
    );
  }
}
