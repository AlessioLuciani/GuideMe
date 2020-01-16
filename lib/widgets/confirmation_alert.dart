import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final double maxSliderValue;
  final double lastValue;
  final Function updateCallback;

  const ConfirmationDialog(
      {Key key,
      @required this.maxSliderValue,
      @required this.lastValue,
      @required this.updateCallback})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => new _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.redAccent,
            ),
            SizedBox(height: 16),
            Text(
              "Itinerary has been published!",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
