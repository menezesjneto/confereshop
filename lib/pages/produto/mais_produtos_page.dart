import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/widgets/product/item_produto_widget.dart';
import 'package:flutter/material.dart';

class MaisProdutosPage extends StatelessWidget {

  final List<ProductModel> produtosFamosos;
  final List<ProductModel> produtosDesconto;

  MaisProdutosPage({Key key, this.produtosFamosos, this.produtosDesconto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'Top produtos mais desejados',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: ListView.builder(
            itemCount: produtosFamosos.length,
            itemBuilder: (_, index) {
              return Padding(
                  padding: index == 0
                      ? EdgeInsets.only(left: 24.0, right: 8.0)
                      : index == 4
                      ? EdgeInsets.only(right: 24.0, left: 8.0)
                      : EdgeInsets.symmetric(horizontal: 8.0),
                  child: ItemProdutoWidget(produtosFamosos[index], false, true, produtosFamosos, produtosDesconto));
            },
            scrollDirection: Axis.horizontal,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'Top produtos com desconto',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: ListView.builder(
            itemCount: produtosDesconto.length,
            itemBuilder: (_, index) {
              return Padding(
                  padding: index == 0
                      ? EdgeInsets.only(left: 24.0, right: 8.0)
                      : index == 4
                      ? EdgeInsets.only(right: 24.0, left: 8.0)
                      : EdgeInsets.symmetric(horizontal: 8.0),
                  child: ItemProdutoWidget(produtosDesconto[index], false, true, produtosFamosos, produtosDesconto));
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}