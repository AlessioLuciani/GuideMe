import 'package:GuideMe/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DurationDialog extends StatefulWidget {
  final DateTime lastValue;
  final Function updateCallback;

  const DurationDialog({Key key, this.lastValue, this.updateCallback})
      : super(key: key);

  @override
  _DurationDialogState createState() => new _DurationDialogState();
}

class _DurationDialogState extends State<DurationDialog> {
  DateTime _durationValue;

  @override
  void initState() {
    super.initState();
    _durationValue = widget.lastValue;
  }

  @override
  Widget build(BuildContext context) {
    final _hourWord = _durationValue.hour > 1 ? "ore" : "ora";
    final _minuteWord = _durationValue.minute > 1 ? "minuti" : "minuto";
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
                  "Durata",
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
                      Icons.access_time,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        'Fino a ${_durationValue.hour} $_hourWord e ${_durationValue.minute} $_minuteWord'),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TimePickerWidget(
                  minDateTime: DateTime.parse(MIN_DATETIME),
                  maxDateTime: DateTime.parse(MAX_DATETIME),
                  initDateTime: _durationValue,
                  dateFormat: DATE_FORMAT,
                  pickerTheme: DateTimePickerTheme(
                      showTitle: false, itemTextStyle: TextStyle(fontSize: 18)),
                  minuteDivider: 5,
                  onChange: (dateTime, selectedIndex) =>
                      setState(() => _durationValue = dateTime)),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        widget.updateCallback(DateTime.parse(INIT_DATETIME));
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
                        final DateTime updatedDate =
                            DateTime.parse(MIN_DATETIME).add(Duration(
                                hours: _durationValue.hour,
                                minutes: _durationValue.minute));
                        widget.updateCallback(updatedDate);
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
