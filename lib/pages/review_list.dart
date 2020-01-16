import 'dart:io';

import 'package:GuideMe/commons/itinerary.dart';
import 'package:GuideMe/commons/review.dart';
import 'package:GuideMe/widgets/description_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewListPage extends StatelessWidget {
  final Itinerary itinerary;

  const ReviewListPage({Key key, this.itinerary}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Platform.isIOS
        ? CupertinoNavigationBar(
          backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ?
                      CupertinoColors.systemGrey5:      CupertinoColors.white , 
          middle: Text(itinerary.title, style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ?
                  Colors.white : Colors.black),),
          leading: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_up),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
        :
        
        AppBar(
          title: Text(itinerary.title),
          leading: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_up),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
            child: Center(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: itinerary.reviews.length,
                    itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            left: 8.0,
                            right: 8,
                            top: index == 0 ? 8 : 0,
                            bottom:
                                index < itinerary.reviews.length - 1 ? 8 : 20),
                        child: Center(
                          child: _getListTile(itinerary.reviews[index]),
                        ))))));
  }
}

Widget _getListTile(Review review) {
  final String formattedDate = DateFormat.yMMMM("en_US").format(review.time);
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        review.user.fullName,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.black54),
                      )
                    ],
                  )),
              Expanded(
                child: Text(""),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.redAccent,
                  ),
                  Icon(
                    review.rating > 1 ? Icons.star : Icons.star_border,
                    color: Colors.redAccent,
                  ),
                  Icon(
                    review.rating > 2 ? Icons.star : Icons.star_border,
                    color: Colors.redAccent,
                  ),
                  Icon(
                    review.rating > 3 ? Icons.star : Icons.star_border,
                    color: Colors.redAccent,
                  ),
                  Icon(
                    review.rating > 4 ? Icons.star : Icons.star_border,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ReadMoreText(
            review.description,
            trimLines: 3,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: "...Scopri di più",
            trimExpandedText: " Meno",
          ),
        ],
      ));
}
