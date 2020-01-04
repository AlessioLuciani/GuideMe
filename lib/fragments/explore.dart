import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreFragment extends StatefulWidget {
  final double userSelectedLength;
  final int userSelectedRating;

  const ExploreFragment(
      {Key key,
      @required this.userSelectedLength,
      @required this.userSelectedRating})
      : super(key: key);

  @override
  _ExploreFragmentState createState() => _ExploreFragmentState();
}

class _ExploreFragmentState extends State<ExploreFragment> {
  List<Itinerary> _itineraries;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _itineraries = shuffledItineraries;
  }

  @override
  Widget build(BuildContext context) {
    _itineraries = itineraries
        .where((Itinerary itinerary) =>
            itinerary.length <= widget.userSelectedLength &&
            itinerary.avgReview.floor() <= widget.userSelectedRating)
        .toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light),
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(left: 20, top: Platform.isIOS ? 20 : 0),
                  child: Platform.isAndroid
                      ? Text("")
                      : Text("Esplora",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold))),
              SizedBox(height: Platform.isAndroid ? 0 : 20),
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: _refreshList,
                      key: _refreshKey,
                      child: ListView.builder(
                        itemCount: _itineraries.length,
                        itemBuilder: (_, index) => Container(
                            // Add padding to the last item of the list
                            padding: index == _itineraries.length - 1
                                ? EdgeInsets.only(bottom: 10)
                                : EdgeInsets.only(bottom: 4),
                            // Form a new card from the current itinerary information
                            child: ExploreCard(
                              itinerary: _itineraries[index],
                            )),
                      ))),
            ])));
  }

  Future<Null> _refreshList() async {
    _itineraries = shuffledItineraries;
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }
}
