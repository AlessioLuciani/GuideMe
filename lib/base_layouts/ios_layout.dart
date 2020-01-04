import 'package:GuideMe/fragments/about.dart';
import 'package:GuideMe/fragments/explore_visited.dart';
import 'package:flutter/material.dart';
import 'package:GuideMe/fragments/explore.dart';
import 'package:GuideMe/fragments/create_itinerary.dart';
import 'package:GuideMe/fragments/favourites.dart';
import 'package:GuideMe/utils/data.dart';

class IOSLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IOSLayoutState();
}

class IOSLayoutState extends State<IOSLayout> {
  int _tabIndex = 2;
  int _currentUserLength = MAX_ITINERARY_LENGTH;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Avoid the Scaffold to resize himself when
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (int index) => setState(() => _tabIndex = index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('Preferiti'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle_outline),
            title: new Text('Crea'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Esplora'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.done_outline),
            title: new Text('Seguiti'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.info),
            title: new Text('About'),
          ),
        ],
      ),
      body: _getFragmentFrom(_tabIndex),
    );
  }

  _getFragmentFrom(int pos) {
    switch (pos) {
      case 0:
        return new FavouritesFragment();
      case 1:
        return new AddItinearyFragment();
      case 2:
        return new ExploreFragment(
          userSelectedLength: null,
        );
      case 3:
        return new ExploreVisitedFragment();
      case 4:
        return new AboutFragment();
      default:
        return new Text("Some error occured.");
    }
  }
}
