import 'dart:io';
import 'package:confereshop/repositories/product_repository.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = new DatabaseProvider.internal();
  factory DatabaseProvider() => _instance;
  static Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  DatabaseProvider.internal();

  static DatabaseProvider get() {
    return _instance;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "ConfereShop.db");
    var ourDB = await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate,
      onOpen: _onOpen,
    );

    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    
    await db.execute(ProductRepository.CREATE_PRODUCT_TABLE);
    print("CREATE "+ProductRepository.CREATE_PRODUCT_TABLE);

  }

  void _onOpen(Database db) async {
    //-----ALTER TABLES
    
  }


  Future close() async {
    var database = _db;
    return database.close();
  }

}