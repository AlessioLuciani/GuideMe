import 'package:flutter/material.dart';
import 'package:guide_me/Common/Itinerary.dart';
import 'package:guide_me/Common/Page.dart';

class DetailsPage extends StatefulWidget{
  
  Widget body;

  DetailsPage({Key key, this.body=null}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DetailsPageState();
      }
    
}
    
class DetailsPageState extends State<DetailsPage>{

  @override
  Widget build(BuildContext context) {

    return Page(className: this.widget.runtimeType.toString(),
                body: this.widget.body ,
                isPrimary: true,
          );
  }

}