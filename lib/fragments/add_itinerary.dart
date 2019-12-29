import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GuideMe/pages/choose_stops_maps.dart';


class AddItinearyFragment extends StatefulWidget {
  @override
  _AddItinearyFragmentState createState() => _AddItinearyFragmentState();
}

class _AddItinearyFragmentState extends State<AddItinearyFragment> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[

          //Nome dell'itinerario
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
            child: TextField(
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Inserisci il nome dell'itinerario",
                labelText: "Nome",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              ),
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),

          //Descrizione dell'itinerario
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
            child: TextField(
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Inserisci una descrizione dell'itinerario",
                labelText: "Descrizione",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              ),
              style: TextStyle( fontSize: 19, ),
            ),
          ),

          //Durata dell'itinerario
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
            
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Durata", style: TextStyle( fontSize: 19, color: Colors.black54,)),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextField( 
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "0",
                                    labelText: "Giorni",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                  ),
                                )
                        ),

                        Expanded(child: Text(""), flex: 1,),

                        Expanded(
                          flex: 2,
                          child: TextField( 
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "0-24",
                                    labelText: "Ore",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                  ),
                                )
                        ),

                        Expanded(child: Text(""), flex: 1,),

                        Expanded(
                          flex: 2, 
                          child: TextField( 
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "0-60",
                                    labelText: "Minuti",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                  ),
                                )
                        ),

                        Expanded(child: Text(""), flex: 1,),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),


          ),

          //Tappe
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child: Text("Tappe", style: TextStyle( fontSize: 19, color: Colors.black54,)),
                  ),
                  FlatButton.icon(
                    onPressed: () => Navigator.push( context, MaterialPageRoute( builder: (context) => ChooseStopsMaps())), 
                    icon: Icon(Icons.map), 
                    label: Text("Aggiungi Tappe", style: TextStyle( fontSize: 19, )),
                  ),
                ],
              ),
              )
          ),
          
        ],
      )
    );
  }
}