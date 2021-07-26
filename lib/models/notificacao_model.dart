
import 'package:confereshop/utils/extractor_json.dart';

class NotificacaoModel {// notification

  String id;//PK
  String postId;//PK
  DateTime createdAt;
  String title;
  String resume;
  String subject;
  bool read;
  String idPush;

  String city;
  String flag;
  String image;
  String urlWebView;
  String fonteNoticia;
  
  NotificacaoModel ({  
    this.id, 
    this.postId,
    this.createdAt,
    this.title,
    this.resume,
    this.subject,
    this.read,
    this.idPush,
    this.city,
    this.flag,
    this.fonteNoticia,
    this.image,
    this.urlWebView
  });

  factory NotificacaoModel.fromJson(Map<String, dynamic> json) =>  NotificacaoModel(
    postId: Extractor.extractString(json['postId'], ''),
    id: json['_id'],
    idPush: json['_id'],
    createdAt: Extractor.extractDate(json['createdAt']),
    title: Extractor.extractString(json['title'], ''),
    resume: Extractor.extractString(json['resume'], ''),
    subject: Extractor.extractString(json['subject'], ''),
    city: Extractor.extractString(json['city'], ''),
    flag: Extractor.extractString(json['flag'], ''),
    fonteNoticia: Extractor.extractString(json['font'], ''),
    image: Extractor.extractString(json['image'], ''),
    urlWebView: Extractor.extractString(json['url'], ''),
  );

   Map<String, dynamic> toJson() => {
    "postId": postId,
    "_id": id,
    "title": title,
    "resume": resume,
    "createdAt": createdAt,
    "subject": subject,
    "read": read,
  };

  static List<NotificacaoModel> listFromJson(List<dynamic> data) {
    return data.map((post) => NotificacaoModel.fromJson(post)).toList();
  }

}
