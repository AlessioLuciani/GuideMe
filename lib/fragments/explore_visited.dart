import 'dart:io';

import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/visited_card.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreVisitedFragment extends StatefulWidget {
  @override
  _ExploreVisitedFragmentState createState() => _ExploreVisitedFragmentState();
}

class _ExploreVisitedFragmentState extends State<ExploreVisitedFragment> {
  @override
  Widget build(BuildContext context) {
    if (userVisits.isEmpty)
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.black,
              statusBarBrightness: Brightness.light),
          child: Center(
              child: Text(
            "It looks like you haven't followed any itineraries yet.\nWhat are you waiting for?!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          )));

    return SafeArea(
        child: Platform.isIOS
            ? CustomScrollView(slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  backgroundColor: isDarkTheme(context) ?
                            Colors.grey[850] : Colors.grey[50],
                  largeTitle: Text("Visited",
                  style: TextStyle(color: isDarkTheme(context) ?
                  Colors.white : Colors.black),),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return VisitCard(
                      visit: userVisits[index],
                    );
                  }, childCount: userVisits.length),
                )
              ])
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                    itemCount: userVisits.length,
                    itemBuilder: (_, index) => Container(
                        // Add padding to the last item of the list
                        padding: index == userVisits.length - 1
                            ? EdgeInsets.only(
                                bottom: 10, top: index == 0 ? 10 : 0)
                            : EdgeInsets.only(
                                bottom: 0, top: index == 0 ? 10 : 0),
                        // Form a new card from the current itinerary information
                        child: VisitCard(
                          visit: userVisits.elementAt(index),
                        )))));
  }
}
