import 'package:confereshop/models/size_model.dart';
import 'package:confereshop/utils/extractor_json.dart';
import 'dart:convert' as jsn;

class ProductModel {
  
  int id;
  String name;
  String style;
  String codeColor;
  String codeSlug;
  String color;
  String onSale;
  String regularPrice;
  String actualPrice;
  String discountPercentage;
  String installments;
  String image;
  List<SizeModel> sizes;


  //added
  bool isMyProduct;
  bool active;

  ProductModel({
    this.id,
    this.name,
    this.style,
    this.codeColor,
    this.codeSlug,
    this.color,
    this.onSale,
    this.regularPrice,
    this.actualPrice,
    this.discountPercentage,
    this.installments,
    this.image,
    this.sizes,

    this.isMyProduct,
    this.active
  });

  factory ProductModel.fromJson(dynamic json, int index) => json != null ? ProductModel(
    id: Extractor.extractInt(json['code_color'].toString().replaceAll("_", "") ),
    name: Extractor.extractString(json['name'], ''),
    style: Extractor.extractString(json['style'], ''),
    codeColor: Extractor.extractString(json['code_color'], ''),
    codeSlug: Extractor.extractString(json['color_slug'], ''),
    color: Extractor.extractString(json['color'], ''),
    onSale: Extractor.extractString(json['on_sale'], ''),
    regularPrice: Extractor.extractString(json['regular_price'], ''),
    actualPrice: Extractor.extractString(json['actual_price'], ''),
    discountPercentage: Extractor.extractString(json['discount_percentage'], ''),
    installments: Extractor.extractString(json['installments'], ''),
    image: Extractor.extractString(json['image'], ''),
    sizes: SizeModel.listFromJson(json['sizes']),
    isMyProduct: json['is_my_product'] != null ? Extractor.extractBool(json['is_my_product']) : false,
    active: json['active'] != null ? Extractor.extractBool(json['active']) : true,
  ) : null;

  factory ProductModel.fromJsonII(dynamic json, int index) => json != null ? ProductModel(
    id: json['id'],
    name: Extractor.extractString(json['name'], ''),
    style: Extractor.extractString(json['style'], ''),
    codeColor: Extractor.extractString(json['code_color'], ''),
    codeSlug: Extractor.extractString(json['color_slug'], ''),
    color: Extractor.extractString(json['color'], ''),
    onSale: Extractor.extractString(json['on_sale'], ''),
    regularPrice: Extractor.extractString(json['regular_price'], ''),
    actualPrice: Extractor.extractString(json['actual_price'], ''),
    discountPercentage: Extractor.extractString(json['discount_percentage'], ''),
    installments: Extractor.extractString(json['installments'], ''),
    image: Extractor.extractString(json['image'], ''),
    sizes: SizeModel.listFromJson(jsn.jsonDecode(json['sizes'])['sizes']),
    isMyProduct: json['is_my_product'] != null ? Extractor.extractBool(json['is_my_product']) : false,
    active: json['active'] != null ? Extractor.extractBool(json['active']) : true,
  ) : null;


  Map<String, dynamic> toMap() => { 
    'id': id,
    'name': name,
    'style': style,
    'code_color': codeColor,
    'color_slug': codeSlug,
    'color': color,
    'on_sale': onSale,
    'regular_price': regularPrice,
    'actual_price': actualPrice,
    'discount_percentage': discountPercentage,
    'installments': installments,
    'image': image,
    'sizes': jsn.jsonEncode({
      'sizes': SizeModel.listToMap(sizes)
    }),
    'is_my_product': isMyProduct ? "1" : "0",
    'active': active ? "1" : "0"
  };

  Map<String, dynamic> toMapOff() => { 
    'id': id,
    'name': name,
    'style': style,
    'code_color': codeColor,
    'color_slug': codeSlug,
    'color': color,
    'on_sale': onSale,
    'regular_price': regularPrice,
    'actual_price': actualPrice,
    'discount_percentage': discountPercentage,
    'installments': installments,
    'image': image,
    'sizes': jsn.jsonEncode({
      'sizes': SizeModel.listToMap(sizes)
    }),
    'is_my_product': isMyProduct ? "1" : "0",
    'active': active ? "1" : "0"
  };

  factory ProductModel.clone(ProductModel product) => ProductModel(
    id: product.id,
    name: product.name,
    style: product.style,
    codeColor: product.codeColor,
    codeSlug: product.codeSlug,
    color: product.color,
    onSale: product.onSale,
    regularPrice: product.regularPrice,
    actualPrice: product.actualPrice,
    discountPercentage: product.discountPercentage,
    installments: product.installments,
    image: product.image,
    sizes: product.sizes,
    isMyProduct: product.isMyProduct,
    active: product.active
  );

  static List<ProductModel> listFromJson(List<dynamic> data) {
    if(data == null) return [];
    else return data.map((post) => ProductModel.fromJson(post, data.indexOf(post))).toList();
  }

  static List<ProductModel> listFromJsonII(List<dynamic> data) {
    if(data == null) return [];
    else return data.map((post) => ProductModel.fromJsonII(post, data.indexOf(post))).toList();
  }

  static List<Map<String, dynamic>> listToMap(List<ProductModel> data) {
    if(data == null) return [];
    else return data.map((post) => post.toMap()).toList();
  }

}