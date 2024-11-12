class NoteModel{

   int _id = 0;
   late String _title;
   late String _description;
   late String _date;


  NoteModel( this._title, this._date,this._description);

  NoteModel.withId( this._id,this._title, this._date,this._description);

//getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;


  //setters
  set description(String description){
    if(description.length <= 255){
      _description = description;
    }
  }

  set id(int value) {
    _id = value;
  }

  set date(String date){
    _date = date;
  }
  set title(String title){
    if(title.length <= 255){
      _title = title;
    }

  }

  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['id'] = _id;

    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }



  NoteModel.fromMapObject(Map<String, dynamic> map){
    _title = map["title"];
    _date = map["date"];
    _description = map["description"];
    _id = map["id"];
  }
}