class Note{

  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;

  Note( this._title, this._date,this._description, this._priority);

  Note.withId( this._title, this._date,this._description, this._priority);

//getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  //setters
  set description(String description){
    if(description.length <= 255){
      this._description = description;
    }
  }
  set date(String date){
    this._date = date;
  }
  set title(String title){
    if(title.length <= 255){
      this._title = title;
    }

  }
  set priority(int priority){
    if(priority >=1 && priority <= 2){
      this._priority = priority;
    }
  }

  Map<String,dynamic> toMap(){
    return{
      'id':_id,
      'title':_title,
      'description':_description,
      'date':_date,
      'priority':_priority,
    };
  }

  Note.fromMap(Map<String,dynamic>map)
      : _id = map["id"],
        _date = map["date"],
        _description = map["description"],
        _title = map["title"],
        _priority = map["priority"];

  Note.fromMapObject(Map<String, dynamic> map){
    this._title = map["title"];
    this._date = map["date"];
    this._description = map["description"];
    this._id = map["id"];
    this._priority = map["priority"];
  }
}