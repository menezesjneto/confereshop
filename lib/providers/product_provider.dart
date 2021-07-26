
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/repositories/product_repository.dart';


class ProductProvider {

  static final ProductProvider _singleton = new ProductProvider._internal();
  factory ProductProvider() {
    return _singleton;
  }
  ProductProvider._internal();


  static Future<bool> saveAll(List<ProductModel> array) async {
    try {
      
      await ProductRepository.get().insertProdutcts(array);
      
      return true;
    } catch (e) {
      print('ProductProvider.saveAll: ${e.toString()}');
      return false;
    }
  }


  //------------OFF--------

  static Future<List<ProductModel>> getAllOff({bool onlyMyProducts, String search}) async {
    try {
      return await ProductRepository.get().getAllOff(onlyMyProducts: onlyMyProducts, search: search);
    } catch (e) {
      print('ProductProvider.getAllOff: ${e.toString()}');
      return [];
    }
  }

  static Future<List<ProductModel>> getAllOffForSync() async {
    try {
      
      return await ProductRepository.get().getAllOffForSync();
    } catch (e) {
      print('ProductProvider.getAllOffForSync: ${e.toString()}');
      return [];
    }
  }

  static Future<ProductModel> addOff(ProductModel item) async {
    try {

      var id = await ProductRepository.get().insertProductOff(item);


      if(id > 0) {
        item.id = id;
        return item;
      }
      else return null;
    } catch (e) {
      print('ProductProvider.addOff: ${e.toString()}');
      return null;
    }
  }
  
  static Future<bool> editOff(ProductModel item) async {
    try {
      await ProductRepository.get().updateProductOff(item);

      return true;
    } catch (e) {
      print('ProductProvider.editOff: ${e.toString()}');
      return false;
    }
  }

  static Future<bool> removeOff(int id) async {
    try {
      await ProductRepository.get().deleteProductOffById(id);

      return true;
    } catch (e) {
      print('ProductProvider.removeOff: ${e.toString()}');
      return false;
    }
  }

}