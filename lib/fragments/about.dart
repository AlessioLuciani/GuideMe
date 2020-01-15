import 'dart:io';

import 'package:GuideMe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutFragment extends StatelessWidget {
  static const String _leoUrl = "https://github.com/LeonardoEmili";
  static const String _gioAUrl = "https://github.com/AgostaGiorgio";
  static const String _gioBUrl = "https://github.com/GiorgioBelli";
  static const String _aleUrl = "https://github.com/AlessioLuciani";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: Platform.isIOS ? 20 : 0,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Platform.isAndroid
                  ? Text("")
                  : Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("About",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)))),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                GestureDetector(
                    onTap: () => _launchURL(_gioAUrl),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Giorgio Agosta",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    )),
                GestureDetector(
                    onTap: () => _launchURL(_gioBUrl),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Giorgio Belli",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                      ],
                    )),
                GestureDetector(
                    onTap: () => _launchURL(_leoUrl),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Leonardo Emili",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () => _launchURL(_aleUrl),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Alessio Luciani",
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
          SizedBox(
            height: 20,
          ),
          Platform.isIOS 
          ?  FlatButton(
                child: Text( 
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                color: Colors.redAccent,
                onPressed: () => logout(context),
              )
          : Text(""),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
