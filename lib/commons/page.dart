import 'package:GuideMe/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';


// TODO: check this file

class Page extends StatefulWidget{

  Widget body;
  String className;
  bool isPrimary;

  Page({Key key,this.className="Page",this.body=null, this.isPrimary=true}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PageState();
      }

}


class PageState extends State<Page>{

  String pageName; //getName based on language

  /*
    className is useful to indentify the language entry.
   */

  @override
  Widget build(BuildContext context) {

    pageName = this.widget.className;

    return BaseScaffold(pageName: this.pageName , isPrimary: this.widget.isPrimary,body: this.widget.body);
;
  }

} 