import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:confereshop/providers/api_provider.dart';
import 'package:confereshop/widgets/custom_widgets.dart';
import 'package:confereshop/widgets/theme.dart';

import '../widgets/appbar.dart';


class AvisosPage extends StatefulWidget {
  @override
  _AvisosPageState createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> with SingleTickerProviderStateMixin {
  
  RefreshController _refreshController;
  
  bool isRefresh = false;
  bool isLoad = false;
  List<dynamic> avisos = [];
  bool hasMore = true;
  bool isLoadingPage = false;
  int page = 0;


  @override
  void initState() {
    super.initState();    

    _refreshController = RefreshController(initialRefresh: false);
    
    _getAvisos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() {
    if(isLoad) {
      setState(() {
        page = 0;
        isRefresh = true;
        hasMore = true;
        avisos = [];
      });

      _getAvisos();
    } 
    else _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    if(avisos.length>0 && hasMore){
      setState(() {
        isLoadingPage = true;
        page += 30;
      });
      
      _getAvisos();
    }
    else _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarHome(context, "Avisos", actions: []),
      body: isLoad == false ? Container(
        margin: EdgeInsets.only(top: 80.0),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(CustomsColors.customBlueI))
      ) : SmartRefresher(
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
        child: CustomScrollView(
          primary: false,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([

                avisos.isEmpty ? semAvisos() : _createList(context)


              ])
            )
          ]
        ),
      ),
    );
  }


  Widget semAvisos(){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Text("Sem avisos", style: TextStyle(color: CustomsColors.customBlueI, fontSize: 22), textAlign: TextAlign.center),
    );
  }


  Widget _createList(context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      itemCount: avisos.length,
      itemBuilder: (BuildContext context, int index) {
        var item = avisos[index];

        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: ListTile(
                title: Text(item.titulo, style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.descricao, style: TextStyle(fontSize: 16, color: Colors.black87)),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(Icons.access_time, color: Colors.black, size: 15.0,),
                        Container(width: 1.0, height: 2.0,),
                        Text(ApiProvider.timeDifference(item.criado), style: TextStyle(fontSize: 12.0))
                      ]
                    ),
                  ],
                ),
              )
            )
          )
        );
      }
    );
  }


  void _getAvisos(){
    // AvisoProvider.getAll(page).then((values){
    //   setState(() {
    //     isLoad = true;
    //     isLoadingPage = false;

    //     _refreshController.loadComplete();
    //     if(isRefresh) {
    //       isRefresh = false;
    //       _refreshController.refreshCompleted();
    //     }

    //     for(var item in values) {
    //       avisos.add(item);
    //     }
        
    //     if(values.length == 0) hasMore = false;  
    //   });
    // });
  }

}
