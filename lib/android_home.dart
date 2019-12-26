import 'package:flutter/material.dart';

import 'fragments/add_itinerary.dart';
import 'fragments/explore.dart';
import 'fragments/itineraries.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class AndroidHomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Esplora", Icons.explore),
    new DrawerItem("Aggiungi itinerario", Icons.add_circle_outline),
    new DrawerItem("I miei itinerari", Icons.bookmark),
    new DrawerItem("Esci", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() => new AndroidHomePageState();
}

class AndroidHomePageState extends State<AndroidHomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ExploreFragment();
      case 1:
        return new AddItinearyFragment();
      case 2:
        return new ItinerariesFragment();
      case 3:
        // TODO: Logout from the app
        break;
      default:
        return new Text("Some error occured.");
    }
  }

  _onSelectItem(int index) {
    if (index != _selectedDrawerIndex) {
      // Avoid reloading the current fragment
      setState(() => _selectedDrawerIndex = index);
    }
    // Close the drawer
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (int i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("Name Surname"),
              accountEmail: new Text("yourlongemail@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text("N"),
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
