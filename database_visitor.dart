import 'dart:async';

import 'package:summer_geeks/models/regform.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



 
class DatabaseVisitor{            //class for creating the database for visitor

static DatabaseVisitor _databaseHelper;
static Database _database;


String visitorTable = 'visitortable';
String colname = 'name';
String colphone = 'phone';
String colemail = 'email';
String colintime = 'intime';



DatabaseVisitor._createInstance();          //instantiating the database

factory DatabaseVisitor() {
if (_databaseHelper ==null) {
  _databaseHelper = DatabaseVisitor._createInstance();
  }

return _databaseHelper;
}



Future<Database> get database async {

  if(_database==null) {
    _database = await initializeDatabase();
  }
  return _database;
}

Future<Database> initializeDatabase() async {
  

  Directory directory = await getApplicationDocumentsDirectory();
  String path=directory.path + 'regForm.db';              //naming the database



  var visitorDatabase = openDatabase(path,version:1,onCreate:_createDb);
  debugPrint("Database created");
  return visitorDatabase;
}




//sql query for creating the database

void _createDb(Database db,int newVersion) async { 

  await db.execute('CREATE TABLE $visitorTable($colname TEXT,$colphone INTEGER ,$colemail TEXT,$colintime TEXT)');
  
}

//getting the visitor list

Future<List<Map<String,dynamic>>> getVisitorMapList() async {
  Database db= await this.database;

  var result=await db.query(visitorTable);
  return result;
}

Future<List<Map<String,dynamic>>> getVisitordetails() async{
  Database db = await this.database;
  var result=await db.rawQuery('SELECT * FROM $visitorTable ');

  return result;
}

//inseting the visitor details
Future<RegStore> insertVisitorDetails(RegStore rg) async{
  Database db= await this.database;
  var result = await db.insert(visitorTable,rg.toMap());
  debugPrint("Inserted Successfully.");


}

//getting the note list

Future<List<RegStore>> getNoteList() async{

var visitorMapList= await getVisitorMapList();
int count =visitorMapList.length;
List<RegStore> visitList =List<RegStore>();

for(int i=0;i<count;i++)
{
  visitList.add(RegStore.fromMapObject(visitorMapList[i]));
}
return visitList;
}

}