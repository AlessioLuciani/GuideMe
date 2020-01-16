import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/itinerary_stop.dart';
import 'package:GuideMe/utils/data.dart';
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
  bool _validateTitle = false, _validateDescription = false;
  bool _validateHour = false, _validateMinute = false;
  bool _markersNeeded = false;

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
                      backgroundColor:
                          MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Colors.grey[850]
                              : Colors.grey[50],
                      largeTitle: Text("Create",
                          style: TextStyle(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)),
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
                                Container(
                                  child: TextField(
                                    controller: _titleController,
                                    onChanged: (value) => setState(
                                        () => _validateTitle = value.isEmpty),
                                    minLines: 1,
                                    maxLines: 1,
                                    maxLength: 20,
                                    decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      errorText: _validateTitle
                                          ? "This field cannot be left empty."
                                          : null,
                                      contentPadding: EdgeInsets.all(12),
                                      hintText:
                                          "The name you want to give to your itinerary.",
                                      helperText:
                                          "The itinerary in not more than 20 characters.",
                                    ),
                                  ),
                                ),
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
                                Container(
                                  child: TextField(
                                    controller: _descriptionController,
                                    onChanged: (value) => setState(() =>
                                        _validateDescription = value.isEmpty),
                                    minLines: 4,
                                    maxLines: 4,
                                    maxLength: 200,
                                    decoration: new InputDecoration(
                                      errorText: _validateDescription
                                          ? "This field cannot be left empty."
                                          : null,
                                      contentPadding: EdgeInsets.all(12),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      hintText:
                                          "What can you see in the itinerary? Where do you suggest stopping and spend time?",
                                      helperText:
                                          "Your experience in not more than 200 characters.",
                                    ),
                                  ),
                                ),
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
                                          controller: _hourController,
                                          onChanged: (value) => setState(() =>
                                              _validateHour = value.isEmpty),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(fontSize: 0),
                                            errorText:
                                                _validateHour ? "" : null,
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "0-24",
                                            labelText: "   Hours",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                          ),
                                        )),
                                    SizedBox(width: 30),
                                    Container(
                                        width: 80,
                                        child: TextField(
                                          controller: _minuteController,
                                          onChanged: (value) => setState(() =>
                                              _validateMinute = value.isEmpty),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(fontSize: 0),
                                            errorText:
                                                _validateMinute ? "" : null,
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "0-60",
                                            labelText: " Minutes",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
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
                                            color: isDarkTheme(context)
                                                ? Colors.white
                                                : Colors.black87),
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
                                            : isDarkTheme(context)
                                                ? Colors.white
                                                : Colors.white,
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
                              itemCount:
                                  _markers.length == 0 ? 1 : _markers.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                if (_markers.length == 0) {
                                  return Visibility(
                                      visible: _markersNeeded,
                                      child: Text(
                                        "Please add some stops to the itinerary.",
                                        style: TextStyle(
                                            color: Colors.red[700],
                                            fontSize: 13),
                                      ));
                                }
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
                                    onPressed: publishCurrentItinerary,
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
                        Platform.isAndroid
                            ? Positioned(
                                bottom: 20,
                                right: 0,
                                child: FloatingActionButton(
                                  child: Icon(Icons.send),
                                  onPressed: publishCurrentItinerary,
                                ),
                              )
                            : Text("")
                      ])))
            ])));
  }

  void publishCurrentItinerary() {
    _validateTitle = _titleController.text.isEmpty;
    _validateDescription = _descriptionController.text.isEmpty;
    _validateHour = _hourController.text.isEmpty;
    _validateMinute = _minuteController.text.isEmpty;
    _markersNeeded = _markers.isEmpty;
    debugPrint('$_validateTitle');
    if (_validateTitle ||
        _validateDescription ||
        _validateHour ||
        _validateMinute ||
        _markersNeeded) {
      setState(() {});
    } else {
      Itinerary currentItinerary = Itinerary(
          author: currentUser,
          coverImage: coverImages[generator.nextInt(coverImages.length)],
          title: _titleController.text,
          longDescription: _descriptionController.text,
          stops: _stops,
          duration: DateTime.parse(MIN_DATETIME).add(Duration(
              hours: int.parse(_hourController.text),
              minutes: int.parse(_minuteController.text))),
          length: _length);
      appendItinerary(currentItinerary);
      reviewItinerary(currentItinerary); // this should probably be removed
      showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return ConfirmationDialog(text: "Itinerary has been published!");
          });
      if (Platform.isAndroid) {
        widget.updatePage(0);
      } else if (Platform.isIOS) {
        widget.updatePage(2);
      }
    }
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
}
