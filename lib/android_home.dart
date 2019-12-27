import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/pages/feedback.dart';
import 'package:GuideMe/pages/login.dart';
import 'package:GuideMe/utils/data.dart';
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
    new DrawerItem("Recensione", Icons.assistant),
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
        return new FeedbackFragment();
      case 3:
        return new ItinerariesFragment();
      default:
        return new Text("Some error occured.");
    }
  }

  _onSelectItem(int index) {
    if (index == 3) {
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.pushReplacement(context, route);
      return;
    }
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
    User currentUser = Data.users[Data.currentUserIndex];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:
                  new Text('${currentUser.name} ${currentUser.surname}'),
              accountEmail: new Text(currentUser.email),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text(currentUser.name[0].toUpperCase()),
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
