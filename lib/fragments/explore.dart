import 'dart:io';

import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreFragment extends StatefulWidget {
  @override
  _ExploreFragmentState createState() => _ExploreFragmentState();
}

class _ExploreFragmentState extends State<ExploreFragment> {

  @override
  Widget build(BuildContext context) {
    //setStatusBarDarkColor();
    return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark.copyWith(
   statusBarColor: Colors.black, // Color for Android
   statusBarBrightness: Brightness.light // Dark == white status bar -- for IOS.
),
    child: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20, top: Platform.isIOS ? 20 : 0),
              child: Platform.isAndroid
                  ? Text("")
                  : Text("Esplora",
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold))),
          SizedBox(height: Platform.isAndroid ? 0 : 20),
          Expanded(
              child: ListView.builder(
            itemCount: Data.itineraries.length,
            itemBuilder: (_, index) => Container(
                // Add padding to the last item of the list
                padding: index == Data.itineraries.length - 1
                    ? EdgeInsets.only(bottom: 10)
                    : EdgeInsets.only(bottom: 0),
                // Form a new card from the current itinerary information
                child: ExploreCard(
                  itinerary: Data.itineraries[index],
                )),
          )),
        ])));
  }
}
