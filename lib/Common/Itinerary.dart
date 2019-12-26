class Itinerary{

  String _name;
  int _duration;  //in minutes
  int _length;    //in meters



  Itinerary(this._name, this._duration, this._length);

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  int get duration => _duration;

  set duration(int duration) {
    _duration = duration;
  } 

  int get length => _length;

  set length(int length) {
    _length = length;
  }   

}