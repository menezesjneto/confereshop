import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:confereshop/models/product_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {

  ProductBloc();

  final _productController = BehaviorSubject<ProductModel>();
  
  Stream<ProductModel> get streamProduct => _productController.stream;
  StreamSink<ProductModel> get sinkProduct=> _productController.sink;


  @override
  void dispose() {
    _productController.close();
  }

}