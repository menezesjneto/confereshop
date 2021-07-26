import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/pages/produto/cad_produto_page.dart';
import 'package:confereshop/pages/produto/detalhe_produto_page.dart';
import 'package:confereshop/providers/product_provider.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/product/item_produto_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:confereshop/widgets/custom_widgets.dart';
import 'package:confereshop/widgets/theme.dart';


class MeusProdutosPage extends StatefulWidget {
  final bool returnPage;
  MeusProdutosPage({Key key, this.returnPage}) : super(key: key);
  
  @override
  _MeusProdutosPageState createState() => _MeusProdutosPageState();
}

class _MeusProdutosPageState extends State<MeusProdutosPage> with AutomaticKeepAliveClientMixin {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  bool isLoading = true;

  List<ProductModel> meusProdutos = [];


  @override
  void initState() {
    super.initState();
    getMyProducts();
  }

  getMyProducts() async{
    meusProdutos = await ProductProvider.getAllOff(onlyMyProducts: true);
    setState(() {
      isLoading = false;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: meusProdutos.isEmpty && isLoading == false ? Colors.white : Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('Meus Produtos', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomsColors.customBlueI,
        actions: [],
        automaticallyImplyLeading: widget.returnPage == true ? true : false,
        leading: widget.returnPage != true ? null : IconButton(
          onPressed: (){
              if(widget.returnPage == true){
                Navigator.pop(context);
              }
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      floatingActionButton: cadProduct(),
      body: isLoading ? CustomWidgets.showLoading(context) : CustomScrollView(
        slivers: <Widget>[

            SliverList(
            delegate: SliverChildListDelegate(
              [

                meusProdutos.isEmpty ? Container() : Container(
                  margin: EdgeInsets.all(10),
                  child: Text('Produtos Cadastrados por Mim', style: TextStyle(color: CustomsColors.customBlueI, fontSize: 22, fontWeight: FontWeight.bold),),
                ),

                meusProdutos.isEmpty && isLoading == false ? Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('Nenhum produto cadastrado\npor você', style: TextStyle(color: CustomsColors.customBlueI, fontSize: 22, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                      
                      
                      Container(
                        height: 450,
                        child: FlareActor("assets/flare/empy_products.flr", animation: "1", fit: BoxFit.contain),
                      ),
                      
                    ],
                  )
                ) : Container(),


                createGridProdutos(context),

              ]
            )
          ),

        ]
      )   
    );
  }

  Widget createGridProdutos(context) {
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
      itemCount: meusProdutos.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
        position: index,
        duration: Duration(milliseconds: 600),
        columnCount: 2,
        delay: Duration(milliseconds: 400),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FlipAnimation(
              child: meusProdutos[index].sizes.isEmpty || meusProdutos[index].sizes[0].available == false ? Container() :
              TextButton(
                child: ItemProdutoWidget(meusProdutos[index], false, true, [], []),
                onPressed: () async {
                  await Navigator.push(context, SlideRightRoute(page: DetalheProdutoPage(product: meusProdutos[index], produtosFamosos: [], produtosDesconto: [])));
                  setState(() {
                    isLoading = true;
                    getMyProducts();
                  });
                },
              )
            )
          ),
        );
      });
  }

  Widget cadProduct() {
    return FloatingActionButton(
      backgroundColor: CustomsColors.customBlueI,
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () async {
        await Navigator.push(context, SlideRightRoute(page: CadProdutoPage()));

        setState(() {
          isLoading = true;
          getMyProducts();
        });
        
      },
    );
  }


}
