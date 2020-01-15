import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GuideMe/utils/utils.dart';

import 'package:GuideMe/pages/choose_stops_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddItinearyFragment extends StatefulWidget {
  @override
  _AddItinearyFragmentState createState() => _AddItinearyFragmentState();
}

class _AddItinearyFragmentState extends State<AddItinearyFragment> {
  final List<Marker> _markers = List();

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
                      child: Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(""),
                                    flex: 4,
                                  ),
                                  Expanded(
                                      flex: 3,
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
                                  Expanded(
                                    child: Text(""),
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(2)
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          hintText: "0-60",
                                          labelText: "Minutes",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                        ),
                                      )),
                                  Expanded(
                                    child: Text(""),
                                    flex: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      initMarkers: _markers))),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              style: TextStyle(fontSize: 18))),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () => setState(
                                              () => _markers.removeAt(index))),
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
                      )))
            ])));
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
