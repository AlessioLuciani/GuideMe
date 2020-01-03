import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Function onRefresh;
  final GlobalKey _refreshKey = GlobalKey();

  MyRefreshIndicator({Key key, this.onRefresh, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return RefreshIndicator(
        key: _refreshKey,
        onRefresh: onRefresh,
        child: child,
      );
    } else {
      return CupertinoSliverRefreshControl(
        key: _refreshKey,
        onRefresh: onRefresh,
        builder: (_, __, ___, ____, _____) => child,
      );
    }
  }
}
