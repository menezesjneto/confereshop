import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confereshop/pages/config/config_page.dart';
import 'package:confereshop/pages/notificacoes_page.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/pages/produto/meus_produtos_page.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/api_provider.dart';
import '../resources/app_config.dart';
import '../widgets/theme.dart';
import 'home_page.dart';

class TabPage extends StatefulWidget {
  @override
  State createState() => new _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {


  PageController pageController;
  int _selectedIndex = 0;

  List<Widget> pages = <Widget>[
    HomePage(),
    MeusProdutosPage(),
    NotificacoesPage(),
    ConfigPage()
  ];

  @override
  void initState() {
    super.initState();

    pageController = new PageController(
      keepPage: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    ApiProvider.setUrlServer(AppConfig.of(context).urlServer);
    ApiProvider.setBuildType(AppConfig.of(context).buildType);
    
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          children: pages,
          physics: NeverScrollableScrollPhysics(), // No sliding
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[200],
          textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: CustomsColors.customBlueI))),
          child: BottomNavyBar(
            backgroundColor: CustomsColors.customBlueI,
            selectedIndex: _selectedIndex,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index){
              pageController.jumpToPage(index);
            },
            items: [
              BottomNavyBarItem(
                title: Text(' Início'),
                icon: Icon(LineAwesomeIcons.home, color: Colors.white, size: 30),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                title: Text(' Produtos'),
                icon: Icon(LineAwesomeIcons.cart_plus, color: Colors.white, size: 30),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                title: Text(' Lembretes'),
                icon: Badge(
                  badgeColor: Colors.red,
                  badgeContent: Text('2', style: TextStyle(color: Colors.white)),
                  child: Icon(LineAwesomeIcons.bell, color: Colors.white, size: 30),
                ),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                title: Text(' Mais'),
                icon: CachedNetworkImage(
                  imageUrl: 'https://source.unsplash.com/200x200/?user',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 30,
                      width: 30,
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
                      height: 30,
                      width: 30,
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
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
              ),
            ]
          ),
        )
      )
    );
  }

}
