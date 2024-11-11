import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_simple_note/database_models/note_model.dart';
import 'package:my_simple_note/handler/note_db_handler.dart';


class NewNoteScreen extends StatefulWidget{

  final String appBarHeading;
  final NoteModel noteModel;

  const NewNoteScreen({super.key, required this.appBarHeading,required this.noteModel});

  @override
  State<StatefulWidget> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen>{

  static const _kebabDropdown = ['Delete','Share'];


   late String appBarHeading;
    late NoteModel noteModel;

  @override
  void initState(){
    super.initState();
    appBarHeading = widget.appBarHeading;
    noteModel = widget.noteModel;
  }

  NoteDbHandler handler = NoteDbHandler();


TextEditingController noteTitleController = TextEditingController();
TextEditingController noteDescriptionController = TextEditingController();


  @override
  Widget build(BuildContext context){

    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    noteTitleController.text = widget.noteModel.title ?? '';
    noteDescriptionController.text = widget.noteModel.description ?? '';

    return WillPopScope(

      //writing what function to execute after user press back arrow button.
      onWillPop: () async{
        moveBackPage();
        return Future.value(true);
      },

      child: Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarHeading),
          leading: IconButton(
              onPressed: (){
                moveBackPage(); //write a function to move back
              }, 
              icon: Icon(Icons.arrow_back)),

          actions: [
            Padding(
              padding: EdgeInsets.all(1.0),
              child: PopupMenuButton<String>(
                color: Colors.grey[100],
                onSelected: (value){
                  if(value == 'Delete'){
                    debugPrint('Delete was selected');
                  }
                  else if(value == 'Share'){
                    debugPrint('Share was selected');
                  }
                }, itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete',
                    // onTap: (){
                    //                     //   deleteNote(context, noteL)
                    //               // },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text('Delete',textAlign: TextAlign.center),
                          SizedBox(width: 20.0,),
                          Icon(Icons.delete_outlined),

                        ],
                      ),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'share',
                      child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text('Share',textAlign: TextAlign.center),
                             SizedBox(width: 20.0,),
                             Icon(Icons.share_outlined),
                          ],
                      ),
                    ),
                  ),
                ];
                },
                icon: const Icon(Icons.more_vert),
              ),
            )
         ]
      ),

      body: Padding(
          padding: EdgeInsets.only(top:15.0, left:10.0, right: 10.0),
        child:ListView(
          children:<Widget>[
            //first element in child(Note Title)
            Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: noteTitleController,
              style: textStyle,
              decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter note title',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                debugPrint('Change in the Note title');
                updateTitle();
              },
              ),
            ),

            //second element(contains note description)

              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: noteDescriptionController,
                  maxLines: 6,
                  style: textStyle,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                      hintText: 'Enter note description',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.blue,
                          width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    debugPrint('Change in the Description');
                    updateDescription();
                  },
                ),
              ),

            //save button
            const SizedBox(height:20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                    onPressed: (){
                      debugPrint('Pressed Save Button');
                      _save();
                    },
                    child: Text('Save'),


                )

          ],
        ),
      ),
    ));
  }

  void moveBackPage(){
    Navigator.pop(context,true);
  }
  void _deleteNote() async {
  int response = await handler.deleteNotes(noteModel.id);
  }

  void updateTitle(){
    widget.noteModel.title = noteTitleController.text;
  }
  void updateDescription(){
    widget.noteModel.description = noteDescriptionController.text;
  }

  void _save()async{
    
    noteModel.date = DateFormat.yMMMd().format(DateTime.now());
    int response;
    response = await handler.updateNotes(noteModel);
    }

}