import 'package:confereshop/utils/extractor_json.dart';

class SizeModel {

  String size;
  String sku;
  bool available;

  SizeModel({
    this.size,
    this.sku,
    this.available
  });

  factory SizeModel.fromJson(dynamic json) => json != null ? SizeModel(
    size: Extractor.extractString(json['size'], ''),
    sku: Extractor.extractString(json['sku'], ''),
    available: Extractor.extractBool(json['available']),
  ) : null;

  Map<String, dynamic> toMap() => {
    "size": size,
    "sku": sku,
    "available": available
  };

  static List<SizeModel> listFromJson(List<dynamic> data) {
    if(data == null) return [];
    else return data.map((post) => SizeModel.fromJson(post)).toList();
  }

  static List<Map<String, dynamic>> listToMap(List<SizeModel> data) {
    if(data == null) return [];
    else return data.map((post) => post.toMap()).toList();
  }

}
