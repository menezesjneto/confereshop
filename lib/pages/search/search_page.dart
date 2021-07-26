import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/pages/produto/detalhe_produto_page.dart';
import 'package:confereshop/providers/product_provider.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/product/item_produto_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:confereshop/widgets/theme.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  bool isLoading = false;

  List<ProductModel> searchProducts = [];


  @override
  void initState() {
    super.initState();
  }


  search(String text) async{
    searchProducts = [];
    searchProducts = await ProductProvider.getAllOff(onlyMyProducts: false, search: text);
    print(searchProducts);
    setState(() {
      
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: searchProducts.isEmpty && isLoading == false ? Colors.white : Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomsColors.customBlueI),
        leading: IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(Icons.keyboard_arrow_left, size: 40.0),
          onPressed: (){
            Navigator.pop(context, null);
          },
        ),
        title: TextField(
          textInputAction: TextInputAction.search,
          style: new TextStyle(
            color: CustomsColors.customBlueI,
          ),
          autofocus: true,
          decoration: new InputDecoration(
            hintText: "Pesquise na Confere SHOP",
            hintStyle: new TextStyle(color: CustomsColors.customBlueI),
            labelStyle: new TextStyle(color: CustomsColors.customBlueI),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.close, color: Colors.grey,),
              onPressed: (){
              },
            )
          ),
          onSubmitted: (text){

          },
          onChanged: (val){
            if(val.length > 0){
              search(val);
            }else{
              setState(() {
                searchProducts = [];
              });
            }
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[

            SliverList(
            delegate: SliverChildListDelegate(
              [


                searchProducts.isEmpty && isLoading == false ? Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('Pesquise o nome de\nalgum produto', style: TextStyle(color: CustomsColors.customBlueI, fontSize: 22, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                      
                      
                      Container(
                        height: 450,
                        child: FlareActor("assets/flare/empy_products.flr", animation: "1", fit: BoxFit.contain),
                      ),
                      
                    ],
                  )
                ) : Container(),


                createListSearch(context),

              ]
            )
          ),

        ]
      )   
    );
  }

  Widget createListSearch(context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      itemCount: searchProducts.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
        position: index,
        duration: Duration(milliseconds: 600),
        columnCount: 2,
        delay: Duration(milliseconds: 400),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FlipAnimation(
              child: searchProducts[index].sizes.isEmpty || searchProducts[index].sizes[0].available == false ? Container() :
              Container(
                height: 250,
                child: TextButton(
                  child: ItemProdutoWidget(searchProducts[index], false, true, [], []),
                  onPressed: () async {
                    await Navigator.push(context, SlideRightRoute(page: DetalheProdutoPage(product: searchProducts[index], produtosFamosos: [], produtosDesconto: [])));
                    setState(() {
                      isLoading = true;
                      searchProducts = [];
                    });
                  },
                ),
              ),
            )
          ),
        );
      });
  }

}
