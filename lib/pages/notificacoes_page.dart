import 'dart:async';

import 'package:badges/badges.dart';
import 'package:confereshop/models/notificacao_model.dart';
import 'package:confereshop/widgets/appbar.dart';
import 'package:confereshop/widgets/custom_widgets.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificacoesPage extends StatefulWidget {
  
  const NotificacoesPage({Key key}) : super(key: key);

  @override
  State createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> with AutomaticKeepAliveClientMixin {

  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  var load = true;
  bool hasMore = true;  
  bool isLoadingPage = false;
  List<NotificacaoModel> notificacoes = [
    NotificacaoModel(
      city: 'Belém',
      createdAt: DateTime(2021, 7, 22),
      read: true,
      resume: 'Nesse desafio você construirá uma versão super simplificada de um Gerenciador de produtos.',
      title: 'Nesse desafio você construirá uma versão super simplificada de um Gerenciador de produtos.',
    ),
    NotificacaoModel(
      city: 'Belém',
      createdAt: DateTime(2021, 7, 3),
      read: false,
      resume: 'Desafio Software Engineer, Mobile Developer - Confere',
      title: 'Desafio Software Engineer, Mobile Developer - Confere',
    ),
  ];
  bool isSendingWidget = false;
  bool isRefresh = false;
  int page = 0;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if(!isSendingWidget){
          Navigator.pop(context, null);
        }

        return false;
      },
      child: Stack(
        children: <Widget>[ 
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: getAppBarHome(context, "Notificações", actions: []),
            body: SmartRefresher(
              primary: false,
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(
                color: CustomsColors.customBlueI,
                backgroundColor: Colors.grey[200],
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus mode){
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_drop_up, color: CustomsColors.customBlueI),
                        Text("Carregar mais", style: TextStyle(fontSize: 12, color: CustomsColors.customBlueI),)
                      ],
                    );
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("Ops, algo de errado aconteceu, verifique a sua conexão.");
                  }
                  else if(mode == LoadStatus.canLoading){
                      body = Text("");
                  }
                  else{
                    body = Text("");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              child: isLoading ? 
              CustomWidgets.showLoading(context)
               : CustomScrollView(
                controller: _scrollController,
                primary: false,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([

                      load?Container():Container(
                        margin: EdgeInsets.only(top: 50.0),
                        alignment: Alignment.center,
                        height: 50.0,
                        width: 50.0,
                        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(CustomsColors.customBlueI))
                      ),

                    (notificacoes.length==0 && load)?Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(LineAwesomeIcons.bell_slash, size: 100.0, color: CustomsColors.customBlueI,),
                            Text('Sem notificações!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomsColors.customBlueI),)
                          ],
                        )
                      ):createList(context),
                      
                    ])
                  )
                ]
              ),
            )
          ),

        ]
     
      )
    );
  }

  void _onRefresh() async{
    setState(() {
      page = 1;
    });
  }

  void _onLoading() async{
  }
  

  Widget createList(context) {
    return new ListView.separated(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.all(0.0),
      itemCount: notificacoes.length,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, color: Colors.grey[300], thickness: 0.7),
      itemBuilder: (BuildContext context, int index) {
        String dataText = '';
        String timeText = formatDate(notificacoes[index].createdAt, [HH, ':', nn]);
        if(DateTime.now().day == notificacoes[index].createdAt.day){
          dataText = 'Hoje às ' + timeText;
        }else if(DateTime.now().difference(notificacoes[index].createdAt).inDays == 1){
          dataText = 'Ontem às ' + timeText;
        }else{
          dataText = 'Há ' + DateTime.now().difference(notificacoes[index].createdAt).inDays.toString() + ' dias';
        }

        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                padding: EdgeInsets.all(10),
                color: notificacoes[index].read == false ? Color(0xffE8ECED) : Colors.white,
                child: Badge(
                  toAnimate: false,
                  elevation: 10,
                  position: BadgePosition.topEnd(),
                  shape: BadgeShape.square,
                  alignment: Alignment.topLeft,
                  borderRadius: BorderRadius.circular(1),
                  showBadge: notificacoes[index].read == false ? true : false,
                  badgeColor: CustomsColors.customBlueI,
                  badgeContent: Text('Não lida', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300, color: Colors.white),),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    title: new Text(notificacoes[index].title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(color: Colors.transparent),
                        Row(
                          children: <Widget>[
                            Container(height: 2.0,),
                            Text(dataText, style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w300)),
                            Spacer(),
                          ]
                        ),
                      ],
                    ),
                    trailing: notificacoes[index].resume != "" ? Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey[400],) : Container(height: 0, width: 0),
                    onTap: () async {
                    },
                  ),
                ),
              ),
            )
          ),
        );
      });
  }


  @override
  bool get wantKeepAlive => true;

}