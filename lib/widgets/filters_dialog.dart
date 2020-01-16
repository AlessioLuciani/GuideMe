import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/widgets/duration_alert.dart';
import 'package:GuideMe/widgets/length_alert.dart';
import 'package:GuideMe/widgets/rating_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersDialog extends StatefulWidget {

  const FiltersDialog(
      {Key key})
      : super(key: key);

  @override
  _FiltersDialogState createState() => new _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  int _ratingValue;

  @override
  void initState() {
    super.initState();
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
                  "Filters",
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
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text("Length"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => LengthDialog(
                              maxSliderValue: MAX_ITINERARY_LENGTH,
                              lastValue: currentUserLength,
                              updateCallback: (value) =>
                                  setState(() => currentUserLength = value),
                            )),
                    ),
                    CupertinoButton(
                      child: Text("Duration"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => DurationDialog(
                              lastValue: currentUserDuration,
                              updateCallback: (value) =>
                                  setState(() => currentUserDuration = value),
                            )),
                    ),
                    CupertinoButton(
                      child: Text("Rating"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => RatingAlert(
                              lastValue: currentUserRating,
                              updateCallback: (value) =>
                                  setState(() => currentUserRating = value),
                            )),
                    )
                  ],
                )),
           
           
          ],
        ),
      ),
    );
  }
}
