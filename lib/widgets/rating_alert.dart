import 'package:flutter/material.dart';

class RatingAlert extends StatefulWidget {
  final int lastValue;
  final Function updateCallback;

  const RatingAlert(
      {Key key, @required this.lastValue, @required this.updateCallback})
      : super(key: key);

  @override
  _RatingAlertState createState() => new _RatingAlertState();
}

class _RatingAlertState extends State<RatingAlert> {
  int _ratingValue;

  @override
  void initState() {
    super.initState();
    _ratingValue = widget.lastValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 6,
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 26),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(child: Text("")),
                Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Expanded(child: Text("")),
                Opacity(
                  child: IconButton(
                    icon: Icon(Icons.close, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  opacity: 0,
                ),
                SizedBox(
                  width: 6,
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
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: () => setState(() => _ratingValue = 1),
                        child: Icon(
                          _ratingValue >= 1 ? Icons.star : Icons.star_border,
                          size: 46,
                          color: Colors.redAccent,
                        )),
                    InkWell(
                        onTap: () => setState(() => _ratingValue = 2),
                        child: Icon(
                          _ratingValue >= 2 ? Icons.star : Icons.star_border,
                          size: 46,
                          color: Colors.redAccent,
                        )),
                    InkWell(
                        onTap: () => setState(() => _ratingValue = 3),
                        child: Icon(
                          _ratingValue >= 3 ? Icons.star : Icons.star_border,
                          size: 46,
                          color: Colors.redAccent,
                        )),
                    InkWell(
                        onTap: () => setState(() => _ratingValue = 4),
                        child: Icon(
                          _ratingValue >= 4 ? Icons.star : Icons.star_border,
                          size: 46,
                          color: Colors.redAccent,
                        )),
                    InkWell(
                        onTap: () => setState(() => _ratingValue = 5),
                        child: Icon(
                          _ratingValue >= 5 ? Icons.star : Icons.star_border,
                          size: 46,
                          color: Colors.redAccent,
                        )),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        widget.updateCallback(1);
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        widget.updateCallback(_ratingValue);
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
