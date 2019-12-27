import 'package:flutter/material.dart';
import 'package:GuideMe/fragments/explore.dart';
import 'package:GuideMe/fragments/add_itinerary.dart';
import 'package:GuideMe/fragments/itineraries.dart';

import '../fragments/add_itinerary.dart';
import '../fragments/explore.dart';

class IOSLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IOSLayoutState();
}

class IOSLayoutState extends State<IOSLayout> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Avoid the Scaffold to resize himself when
      //resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (int index) => setState(() {
          _tabIndex = index;
        }),
        
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('Preferiti'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle_outline),
            title: new Text('Crea itinerario'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Esplora'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.rate_review),
            title: new Text('I miei itinerari'),
          ),
        ],
      ),
      body: _getFragmentFrom(_tabIndex),
    );
  }
_getFragmentFrom(int pos) {;
    switch (pos) {
      case 0:
        return new ItinerariesFragment();
      case 1:
      return new AddItinearyFragment();
      case 2:
      return new ExploreFragment();
      default:
        return new Text("Some error occured.");
    }
  }


}