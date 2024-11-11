import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_simple_note/database_models/note_model.dart';

class NoteDbHandler{

  static NoteDbHandler? _noteDbHandler;
  static Database? _database;



  String notesTable = 'notes_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  NoteDbHandler._createInstance();

  factory NoteDbHandler()  {

      _noteDbHandler ??= NoteDbHandler._createInstance();

    return _noteDbHandler!;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase()async{
    Directory dir =  await getApplicationDocumentsDirectory();
    String dbPath = dir.path + 'note.db';//get path to store the database
    
    var noteDatabase = await openDatabase(dbPath, version: 1, onCreate: _dbCreate);
    return noteDatabase;//create db at given path
  }

  void _dbCreate(Database database, int newDb) async{
    await database.execute('CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT'
        ',$colDescription Text, $colDate TEXT)');//query
  }

  //get notes from database function
    getNotes() async {
    Database database = await this.database;
    var response = await database.query(notesTable, orderBy: 'ASC');
    return response;
  }
  //insert new notes into database
  Future<int> insertNotes(NoteModel noteModel) async {
    Database database = await this.database;
    var response = await database.insert(notesTable, noteModel.toMap());
    return response;
  }
  //update notes database
  Future<int> updateNotes(NoteModel noteModel) async {
    var database = await this.database;
    var result = await database.update(notesTable, noteModel.toMap(), where: '$colId = ?', whereArgs: [noteModel.id]);
    return result;
  }
  //delete a note from the database
  Future<int> deleteNotes(int id) async {
    var database = await this.database;
    int result = await database.rawDelete('DELETE FROM $notesTable WHERE $colId = $id');
    return result;
  }
  // function to convert map list into note list obj
  Future<List<NoteModel>> getNoteList() async {
    var noteMapList = await getNotes();
    int count = noteMapList.length;

    List<NoteModel> noteList = [];

    for (int i = 0; i < count; i++) {
      noteList.add(NoteModel.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}

