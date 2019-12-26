import 'package:flutter/material.dart';
import 'package:guide_me/Common/Itinerary.dart';
import 'package:guide_me/Common/Page.dart';

class SearchPage extends StatefulWidget{
  
  Widget body;

  SearchPage({Key key, this.body=null}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new SearchPageState();
      }
    
}
    
class SearchPageState extends State<SearchPage>{

  List<Itinerary> items; 

  @override
  Widget build(BuildContext context) {

    items = <Itinerary>[
      Itinerary("1",1,1),
      Itinerary("2",2,2),
      Itinerary("3",3,3),
    ];

    Widget body = ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Text(this.items[position].name),
        );
      },
      itemCount: items.length,
    );
    return Page(className: this.widget.runtimeType.toString(),
                body: body,
                isPrimary: true,
          );
  }

}