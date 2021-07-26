import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/pages/produto/cad_produto_page.dart';
import 'package:confereshop/pages/produto/sizes_list_page.dart';
import 'package:confereshop/pages/produto/mais_produtos_page.dart';
import 'package:confereshop/pages/produto/produto_opcao_page.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter/material.dart';



class DetalheProdutoPage extends StatefulWidget {
  ProductModel product;
  final List<ProductModel> produtosFamosos;
  final List<ProductModel> produtosDesconto;
  DetalheProdutoPage({Key key, this.product, this.produtosFamosos, this.produtosDesconto}) : super(key: key);

  @override
  _DetalheProdutoPageState createState() => _DetalheProdutoPageState(product);
}

class _DetalheProdutoPageState extends State<DetalheProdutoPage> {
  final ProductModel product;

  _DetalheProdutoPageState(this.product);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int active;

  ///list of product colors
  List<Widget> colors() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.primaries[i],
                child: SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  List<ProductModel> produtosIguais = [];

  @override
  void initState() {
    super.initState();
    for (var item in widget.produtosFamosos) {
      if(widget.product.style == item.style){
        produtosIguais.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: CustomsColors.customBlueI,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.product.name,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18.0),
          ),
        ),
        floatingActionButton: editProduct(),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                ProdutoOpcaoPage(
                  _scaffoldKey,
                  product: product,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: widget.product.onSale == "true"? Column(
                      children: [
                        Text(widget.product.regularPrice, style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough)),

                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[

                              TextSpan(text: widget.product.actualPrice, style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold)),
                              
                              TextSpan(text: ' ' + widget.product.discountPercentage + ' OFF', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                                    
                            ],
                          ),
                        )
                      ],
                    ) :RichText(
                      text: TextSpan(
                        children: <TextSpan>[

                          TextSpan(text: widget.product.regularPrice, style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold)),

                        ],
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizesListPage(widget.product),
                ),
                
                widget.produtosFamosos.isEmpty || widget.produtosDesconto.isEmpty ? Container() : MaisProdutosPage(produtosFamosos: widget.produtosFamosos, produtosDesconto: widget.produtosDesconto),
                
                SizedBox(height: 40,)
              ],
            ),
          ),
        ));
  }
  
  Widget editProduct() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.edit, color: CustomsColors.customBlueI),
      onPressed: () async {
        var result = await Navigator.push(context, SlideRightRoute(page: CadProdutoPage(produto: product)));
        if(result != null) {
          if(result == 'reload'){
            setState(() {
              widget.product = result;
            }); 
          }else{
            Navigator.pop(context);
          }
        }
      },
    );
  }
}