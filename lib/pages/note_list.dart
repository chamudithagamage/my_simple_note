import 'package:flutter/material.dart';
import 'new_note_screen.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:my_simple_note/handler/note_db_handler.dart';
import 'package:my_simple_note/database_models/note_model.dart';

class NoteList extends StatefulWidget{



  const NoteList({super.key});

  @override
  State<StatefulWidget> createState()=> _NoteListState();
}

class _NoteListState extends State<NoteList>{

  NoteDbHandler noteDbHandler = NoteDbHandler();
  late List<NoteModel> noteList = [];
  int count = 0;

  @override
  Widget build(BuildContext context){

    if(noteList == null){
      noteList = List<NoteModel>.empty();
      updateList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Simple Note'),
        backgroundColor: Colors.greenAccent,
        elevation: 2.0,

        //note yet developed
        leading: IconButton(
          icon: Icon(Icons.menu),
            onPressed: ()=>{
              debugPrint('Hamburger menu pressed'),
            },

        ),

      ),
      body: getNoteListView(),

        floatingActionButton: FloatingActionButton(onPressed: (){
          debugPrint('Tapped floating button');
          moveToNewNoteScreen('Add Note', NoteModel('', '', ''));
        },
          tooltip: 'Adds a new note',
          shape: CircleBorder(),
          backgroundColor: Colors.green,
          child: Icon(Icons.edit),
      ),
    );
  }
  ListView getNoteListView(){
    TextStyle? headingTitle = Theme.of(context).textTheme.titleLarge;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white,
            elevation: 1.0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: Icon(Icons.edit_note_outlined),
              ),

              title: Text(this.noteList[position].title, style: headingTitle,),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                child: Icon(Icons.delete_outlined, color: Colors.grey),
                onTap: (){
                  delete(context, noteList[position]);
                },
              ),

                //edit on tap
                  onTap: () {
                    debugPrint("List Tile Tapped");
                    moveToNewNoteScreen('Edit Note',NoteModel('', '',''));

                  }
            ),
          );
        },

    );
  }
  //To avoid code repetition and to move to edit and new note pages
  void moveToNewNoteScreen(String title, NoteModel noteModel) async{
    bool response = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NewNoteScreen(appBarHeading: title, noteModel: noteModel,);
    }));

    if(response == true){
      updateList();
    }
  }

  //delete function
  void delete(BuildContext context, NoteModel noteModel) async{

    int response = await noteDbHandler.deleteNotes(noteModel.id);
    if(response != 0){
      snackBar(context,'Successfully Deleted!');
      updateList();
    }
  }

  void snackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).snackBar(snackBar);
  }

  void updateList() async{

      var database = await noteDbHandler.initializeDatabase();
      List<NoteModel> noteList = await noteDbHandler.getNoteList();

      setState(() {
        this.noteList = noteList;  // Updates the note list
        this.count = noteList.length;
      });
    }



  }


extension on ScaffoldState {
  void snackBar(SnackBar snackBar) {}
}