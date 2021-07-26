import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:confereshop/widgets/appbar.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/appbar.dart';
import '../intro/intro_page.dart';


class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => new _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Map<dynamic, dynamic>> _views = [
    {"title": "Termos de Uso", "icon": LineAwesomeIcons.files_o, "page": '/termos_uso'},
    {"title": "Política de Privacidade", "icon": LineAwesomeIcons.file_o, "page": '/politica_privacidade'},
    {"title": "Contatos", "icon": LineAwesomeIcons.phone, "page": '/contatos'},
    {"title": "Restaurar dados", "icon": LineAwesomeIcons.refresh, "page": '/refresh'},
    {"title": "Sair", "icon": LineAwesomeIcons.sign_out, "page": null},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBarHome(context, "Mais", actions: []),
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverList(delegate: SliverChildListDelegate([     

          Divider(height: 10.0, color: Colors.transparent),
          CachedNetworkImage(
            imageUrl: 'https://source.unsplash.com/200x200/?user',
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]
                ),
              ),
              placeholder: (context, url) => SizedBox(
                height: 100,
                width: 100,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            errorWidget: (context, url, error) => Icon(LineAwesomeIcons.cog, color: Colors.white, size: 30),
          ),
          Divider(height: 10.0, color: Colors.transparent),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text('José Maria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Divider(height: 10.0, color: Colors.transparent),
                Text('DEV Flutter', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                Text('menezesneto13@hotmail.com', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                Text('(91) 98087-1618', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                Text('Gostaria MUITO de trabalhar na equipe Confere!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          Divider(height: 20.0, color: Colors.transparent),
          _createList(context, _views),

        ]))
      ])
    );
  }

  Widget _createList(context, views) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.all(0.0),
      itemCount: views.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(views[index]["icon"], size: 30.0, color: CustomsColors.customBlueI),
              contentPadding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
              title: new Text(views[index]["title"], style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              onTap: () async {
                if(views[index]["page"] != null){
                  if(views[index]["page"] == '/refresh'){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.push(
                      context,
                      new PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => IntroPage(),
                        transitionsBuilder: (context, animation1, animation2, child) {
                          return FadeTransition(opacity: animation1, child: child);
                        },
                      ));
                  }
                }
                else _showDialogSair(context);
              },
            ),

            Divider(height: 1.0, color: Colors.transparent)
          ],
        )
            ;
      }
    );
  }

  void _showDialogSair(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deseja sair do app?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
          content: Text("Você pode recuperar seus dados cadastrados fazendo o login novamente!", style: TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            FlatButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Sim",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              onPressed: () {
                //UserProvider.logoutUser();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => new IntroPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
