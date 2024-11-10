import 'package:flutter/material.dart';

class NewNoteScreen extends StatefulWidget{

  const NewNoteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Entry'),
      ),
      
      body: Padding(
          padding: EdgeInsets.only(top:15.0, left:10.0, right: 10.0),
        child:ListView(
          //An array of widgets to mention priority by color
          children:<Widget>[
            //first element
            ListTile(

            ),
          ],
        ),
      ),
    );
  }
}