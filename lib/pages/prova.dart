import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

class ProvaPage extends StatefulWidget {
  ProvaPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProvaPageState createState() => new _ProvaPageState();
}

class _ProvaPageState extends State<ProvaPage> {
  final _names = [
    'Giro de Roma',
    'Il tour antico',
    'Le antiche ville',
    'La roma antica',
    'Giro de Roma',
    'Il tour antico',
    'Le antiche ville',
    'La roma antica',
    'Giro de Roma',
    'Il tour antico',
    'Le antiche ville',
    'La roma antica',
  ];

  String _name = 'No one';

  final _formKey = new GlobalKey<FormState>();

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
              results: _names
                  .map((String v) => new MaterialSearchResult<String>(
                        icon: Icons.directions_walk,
                        value: v,
                        text: v,
                      ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Row(children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Distanza",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => MyDialog()),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      "Durata",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {},
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      "Recensioni",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {},
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                ])),
          ),
        ),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: new Text("You found: ${_name ?? 'No one'}"),
            ),
            new Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: new Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    new MaterialSearchInput<String>(
                      placeholder: 'Name',
                      results: _names
                          .map((String v) => new MaterialSearchResult<String>(
                                icon: Icons.person,
                                value: v,
                                text: "Mr(s). $v",
                              ))
                          .toList(),
                      filter: (dynamic value, String criteria) {
                        return value.toLowerCase().trim().contains(new RegExp(
                            r'' + criteria.toLowerCase().trim() + ''));
                      },
                      onSelect: (dynamic v) {
                        print(v);
                      },
                      validator: (dynamic value) =>
                          value == null ? 'Required field' : null,
                      formatter: (dynamic v) => 'Hello, $v',
                    ),
                    new MaterialButton(
                        child: new Text('Validate'),
                        onPressed: () {
                          _formKey.currentState.validate();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _showMaterialSearch(context);
        },
        tooltip: 'Search',
        child: new Icon(Icons.search),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  double _sliderValue = 5;
  Color myColor = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close, size: 30),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Distanza",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Fino a ${_sliderValue.toStringAsFixed(2)} km'),
                  ],
                )),
            Slider(
              activeColor: Colors.redAccent,
              min: 0.0,
              max: 15.0,
              onChanged: (newRating) {
                setState(() => _sliderValue = newRating);
              },
              value: _sliderValue,
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Divider(
                  color: Colors.grey,
                  height: 4.0,
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Resetta",
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.redAccent,
                      child: Text(
                        "Applica",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
