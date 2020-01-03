import 'dart:io';

import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/visited_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreVisitedFragment extends StatefulWidget {
  @override
  _ExploreVisitedFragmentState createState() => _ExploreVisitedFragmentState();
}

class _ExploreVisitedFragmentState extends State<ExploreVisitedFragment> {
  @override
  Widget build(BuildContext context) {
    //setStatusBarDarkColor();
    if (userVisits.isEmpty)
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.black, // Color for Android
              statusBarBrightness:
                  Brightness.light // Dark == white status bar -- for IOS.
              ),
          child: Center(
              child: Text(
            "Sembra che tu non abbia ancora seguito nessun itinerario.\nChe aspetti!!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          )));

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.black, // Color for Android
            statusBarBrightness:
                Brightness.light // Dark == white status bar -- for IOS.
            ),
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: Platform.isIOS ? 20 : 0,
                ),
                Platform.isAndroid
                    ? Text("")
                    : Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Text("Seguiti",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)))
              ]),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 6,
                          top: 0), // it was top: 8 for iOS
                      child: ListView.builder(
                        itemCount: userVisits.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return VisitCard(
                            visit: userVisits.elementAt(index),
                          );
                        },
                      )))
            ])));
  }
}
