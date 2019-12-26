import 'package:flutter/material.dart';


// TODO: check this file

class LeadingFactory{

  bool isPrimary;
  Widget lead;

  static Widget create(BuildContext context,{bool isPrimary=true}) {
    if(isPrimary){
      return new IconButton(
        icon: Icon(Icons.menu),
        onPressed:() => Navigator.pop(context, false),
      );
    }
    else{
      return new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
      );
    }
  }

} 