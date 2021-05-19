import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Database
class Databasehelper
{
  static final _databasename ="personal.db";
  static final _databaseversion =1;
  static final table = "my_table";
  static final columnID ="id";
  static final columnColcution = "solveResult";
  static final columnFinalResult = "finalResult";
  static final columnTime = "hour";
  static final columnTimeMin = "mint";

  static Database _database;

  //constructor of database
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

     // if the Database is equal to null so after create new database
     Future<Database> get database async{
    if(_database !=null)return _database;
    _database = await initDatabase();
    return _database;
  }
  initDatabase() async{
  final dbPath = await getDatabasesPath();
  final path = join(dbPath,_databasename);
  return await openDatabase(path,version: _databaseversion,onCreate: _onCreate);
  }
  //Executing quera
  Future _onCreate(Database db,int version)async
  {
    await db.execute(
      "CREATE TABLE $table($columnID INTEGER PRIMARY KEY,$columnTime INTEGER NOT NULL, $columnColcution DOUBLE NOT NULL, $columnFinalResult DOUBLE NOT NULL, $columnTimeMin INTEGER NOT NULL)"
           );
  }
  // For insertion
  Future<int> insert(Map<String,dynamic>row)async{
    Database db = await instance.database;
    return await db.insert(table,row);
  }
 // For showing
 Future<List<Map<String,dynamic>>> queryallrows()async{
       Database db = await instance.database;
       return await db.query(table);
  }
  //For deleting
  Future<int> deletedata(int id) async{
    Database db = await instance.database;
    var res = await db.delete(table,where:"id = ?",whereArgs:[id]);
    return res;
  }
  }