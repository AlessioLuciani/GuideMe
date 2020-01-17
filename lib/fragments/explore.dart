import 'dart:io';

import 'package:GuideMe/commons/ios_search_bar.dart';
import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/duration_alert.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:GuideMe/widgets/length_alert.dart';
import 'package:GuideMe/widgets/rating_alert.dart';
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

class _ExploreFragmentState extends State<ExploreFragment> with SingleTickerProviderStateMixin  {
  List<Itinerary> _itineraries = itinerariesCopy;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _searchAnimation;
  AnimationController _searchAnimationController;

  @override
  void dispose() {
    resetUserFilters();
    super.dispose();
  }


  @override
  void initState() {
      _searchAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _searchAnimation = new CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_searchAnimationController.isAnimating) {
        _searchAnimationController.forward();
      }
    });
    _itineraries.clear();
    for (Itinerary itinerary in itineraries) {
      if (itinerary.length <= widget.userSelectedLength &&
          itinerary.avgReview.floor() >= widget.userSelectedRating &&
          widget.userSelectedDuration.isAfter(itinerary.duration)) {
        _itineraries.add(itinerary);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (Itinerary itinerary in _itineraries) {
      if (itinerary.length > widget.userSelectedLength ||
          itinerary.avgReview.floor() < widget.userSelectedRating ||
          widget.userSelectedDuration.isBefore(itinerary.duration)) {
        _itineraries.remove(itinerary);
      }
    }
    
    return SafeArea(
        child: Platform.isIOS
            ?  GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _searchAnimationController.reverse();
          }
        }, child:
            CustomScrollView(slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  backgroundColor: isDarkTheme(context) ?
                            Colors.grey[850] : Colors.grey[50],
                  largeTitle: Text("Explore",
                  style: TextStyle(color: isDarkTheme(context) ?
                  Colors.white : Colors.black)),
                  
                  trailing: FlatButton(
                    child: Text("Filters",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16),
                    ),
                    onPressed: () => showCupertinoModalPopup(
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: Text("Filters"),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("Length"),
                            onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => LengthDialog(
                              maxSliderValue: MAX_ITINERARY_LENGTH,
                              lastValue: currentUserLength,
                              updateCallback: (value) =>
                                  setState(() => currentUserLength = value),
                            )),),
                            CupertinoActionSheetAction(
                              child: Text("Duration"),
                            onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => DurationDialog(
                              lastValue: currentUserDuration,
                              updateCallback: (value) =>
                                  setState(() => currentUserDuration = value),
                            ))),
                            CupertinoActionSheetAction(
                              child: Text("Rating"),
                            onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => RatingAlert(
                              lastValue: currentUserRating,
                              updateCallback: (value) =>
                                  setState(() => currentUserRating = value),
                            ))),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        );
                      },
                      context: context

                    ),)
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
                  onRefresh: _refreshListDelayed,
                ),
                SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child:
                    IOSSearchBar(
                    controller: _searchTextController,
                    focusNode: _searchFocusNode,
                    animation: _searchAnimation,
                    onCancel: _cancelSearch,
                    onClear: _clearSearch,
                    onSubmit: (text) => _refreshListWithSearch(text),
                    )
                    );
                  }, childCount: 1),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ExploreCard(
                        itinerary: _itineraries[index], pageTitle: "Explore");
                  }, childCount: _itineraries.length),
                )
              ]))
            : RefreshIndicator(
                onRefresh: _refreshListDelayed,
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

   void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _searchAnimationController.reverse();
  }
  void _clearSearch() {
    _searchTextController.clear();
  }

  Future<Null> _refreshList() async {
    _itineraries.clear();
    _itineraries.addAll(shuffledItineraries);
    return null;
  }

  Future<Null> _refreshListWithSearch(String text) async {
    _itineraries.clear();
   _itineraries.addAll(shuffledItineraries.where((itinerary)
      => itinerary.title.toLowerCase().contains(text.toLowerCase())));
    setState(() {});
    return null;
  }

  Future<Null> _refreshListDelayed() async {
    _refreshList();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }
}


