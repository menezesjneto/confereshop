import 'dart:async';
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/providers/database_provider.dart';
import 'package:confereshop/utils/app_exception.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {

  static final ProductRepository _repo = new ProductRepository._internal();

  static const PRODUCT_TABLE_NAME = "Product";
  static const CREATE_PRODUCT_TABLE = "CREATE TABLE IF NOT EXISTS $PRODUCT_TABLE_NAME (id INTEGER PRIMARY KEY" 
  + ", name TEXT"
  + ", style TEXT"
  + ", code_color TEXT"
  + ", color_slug TEXT"
  + ", color TEXT"
  + ", on_sale TEXT"
  + ", regular_price TEXT"
  + ", actual_price TEXT"
  + ", discount_percentage TEXT"
  + ", installments TEXT"
  + ", image TEXT"
  + ", sizes TEXT"
  + ", is_my_product TEXT"
  + ", active TEXT"
  + ")";



  DatabaseProvider database;

   static ProductRepository get() {
    return _repo;
  }

  ProductRepository._internal() {
    database = DatabaseProvider.get();
  }

  static dynamic _getQueryAll({int productId, bool onlyMyProducts, String search}){
    String query = "SELECT * FROM " + PRODUCT_TABLE_NAME;
    var options = "";
    List params = [];

    if(onlyMyProducts!=null){
      if(onlyMyProducts == true){
        query +=  options + " WHERE is_my_product=?";
        params.add(1);
      }
    }

    if(search!=null){
      query +=  options + " WHERE name LIKE '%$search%'";
     // params.add(search);
    }

    query +=  options + " ORDER BY name ASC";

    //params = [query, options];

    return [
      query,
      params
    ];
  }

  Future<List<ProductModel>> getAll(int page, {ProductModel search}) async {
    try {
      var db = await database.db;
    

      var res = await db.rawQuery('query[0]', []);

      List<ProductModel> list = ProductModel.listFromJson(res);


      return list;
    } catch (e) {
      print('ProductRepository.getAll: ${e.toString()}');
      return [];
    }
  }

  Future<void> insertProdutcts(List<ProductModel> array) async {
    try {
      Database db = await database.db;
      var dbBatch = db.batch();

      for (var item in array) {
        dbBatch.insert(
          PRODUCT_TABLE_NAME, 
          item.toMapOff()
        );
      }

      print('inserted Product');
      await dbBatch.commit();
    } catch (e) {
      print('ProductRepository.insertProducts: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }

  Future<void> updateProduct(ProductModel item) async {
    try {
      Database db = await database.db;
      var dbBatch = db.batch();

      dbBatch.update(
        PRODUCT_TABLE_NAME, 
        item.toMapOff(),
        where: 'id = ?', 
        whereArgs: [item.id]
      );

      print('update Product');
      await dbBatch.commit();
    } catch (e) {
      print('ProductRepository.updateProduct: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }

  Future<void> deleteProducts() async {
    try {
      print('delete Product');

      var db = await database.db;
      db.delete(PRODUCT_TABLE_NAME);
    } catch (e) {
      print('ProductRepository.deleteProducts: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }

  Future<void> deleteProductById(int id) async {
    try {
      print('delete Product');

      var db = await database.db;
      db.delete(PRODUCT_TABLE_NAME, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print('ProductRepository.deleteProductById: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }


  //-------------OFF----------

  Future<List<ProductModel>> getAllOff({bool onlyMyProducts, int productId, String search}) async {
    try {
      var db = await database.db;

      var query = _getQueryAll(productId: productId, onlyMyProducts: onlyMyProducts, search: search);

      var res = await db.rawQuery(query[0], query[1]);

      List<ProductModel> list = ProductModel.listFromJsonII(res);


      return list;
    } catch (e) {
      print('ProductRepository.getAllOff: ${e.toString()}');
      return [];
    }
  }

  Future<List<ProductModel>> getAllOffForSync() async {
    try {
      var db = await database.db;
      var res = await db.query(PRODUCT_TABLE_NAME, orderBy: 'criado DESC', where: "pessoaUsuarioId = ?",);

      List<ProductModel> list = ProductModel.listFromJson(res);

      return list;
    } catch (e) {
      print('ProductRepository.getAllOffForSync: ${e.toString()}');
      return [];
    }
  }

  Future<ProductModel> getDadosById(ProductModel item) async {
    try {
      var db = await database.db;
      
      
      return item;
    } catch (e) {
      print('ProductRepository.getById: ${e.toString()}');
      return null;
    }
  }

  Future<int> insertProductOff(ProductModel item) async {
    try {
      Database db = await database.db;
      var dbBatch = db.batch();

      dbBatch.insert(
        PRODUCT_TABLE_NAME, 
        item.toMapOff(),
      );

      print('inserted ProductOff');
      var results = await dbBatch.commit();

      if(results.length > 0) return results[0];
      else return 0;
    } catch (e) {
      print('ProductRepository.insertProductOff: ${e.toString()}');
      return 0;
    }
  }

  Future<void> updateProductOff(ProductModel item) async {
    try {
      Database db = await database.db;
      var dbBatch = db.batch();

      dbBatch.update(
        PRODUCT_TABLE_NAME, 
        item.toMapOff(),
        where: 'id = ?', 
        whereArgs: [item.id]
      );

      print('updated ProductOff');
      await dbBatch.commit();
    } catch (e) {
      print('ProductRepository.updateProductOff: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }

  Future<void> deleteProductOffById(int id) async {
    try {
      print('delete ProductOff');

      var db = await database.db;
      db.delete(PRODUCT_TABLE_NAME, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print('ProductRepository.deleteProductOffById: ${e.toString()}');
      throw DataBaseException(e.toString());
    }
  }
  
}