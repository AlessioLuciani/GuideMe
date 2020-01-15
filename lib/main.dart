import 'package:GuideMe/base_layouts/android_layout.dart';
import 'package:GuideMe/base_layouts/ios_layout.dart';
import 'package:GuideMe/pages/login.dart';
import 'package:GuideMe/utils/data.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AppRoot(
        child: FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
              title: 'GuideMe',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              home: () {
                if (snapshot.data.containsKey("current_user_index")) {
                  int userIndex = snapshot.data.getInt("current_user_index");
                  if (userIndex == -1) {
                    return LoginPage();
                  } else {
                    createUserSession(userIndex);
                    return HomePage();
                  }
                } else {
                  return LoginPage();
                }
              }());
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }
}

/*
  MaterialApp(
      title: 'GuideMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: HomePage(),
      home: LoginPage(),
    ));
 */

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AppRoot(
        child: FutureBuilder(
    future: SharedPreferences.getInstance(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
      title: 'GuideMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage());
        } else {
    return CircularProgressIndicator();
    }
  }
  )
  );
}
*/

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location)
        .then((perm) {
      if (perm != PermissionStatus.granted) {
        PermissionHandler().requestPermissions([PermissionGroup.location]);
      }
    });
    if (Platform.isAndroid) {
      return AndroidLayout();
    } else {
      return IOSLayout();
    }
  }
}

// Set up an InheritedWidget in case we may need it
class AppRoot extends InheritedWidget {
  AppRoot({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppRoot of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType() as AppRoot;
}
