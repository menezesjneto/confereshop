import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:confereshop/widgets/theme.dart';


class CustomWidgets {

  static final CustomWidgets _singleton = new CustomWidgets._internal();
  factory CustomWidgets() {
    return _singleton;
  }
  CustomWidgets._internal();

  static Widget showLoading(context){
    return Container(
      color: Colors.grey[100],
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          child: Container(
            margin: EdgeInsets.fromLTRB(60, 60, 60, 250),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: SpinKitCircle(
                    color: CustomsColors.customBlueI,
                    size: 35,
                  ),
                ),

                Text("Aguarde um instante", style: TextStyle(color: Colors.black45, fontSize: 14.0, decoration: TextDecoration.none), textAlign: TextAlign.justify),
              ]
            ),
          ),
        ),
      )
    );
  }

  static Widget showCirularLoading(bool load){
    return load?Container():Container(
      margin: EdgeInsets.only(top: 80.0),
      alignment: Alignment.center,
      height: 50.0,
      width: 50.0,
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(CustomsColors.customBlueI))
    );
  }

  static Widget showEmptyList(String texto){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.block, size: 100.0, color: CustomsColors.customBlueI),
          Text(texto, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomsColors.customBlueI),)
        ],
      )
    );
  }

  static Widget getCircleIcon(icon){
    return Container(
      child: Icon(icon, color: Colors.black),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            spreadRadius: 1.0
          ),
        ]
      )
    );
  }

  static Widget getSquareImg(img){
    return Container(
      child: Image.asset(img),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            spreadRadius: 1.0
          ),
        ]
      )
    );
  }

  static Widget showInfoSistema(String texto){
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(texto, style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold)),
      )
    );
  }

  static dynamic showSnackBarSuccess(scaffoldKey, String message){
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 17, color: Colors.white)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)))
      )
    );
  }

  static dynamic showSnackBarError(GlobalKey<ScaffoldState> scaffoldKey, String message){
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 17, color: Colors.white)),
        backgroundColor: Colors.red.withOpacity(0.9),
        duration: Duration(seconds: 6),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.black,
          onPressed: (){
            scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)))
      )
    );
  }

}