import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/fragments/about.dart';
import 'package:GuideMe/fragments/explore_visited.dart';
import 'package:GuideMe/fragments/create_itinerary.dart';
import 'package:GuideMe/fragments/explore.dart';
import 'package:GuideMe/fragments/favourites.dart';
import 'package:GuideMe/pages/details.dart';
import 'package:GuideMe/pages/login.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/duration_alert.dart';
import 'package:GuideMe/widgets/length_alert.dart';
import 'package:GuideMe/widgets/rating_alert.dart';
import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem(this.title, this.icon);
}

class AndroidLayout extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Esplora", Icons.explore),
    new DrawerItem("Crea itinerario", Icons.add_circle_outline),
    new DrawerItem("Itinerari seguiti", Icons.done_outline),
    new DrawerItem("Preferiti", Icons.favorite),
    new DrawerItem("About", Icons.info),
    new DrawerItem("Esci", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() => new AndroidLayoutState();
}

class AndroidLayoutState extends State<AndroidLayout> {
  int _selectedDrawerIndex = 0;
  double _currentUserLength = MAX_ITINERARY_LENGTH.toDouble();
  int _currentUserRating = 1;
  DateTime _currentUserDuration = DateTime.parse(INIT_DATETIME);

  _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Prova con "Tour de Roma"',
              results: itineraries
                  .map(
                      (Itinerary itinerary) => new MaterialSearchResult<String>(
                            icon: Icons.directions_walk,
                            value: itinerary.id.toString(),
                            text: itinerary.title,
                          ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                final Itinerary current = getitineraryFromId(int.parse(value));
                return current.title.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) {
                final Itinerary current = getitineraryFromId(int.parse(value));
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              itinerary: current,
                            )));
              },
              onSubmit: (String value) {
                Navigator.of(context).pop(value);
              },
            ),
          );
        });
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ExploreFragment(
          userSelectedLength: _currentUserLength,
          userSelectedRating: _currentUserRating,
          userSelectedDuration: _currentUserDuration,
        );
      case 1:
        return new AddItinearyFragment();
      case 2:
        return new ExploreVisitedFragment();
      case 3:
        return new FavouritesFragment();
      case 4:
        return new AboutFragment();
      default:
        return new Text("Some error occured.");
    }
  }

  _onSelectItem(int index) {
    if (index == widget.drawerItems.length - 1) {
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
    final List<Widget> drawerOptions = <Widget>[];
    for (int i = 0; i < widget.drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
        leading: new Icon(widget.drawerItems[i].icon),
        title: new Text(widget.drawerItems[i].title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    User currentUser = users[currentUserIndex];
    return new Scaffold(
        // Avoid the Scaffold to resize himself when
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.drawerItems[_selectedDrawerIndex].title),
          actions: _actions,
          bottom: _bottom,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('${currentUser.name} ${currentUser.surname}'),
                accountEmail: Text(currentUser.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(currentUser.name[0].toUpperCase()),
                ),
              ),
              Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        floatingActionButton: Visibility(
          child: Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                child: Icon(Icons.send),
                onPressed: () {
                  showAdditionConfirm(context);
                  setState(() => _selectedDrawerIndex = 0);
                },
              )),
          visible: (_selectedDrawerIndex == 1),
        ));
  }

  List<Widget> get _actions => _selectedDrawerIndex != 0
      ? <Widget>[]
      : <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).push(_buildMaterialSearchPage(context)),
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ];

  String get _starWord => _currentUserRating > 1 ? "stelle" : "stella";

  Widget get _bottom => _selectedDrawerIndex != 0
      ? null
      : PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Row(children: <Widget>[
                  FlatButton(
                    child: Text(
                      _currentUserLength == MAX_ITINERARY_LENGTH.toDouble()
                          ? "Lunghezza"
                          : '${_currentUserLength.toStringAsFixed(0)} km',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            width: 2,
                            color: _currentUserLength ==
                                    MAX_ITINERARY_LENGTH.toDouble()
                                ? Colors.redAccent
                                : Colors.white)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => LengthDialog(
                              maxSliderValue: 20,
                              lastValue: _currentUserLength,
                              updateCallback: (value) =>
                                  setState(() => _currentUserLength = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      _currentUserDuration
                                  .compareTo(DateTime.parse(INIT_DATETIME)) ==
                              0
                          ? "Durata"
                          : '${_currentUserDuration.hour}h ${_currentUserDuration.minute}m',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            width: 2,
                            color: _currentUserDuration.compareTo(
                                        DateTime.parse(INIT_DATETIME)) ==
                                    0
                                ? Colors.redAccent
                                : Colors.white)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => DurationDialog(
                              lastValue: _currentUserDuration,
                              updateCallback: (value) =>
                                  setState(() => _currentUserDuration = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      _currentUserRating == 1
                          ? "Recensione"
                          : '$_currentUserRating $_starWord',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                          width: 2,
                          color: _currentUserRating == 1
                              ? Colors.redAccent
                              : Colors.white),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => RatingAlert(
                              lastValue: _currentUserRating,
                              updateCallback: (value) =>
                                  setState(() => _currentUserRating = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                ])),
          ),
        );
}
