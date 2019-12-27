import 'package:GuideMe/commons/Itinerary.dart';
import 'package:GuideMe/utils/utils.dart';
import 'package:GuideMe/widgets/explore_card.dart';
import 'package:flutter/material.dart';

class FavouritesFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Itinerary> data = Utils.favouriteItineraries;

    if (data.length == 0) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(40),
          child: RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text:
                        "Non ci sono itinerari tra i tuoi preferiti. \nPuoi aggiungerne uno dalla sezione ",
                    style: TextStyle(fontSize: 18)),
                new TextSpan(
                    text: 'Esplora',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                new TextSpan(
                    text:
                        ".",
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) => Container(
            // Add padding to the last item of the list
            padding:
                index == data.length - 1 ? EdgeInsets.only(bottom: 10) : null,
            // Form a new card from the current itinerary information
            child: ExploreCard(
              itinerary: data[index],
            )),
      ),
    );
  }
}
