import 'package:flutter/material.dart';
import '/new_note_screen.dart';

class NoteList extends StatefulWidget{

  const NoteList({super.key, required String title});

  @override
  State<StatefulWidget> createState()=> _NoteListState();
}

class _NoteListState extends State<NoteList>{

  int count = 0;

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('My Simple Note'),
        backgroundColor: Colors.greenAccent,
        elevation: 2.0,

        leading: IconButton(
          icon: Icon(Icons.menu),
            onPressed: ()=>{
              debugPrint('Hamburger menu pressed'),
            },
        
        ),

      ),
      body: getNoteListView(),

        floatingActionButton: FloatingActionButton(onPressed: ()=>{
          debugPrint('Floating Button Tapped'),

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
                
              title: Text('John Doe', style: headingTitle,),
              subtitle: Text('Test Date'),
              trailing: Icon(Icons.more_vert, color: Colors.grey),
                //edit on tap
                  onTap: ()=> debugPrint("List Tile Tapped"),

            ),
          );
        },

    );
  }
}