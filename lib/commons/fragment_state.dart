
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';

abstract class FragmentState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);  
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setStatusBarDarkColor();
        break;
      default:
        break;
    }
    setState(() {});
    super.didChangeAppLifecycleState(state);
  }


@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}