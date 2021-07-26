
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:confereshop/bloc/main_bloc.dart';
import 'package:confereshop/constants/db.dart';
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/pages/produto/cad_produto_page.dart';
import 'package:confereshop/pages/produto/meus_produtos_page.dart';
import 'package:confereshop/pages/produto/detalhe_produto_page.dart';
import 'package:confereshop/pages/search/search_page.dart';
import 'package:confereshop/providers/product_provider.dart';
import 'package:confereshop/repositories/product_repository.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/custom_widgets.dart';
import 'package:confereshop/widgets/product/item_produto_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  final MainBloc mainBloc = BlocProvider.getBloc<MainBloc>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<ProductModel> produtosRecuperados = [];

  List<ProductModel> produtosFamosos = [];

  List<ProductModel> produtosComDesconto = [];


  @override
  void initState() {
    super.initState();
    mainBloc.sinkIsLoading.add(true);
    createDB();
  }

  createDB() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    produtosRecuperados = [];
    produtosFamosos = [];
    produtosComDesconto = [];

    //VERIFICO SE JÁ PERSISTI NO DB OS DADOS ORIGINAIS
    if(prefs.containsKey('savedProducts') == false){ 
      List<ProductModel> produtos = ProductModel.listFromJson(Produtos['products']);
      print(produtos);
      await ProductRepository.get().deleteProducts();
      await ProductProvider.saveAll(produtos);
      prefs.setBool('savedProducts', true);
    }

    //RECUPERO OS DADOS SALVOS
    produtosRecuperados = [];
    produtosRecuperados = await ProductProvider.getAllOff();

    print(produtosRecuperados);


    for (var i = 0; i < produtosRecuperados.length; i++) {
      if(produtosRecuperados[i].onSale == 'true') produtosComDesconto.add(produtosRecuperados[i]);
      else produtosFamosos.add(produtosRecuperados[i]);
    }

    mainBloc.sinkIsLoading.add(false);
  }

  @override
  bool get wantKeepAlive => true;
 

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomsColors.customBlueI,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        title: GestureDetector(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Container(
              height: 40.0,
              margin: EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child:  Container(
                height: 30.0,
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: <Widget>[
                    Icon(LineAwesomeIcons.search, size: 25.0, color: CustomsColors.customBlueI),
                    Hero(
                    tag: 'splash',
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset("assets/imgs/logo1.png"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, left: 5),
                            child: Text('SHOP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              )
            )
          ),
          onTap: () async {
            Navigator.push(context, SlideRightRoute(page: SearchPage()));
          },
        ),
        backgroundColor: CustomsColors.customBlueI,
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: IconButton(
              padding: EdgeInsets.only(right: 10.0),
              icon: Icon(LineAwesomeIcons.cart_plus, size: 45.0,),
              onPressed: () async {
                Navigator.push(context, SlideRightRoute(page: MeusProdutosPage(returnPage: true)));
              },
            ),  
          )

        ],
      ),
      body: StreamBuilder<bool>(
        initialData: null,
        stream: mainBloc.streamIsLoading,
        builder: (BuildContext context, snap) {

          if(snap.hasData){
            
            return snap.data == true ? CustomWidgets.showLoading(context) : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus mode){
                  return Container(
                    height: 55.0,
                  );
                },
              ),
              
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: <Widget>[

                    SliverList(
                    delegate: SliverChildListDelegate(
                      [

                        produtosComDesconto.isEmpty ? Container() : Container(
                          margin: EdgeInsets.all(10),
                          child: Text('Produtos com Desconto', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                        ),

                        produtosComDesconto.isEmpty ? Container() : createListProdutosComDesconto(),

                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/imgs/banner1.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(CustomsColors.customBlueIII, BlendMode.softLight)
                            )
                          ),
                        ),

                        produtosFamosos.isEmpty ? Container() : Container(
                          margin: EdgeInsets.all(10),
                          child: Text('Produtos Famosos', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                        ),


                        produtosFamosos.isEmpty ? Container() : createGridProdutosFamosos(context),
                      ]
                    )
                  ),
                ]
              ),
            );
          } else return Container();
      }
    ),
    );
  }

  Widget createGridProdutosFamosos(context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 2.0,
        childAspectRatio: 0.65
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: produtosFamosos.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
        position: index,
        duration: Duration(milliseconds: 600),
        columnCount: 2,
        delay: Duration(milliseconds: 400),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FlipAnimation(
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Editar',
                    color: CustomsColors.customBlueIII,
                    icon: Icons.edit,
                    onTap: () async{
                      await Navigator.push(context, SlideRightRoute(page: CadProdutoPage(produto: produtosFamosos[index])));
                      _onRefresh();
                    },
                  ),
                  IconSlideAction(
                    caption: 'Deletar',
                    color: CustomsColors.customBlueII,
                    icon: Icons.delete,
                    onTap: (){
                      _showDialogDeletar(context, produtosFamosos[index]);
                    },
                  ),
                ],
                child: TextButton(
                child: ItemProdutoWidget(produtosFamosos[index], false, true, produtosFamosos, produtosComDesconto),
                onPressed: () async {
                  await Navigator.push(context, SlideRightRoute(page: DetalheProdutoPage(product: produtosFamosos[index], produtosFamosos: produtosFamosos, produtosDesconto: produtosComDesconto)));
                  _onRefresh();
                },
              )
            ))
          ),
        );
      });
  }

  Widget createListProdutosComDesconto(){
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      height: 250,
      child: ListView.builder(
        itemCount: produtosComDesconto.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (_, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: Duration(milliseconds: 600),
            columnCount: 2,
            delay: Duration(milliseconds: 400),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FlipAnimation(
                  child:  Padding(
                  padding: index == 0
                      ? EdgeInsets.only(left: 0.0, right: 8.0)
                      : index == 4
                      ? EdgeInsets.only(right: 24.0, left: 8.0)
                      : EdgeInsets.symmetric(horizontal: 8.0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    direction: Axis.vertical,
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Editar',
                        color: CustomsColors.customBlueIII,
                        icon: Icons.edit,
                        onTap: () async{
                          await Navigator.push(context, SlideRightRoute(page: CadProdutoPage(produto: produtosComDesconto[index])));
                          _onRefresh();
                        },
                      ),
                      IconSlideAction(
                        caption: 'Deletar',
                        color: CustomsColors.customBlueII,
                        icon: Icons.delete,
                        onTap: (){
                          _showDialogDeletar(context, produtosComDesconto[index]);
                        },
                      ),
                    ],
                    child: 
                  TextButton(
                    child: ItemProdutoWidget(produtosComDesconto[index], false, true, produtosFamosos, produtosComDesconto),
                    onPressed: () async{
                      await Navigator.push(context, SlideRightRoute(page: DetalheProdutoPage(product: produtosComDesconto[index], produtosFamosos: produtosFamosos, produtosDesconto: produtosComDesconto)));
                      _onRefresh();
                    },
                  )
                  )
                )
              )
            )
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _onRefresh(){
    mainBloc.sinkIsLoading.add(true);
    createDB();
  }

  void _showDialogDeletar(context, ProductModel produto) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Deseja deletar este produto?"),
          content: Text("Esta ação não poderá ser revertida!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),

            FlatButton(
              child: Text(
                "Sim",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              onPressed: () {
                _deletar(ctx, produto);
              },
            ),
          ],
        );
      },
    );
  }

  void _deletar(ctx, produto) {
    ProductProvider.removeOff(produto.id).then((value){
      _onRefresh();
      Navigator.pop(context);
    });
  }


}
