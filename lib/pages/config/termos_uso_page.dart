import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/widgets/appbar.dart';


class TermosUsoPage extends StatefulWidget {
  @override
  _TermosUsoPageState createState() => new _TermosUsoPageState();
}

class _TermosUsoPageState extends State<TermosUsoPage> with SingleTickerProviderStateMixin {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarWithBack(context, "Termos de Uso"),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin:
            EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 60.0),
        alignment: Alignment.topCenter,
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
