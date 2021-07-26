import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/widgets/theme.dart';

// appbar that return to the old screen
Widget appBarWithBack(BuildContext context, String title) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context, null);
      },
    ),
    centerTitle: true,    
    title: Text(title, style: TextStyle(color: Colors.white)),
    backgroundColor: CustomsColors.customBlueI,
  );
}

Widget getAppBarHome(BuildContext context, String title, {List<Widget> actions, PreferredSize bottom}){
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(title, style: TextStyle(color: Colors.white)),
    backgroundColor: CustomsColors.customBlueI,
    actions: actions,
    bottom: bottom,
  );
}
