import 'package:flutter/material.dart';


class NewNoteScreen extends StatefulWidget{

  final String appBarHeading;

  const NewNoteScreen({super.key, required this.appBarHeading});

  @override
  State<StatefulWidget> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen>{

  static const _priority = ['High','Low'];
  static const _kebabDropdown = ['Delete','Share'];

   late String appBarHeading;

  @override
  void initState(){
    super.initState();
    appBarHeading = widget.appBarHeading;
  }


TextEditingController noteTitleController = TextEditingController();
TextEditingController noteDescriptionController = TextEditingController();


  @override
  Widget build(BuildContext context){

    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
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
                    child: Align(
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
          padding: EdgeInsets.only(top:15.0, left:10.0, right: 10.0), // try all(20.0)
        child:ListView(
          //An array of widgets to mention priority by color
          children:<Widget>[

            //first element(priority choose)
            Padding(
                padding: EdgeInsets.all(20.0),
              child: ListTile(
                title: DropdownButton(
                    items: _priority.map((String dropDownStringItem) {
                      return DropdownMenuItem<String> (
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),

                      );
                    }).toList(),

                    style: textStyle,

                    value: 'Low',
                    onChanged: (valueGivenByUser){
                      setState(() {
                        debugPrint('User Selected ${valueGivenByUser}');
                      });
                    }
                ),
              ),
            ),

            //second element in child(Note Title)
            Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: noteTitleController,
              style: textStyle,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  )
              ),
              onChanged: (value) {
                debugPrint('Change in the Note title');
              },
              ),
            ),

            //third element(contains note description)
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: noteDescriptionController,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    )
                ),
                onChanged: (value) {
                  debugPrint('Change in the Description');
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
                    },
                    child: Text('Save'),


                )

          ],
        ),
      ),
    ));
  }

  void moveBackPage(){
    Navigator.pop(context);
  }
}