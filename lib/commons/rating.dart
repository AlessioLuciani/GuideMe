import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget{

  int _stars;

  Rating({Key key, int stars=5,}) : super(key: key){
    this._stars = stars;
  }

  @override
  State<StatefulWidget> createState() {
    return RatingState();
  }


}

class RatingState extends State<Rating>{
  
  int selectedStars = 0;
  
  @override
  Widget build(BuildContext context) {
    List<Star> stars = [];

    for (var i = 0; i < this.widget._stars; i++) {
      stars.add(new Star(
        color: (i<=this.selectedStars) ? Colors.yellow : Colors.grey[300],
        onTap: () => { setState(() => selectedStars = i) }, 
      ));
    }

    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars.map((star){
          return Flexible(child: star,);
        }).toList(),
      ),
    );
  }

}

class Star extends StatelessWidget{

  Color _color;
  Function _onTap = () => {};

  Star({Key key,Color color, Function onTap}) : super(key:key){
    this._color = color;
    this._onTap = onTap;
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: this._onTap,
      child: Icon(
        Icons.star,
        size: 45,
        color: this._color,
      )
    )
      ;
  }
    
}