import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/constants/mensagens.dart';
import 'package:confereshop/widgets/theme.dart';


class CustomInput {
  static final CustomInput _singleton = new CustomInput._internal();
  factory CustomInput() {
    return _singleton;
  }
  CustomInput._internal();

  static InputDecoration inputDecorationI(String hintText, {bool showError, bool obscureText, Function setObscureText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      counterText: '',
      counterStyle: TextStyle(fontSize: 0),
      //counter: null,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusedBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
      enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: CustomsColors.customBlueI), borderRadius: BorderRadius.circular(5.0)),
      errorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey),  borderRadius: BorderRadius.circular(5.0)),
      focusedErrorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
      errorStyle: TextStyle(fontSize: showError == true ? 10.0 : 0.0),
      contentPadding: EdgeInsets.all(15.0),
      suffixIcon: setObscureText != null ? IconButton(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
        icon: Icon(
          obscureText == true ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
          color: CustomsColors.customBlueI,
          size: 25.0
        ),
        onPressed: () {
          setObscureText();
        }
      ): null
    );
  }

  static InputDecoration inputDecorationSelect(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      counterText: '',
      counterStyle: TextStyle(fontSize: 0),
      counter: null,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusedBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
      enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: CustomsColors.customBlueI), borderRadius: BorderRadius.circular(5.0)),
      errorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey),  borderRadius: BorderRadius.circular(5.0)),
      focusedErrorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
      contentPadding: EdgeInsets.all(15.0),
      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
    );
  }

  static BoxDecoration decorationCircular() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0)
    );
  }

  static BoxDecoration decorationCircularII() {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CustomsColors.customBlueI, width: 1.0),
    );
  }

  static BoxDecoration decorationCircularIII() {
    return BoxDecoration(
      color: CustomsColors.customBlueI,
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  static Widget getInputLabel(textLabel) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, bottom: 5.0, top: 15.0),
      child: Text(textLabel, style: TextStyle(fontSize: 18.0, color: CustomsColors.customBlueI, fontWeight: FontWeight.bold))
    );
  }

  static Widget getInputLabelII(textLabel) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, bottom: 5.0, top: 15.0),
      child: Text(textLabel, style: TextStyle(fontSize: 18.0, color: Colors.black))
    );
  }

  static void showDialogMensagem(context, value) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(Mensagens[value]['titulo']),
          content: ((Mensagens[value]['mensagem'] != '') ? Text(Mensagens[value]['mensagem']) : null),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK",  style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogCustomMensagem(context, value) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(value['titulo']),
          content: ((value['mensagem'] == '') ? Text(value['mensagem']) : null),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK",  style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSnackbarSuccessMessage(scaffoldKey, value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text("${Mensagens[value]['titulo']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 2),
    ));
  }

  static void showSnackbarErrorMessage(scaffoldKey, value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Text("${Mensagens[value]['titulo']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
           Text("${Mensagens[value]['mensagem']}", style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }

  static void showSnackbarErrorCustomMessage(scaffoldKey, message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Erro!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
          Text("$message", style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }

}
