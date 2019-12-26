import 'package:GuideMe/commons/leading_factory.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


// TODO: check this file

class BaseScaffold extends StatefulWidget{

  String pageName;
  bool isPrimary;
  Widget body;

  BaseScaffold({String pageName="No Name", bool isPrimary=true, Widget body,}){
    this.pageName = pageName;
    this.isPrimary = isPrimary;
    this.body = body;
  }


  @override
  State<BaseScaffold> createState() {
    return new BaseScaffoldState();
  }

}

class BaseScaffoldState extends State<BaseScaffold>{

  Widget navBar = null;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    if(Platform.isAndroid){
      this.navBar = new AppBar(
        title: new Text(this.widget.pageName),
        leading: LeadingFactory.create(context, isPrimary: this.widget.isPrimary),
      );
    }
    else if(Platform.isIOS){
      this.navBar = new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("ciao"),
            icon: Icon(Icons.assignment)
          ),
          BottomNavigationBarItem(
            title: Text("ciao"),
            icon: Icon(Icons.assignment_ind),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) => {
          setState(()=>{
            _currentIndex = index
          })
        },
      );
    }

    return Scaffold(
      appBar: (Platform.isAndroid) ? this.navBar : null,  
      bottomNavigationBar: (Platform.isIOS) ? this.navBar : null,
      body: this.widget.body,


    );

  }

}