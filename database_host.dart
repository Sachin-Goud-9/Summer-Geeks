import 'package:summer_geeks/models/reghostForm.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class DatabaseHost{          //Class used for creating the database for host

static DatabaseHost _databaseHostHelper;
static Database _database;






String hostTable = 'hosttable';
String colname = 'name';
String colphone = 'phone';
String colemail = 'email';
String coladd= 'address';


DatabaseHost._createInstance();

factory DatabaseHost() {
if (_databaseHostHelper ==null) {
  _databaseHostHelper = DatabaseHost._createInstance();
  }

return _databaseHostHelper;
}



Future<Database> get database async {

  if(_database==null) {
    _database = await initializeDatabase();
  }
  return _database;
}

Future<Database> initializeDatabase() async {       //initialising hte database
  

  Directory directory = await getApplicationDocumentsDirectory();
  String path=directory.path + 'hostForm.db';



  var hostDatabase = openDatabase(path,version:1,onCreate:_createDb);
  return hostDatabase;
}





//sql query for creating the database
void _createDb(Database db,int newVersion) async {

  await db.execute('CREATE TABLE $hostTable($colname TEXT,$colphone INTEGER ,$colemail VARCHAR(360),$coladd TEXT)');
}

//getting details of host
Future<List<Map<String,dynamic>>> getHostdetails() async{
  Database db = await this.database;
  var result=await db.rawQuery('SELECT * FROM $hostTable');
  debugPrint("Database created");
  return result;
}

//inserting the details of host
Future<int> insertHostDetails(RegHostStore rhg) async{
  Database db= await this.database;
    var result = await db.insert(hostTable,rhg.toMap());
  debugPrint("Inserted Successfully.");
  return result;

}



//changing the map of the database
Future<List<Map<String,dynamic>>> getVisitorMapList() async {
  Database db= await this.database;

  var result=await db.query(hostTable);
  return result;
}




//getting the map as list
Future<List<RegHostStore>> getNoteHostList() async{

var visitorMapList= await getVisitorMapList();
int count =visitorMapList.length;
List<RegHostStore> visitList =List<RegHostStore>();

for(int i=0;i<count;i++)
{
  visitList.add(RegHostStore.fromMapObject(visitorMapList[i]));
}
return visitList;
}


}