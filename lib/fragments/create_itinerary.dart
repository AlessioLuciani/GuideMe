import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    debugPrint('${_markers.length}');
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Platform.isIOS ? 20 : 4,
                    ),
                    Platform.isAndroid
                        ? Text("")
                        : Text("Crea",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                    SizedBox(height: Platform.isAndroid ? 0 : 20),
                    Text(
                      "Titolo",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    _getTextfield("Il nome che vuoi dare all'itinerario.",
                        "L'itinerario in non più di 20 caratteri.", 1, 20),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Descrizione",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    _getTextfield(
                        "Cosa è possibile vedere durante l'itinerario? Cosa consigli da non perdere e dove consigli effettuare delle soste?",
                        "La tua esperienza in non più di 200 caratteri.",
                        4,
                        200),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Durata",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Text(""),
                          flex: 3,
                        ),
                        Expanded(
                            flex: 2,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: "0-24",
                                labelText: "   Ore",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            )),
                        Expanded(
                          child: Text(""),
                          flex: 1,
                        ),
                        Expanded(
                            flex: 2,
                            child: TextField(
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: "0-60",
                                labelText: " Minuti",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            )),
                        Expanded(
                          child: Text(""),
                          flex: 3,
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
                        "Tappe",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            iconSize: 36,
                            icon: Icon(Icons.pin_drop, color: Colors.black87),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseStopsMaps(
                                        addMarker: _addMarker,
                                        removeLastMarker: _removeLastMarker,
                                        initMarkers: _markers))),
                          ),
                          IconButton(
                            iconSize: 36,
                            color:
                                _markers.isEmpty ? Colors.grey : Colors.black,
                            icon: Icon(Icons.clear_all),
                            onPressed: () => setState(() => _markers.clear()),
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
                            bottom: index == _markers.length - 1 ? 90 : 4),
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
                                          markerId: _markers[index].markerId,
                                          position: _markers[index].position,
                                          infoWindow: InfoWindow(
                                            title: text,
                                          ),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
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
                                onPressed: () =>
                                    setState(() => _markers.removeAt(index))),
                          ],
                        ));
                  },
                )),
              ],
            )));
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
