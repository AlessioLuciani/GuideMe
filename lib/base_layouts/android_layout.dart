import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/user.dart';
import 'package:GuideMe/fragments/about.dart';
import 'package:GuideMe/fragments/explore_visited.dart';
import 'package:GuideMe/fragments/create_itinerary.dart';
import 'package:GuideMe/fragments/explore.dart';
import 'package:GuideMe/fragments/favourites.dart';
import 'package:GuideMe/pages/details.dart';
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
    new DrawerItem("Explore", Icons.explore),
    new DrawerItem("Create Itinerary", Icons.add_circle_outline),
    new DrawerItem("Visited Itineraries", Icons.done_outline),
    new DrawerItem("Favorites", Icons.favorite),
    new DrawerItem("About", Icons.info),
    new DrawerItem("Logout", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() => new AndroidLayoutState();
}

class AndroidLayoutState extends State<AndroidLayout> {
  int _selectedDrawerIndex = 0;

  _buildMaterialSearchPage(BuildContext context) {
    debugPrint('${itineraries.length}');
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Try with "Tour de Roma"',
              iconColor: isDarkTheme(context) ? Colors.grey[750] : Colors.black,
              barBackgroundColor:
                  isDarkTheme(context) ? Colors.grey[750] : Colors.white,
              limit: itineraries.length,
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
                debugPrint('${current.id}');
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
          userSelectedLength: currentUserLength,
          userSelectedRating: currentUserRating,
          userSelectedDuration: currentUserDuration,
        );
      case 1:
        return new AddItinearyFragment(
            updatePage: (index) =>
                setState(() => _selectedDrawerIndex = index));
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

  _onSelectItem(int index) async {
    if (index == widget.drawerItems.length - 1) {
      await logout(context);
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
      // Avoid the Scaffold to resize himself
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
    );
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

  String get _starWord => currentUserRating > 1 ? "stars" : "star";

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
                      currentUserLength == MAX_ITINERARY_LENGTH.toDouble()
                          ? "Length"
                          : '${currentUserLength.toStringAsFixed(0)} km',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            width: 2,
                            color: currentUserLength ==
                                    MAX_ITINERARY_LENGTH.toDouble()
                                ? Colors.redAccent
                                : Colors.white)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => LengthDialog(
                              maxSliderValue: MAX_ITINERARY_LENGTH,
                              lastValue: currentUserLength,
                              updateCallback: (value) =>
                                  setState(() => currentUserLength = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      currentUserDuration
                                  .compareTo(DateTime.parse(INIT_DATETIME)) ==
                              0
                          ? "Duration"
                          : '${currentUserDuration.hour}h ${currentUserDuration.minute}m',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            width: 2,
                            color: currentUserDuration.compareTo(
                                        DateTime.parse(INIT_DATETIME)) ==
                                    0
                                ? Colors.redAccent
                                : Colors.white)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => DurationDialog(
                              lastValue: currentUserDuration,
                              updateCallback: (value) =>
                                  setState(() => currentUserDuration = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      currentUserRating == 1
                          ? "Rating"
                          : '$currentUserRating $_starWord',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                          width: 2,
                          color: currentUserRating == 1
                              ? Colors.redAccent
                              : Colors.white),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => RatingAlert(
                              lastValue: currentUserRating,
                              updateCallback: (value) =>
                                  setState(() => currentUserRating = value),
                            )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                ])),
          ),
        );
}
