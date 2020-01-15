import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreFragment extends StatefulWidget {
  final double userSelectedLength;
  final int userSelectedRating;
  final DateTime userSelectedDuration;

  const ExploreFragment(
      {Key key,
      @required this.userSelectedLength,
      @required this.userSelectedRating,
      @required this.userSelectedDuration})
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
            itinerary.avgReview.floor() >= widget.userSelectedRating &&
            widget.userSelectedDuration.isAfter(itinerary.duration))
        .toList();
    return SafeArea(
        child: Platform.isIOS
            ? CustomScrollView(slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Explore"),
                ),
                CupertinoSliverRefreshControl(
                  builder: (context, refreshState, pulledExtent,
                      refreshTriggerPullDistance, refreshIndicatorExtent) {
                    return CupertinoSliverRefreshControl
                        .buildSimpleRefreshIndicator(
                            context,
                            refreshState,
                            pulledExtent,
                            refreshTriggerPullDistance,
                            refreshIndicatorExtent);
                  },
                  onRefresh: _refreshList,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ExploreCard(
                        itinerary: _itineraries[index], pageTitle: "Explore");
                  }, childCount: _itineraries.length),
                )
              ])
            : RefreshIndicator(
                onRefresh: _refreshList,
                key: _refreshKey,
                child: ListView.builder(
                  itemCount: _itineraries.length,
                  itemBuilder: (_, index) => Container(
                      // Add padding to the last item of the list
                      padding: index == _itineraries.length - 1
                          ? EdgeInsets.only(
                              bottom: 10, top: index == 0 ? 10 : 0)
                          : EdgeInsets.only(
                              bottom: 4, top: index == 0 ? 10 : 0),
                      // Form a new card from the current itinerary information
                      child: ExploreCard(
                          itinerary: _itineraries[index],
                          pageTitle: "Explore")),
                )));
  }

  Future<Null> _refreshList() async {
    _itineraries = shuffledItineraries;
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }
}
