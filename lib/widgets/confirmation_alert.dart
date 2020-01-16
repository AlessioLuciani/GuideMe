import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String text;

  const ConfirmationDialog({Key key, this.text}) : super(key: key);

  @override
  _ConfirmationDialogState createState() => new _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
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
              color: isDarkTheme(context) ? Colors.white : Colors.redAccent,
            ),
            SizedBox(height: 16),
            Text(
              widget.text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
