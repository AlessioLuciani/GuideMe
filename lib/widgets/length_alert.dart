import 'package:flutter/material.dart';

class LengthDialog extends StatefulWidget {
  final double maxSliderValue;
  final double lastValue;
  final Function updateCallback;

  const LengthDialog(
      {Key key,
      @required this.maxSliderValue,
      @required this.lastValue,
      @required this.updateCallback})
      : super(key: key);

  @override
  _LengthDialogState createState() => new _LengthDialogState();
}

class _LengthDialogState extends State<LengthDialog> {
  double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.lastValue.toDouble();
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
                  "Lunghezza",
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timeline,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Fino a ${_sliderValue.toStringAsFixed(2)} km'),
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Slider(
                  activeColor: Colors.redAccent,
                  min: 0.0,
                  max: widget.maxSliderValue,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                )),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () =>
                          setState(() => _sliderValue = widget.maxSliderValue),
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
                        widget.updateCallback(_sliderValue);
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
