import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:confereshop/widgets/appbar.dart';



class ContatosPage extends StatefulWidget {
  @override
  _ContatosPageState createState() => new _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> with SingleTickerProviderStateMixin {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var contatos = [
    {
      'title': '@.org.br',
      'icon': LineAwesomeIcons.at,
      'value': ':@.org.br'
    },
    {
      'title': '',
      'icon': LineAwesomeIcons.facebook,
      'value': 'https://www.facebook.com/'
    }
  ];

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
      appBar: appBarWithBack(context, "Contatos"),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: contatos.length,
                  padding: EdgeInsets.all(0.0),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 1.0,
                        color: Colors.grey[500],
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0),
                      leading: Icon(
                        contatos[index]['icon'],
                        color: Colors.black,
                        size: 40.0,
                      ),
                      title: new Text(
                        contatos[index]['title'],
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                      },
                    );
                  }),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey[500])),
            ),
          ],
        ),
      ),
    );
  }
}
