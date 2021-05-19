import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//This Voice Calculator Database
class Databasehelp
{

  static final _databasename ="personal1.db";
  static final _databaseversion =1;
  static final table = "mytable";
  static final columnID ="id";
  static final columnEquestion= "solveResult";
  static final columnResult = "finalResult";
  static final columnTime = "hour";
  static final columnTimeMin = "mint";

  static Database _database;
  Databasehelp._privateConstructor();
  static final Databasehelp instance = Databasehelp._privateConstructor();
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
  Future _onCreate(Database db,int version)async
  {
    await db.execute(
        "CREATE TABLE $table($columnID INTEGER PRIMARY KEY,$columnEquestion INTEGER NOT NULL, $columnResult INTEGER NOT NULL,$columnTime INTEGER NOT NULL,$columnTimeMin INTEGER NOT NULL )"
    );
    //
  }
  Future<int> insert(Map<String,dynamic>row)async{
    Database db = await instance.database;
    return await db.insert(table,row);
  }
  Future<List<Map<String,dynamic>>> queryallrows()async{
    Database db = await instance.database;
    return await db.query(table);
  }
  Future<int> deletedata(int id) async{
    Database db = await instance.database;
    var res = await db.delete(table,where:"id = ?",whereArgs:[id]);
    return res;
  }

}