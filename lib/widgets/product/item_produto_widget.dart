import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemProdutoWidget extends StatelessWidget {

  const ItemProdutoWidget(this.produto, this.isProdList, this.isDetalheProduto, this.produtosFamosos, this.produtosDesconto);

  final ProductModel produto;
  final List<ProductModel> produtosFamosos;
  final List<ProductModel> produtosDesconto;
  final bool isProdList;
  final bool isDetalheProduto;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: isProdList?_listRow(context):_listColumn(context),
    );
  }

  Widget _listColumn(context){
    return Badge(
      toAnimate: false,
      elevation: 10,
      position: BadgePosition.topEnd(),
      shape: BadgeShape.square,
      alignment: Alignment.topLeft,
      borderRadius: BorderRadius.circular(1),
      showBadge: produto.onSale == "true" && produto.active != false ? true : false,
      badgeColor: CustomsColors.customBlueIII,
      badgeContent: Text('SALE', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.white),),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: produto.image,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width*0.35,
                  height: MediaQuery.of(context).size.width*0.35,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: imageProvider
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  width: MediaQuery.of(context).size.width*0.35,
                  height: MediaQuery.of(context).size.width*0.35,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200],
                    highlightColor: Colors.grey[200],
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              errorWidget: (context, url, error) => Container(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.35,
                  height: MediaQuery.of(context).size.width*0.35,
                  child: Text('Imagem\nindisponível', textAlign: TextAlign.center,),
                ),
              )
            ),

            Spacer(),

            Container(
            // padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              alignment: Alignment.center,
              child: Text(
                produto.name,
                maxLines: 2,
                style: TextStyle(color: Colors.black87, fontSize: 16.0), overflow: TextOverflow.visible, textAlign: TextAlign.center,
              ),
            ),

            Divider(color: Colors.transparent, height: 10),

            produto.active == false ? Container(
            // padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              alignment: Alignment.center,
              child: Text(
                "Produto indisponível",
                maxLines: 2,
                style: TextStyle(color: Colors.grey[400], fontSize: 14.0, fontStyle: FontStyle.italic), overflow: TextOverflow.visible, textAlign: TextAlign.center,
              ),
            ) : Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: produto.onSale == "true"? Column(
                children: [
                  Text(produto.regularPrice, style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough)),

                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[

                        TextSpan(text: produto.actualPrice, style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII, fontWeight: FontWeight.bold)),
                        
                        TextSpan(text: ' ' + produto.discountPercentage + ' OFF', style: TextStyle(fontSize: 14.0, color: CustomsColors.customBlueII)),
                              
                      ],
                    ),
                  )
                ],
              ) :RichText(
                text: TextSpan(
                  children: <TextSpan>[

                    TextSpan(text: produto.regularPrice, style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII, fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    
    );
  }

  Widget _listRow(context){
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[

          CachedNetworkImage(
            imageUrl: produto.image,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width*0.25,
                height: MediaQuery.of(context).size.width*0.25,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: imageProvider
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                height: MediaQuery.of(context).size.width*0.25,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ),
            errorWidget: (context, url, error) => Container(
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width*0.25,
                height: MediaQuery.of(context).size.width*0.25,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage('https://source.unsplash.com/200x200/?woman')
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            )
          ),

          Spacer(),

          new Container(
            width: (MediaQuery.of(context).size.width*.75)-30,
            padding: const EdgeInsets.all(15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    produto.name,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black87, fontSize: 16.0), overflow: TextOverflow.ellipsis,
                  ),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(right: 15.0, top: 10.0),
                  child: produto.onSale == "true"?RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: produto.actualPrice, style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII, fontWeight: FontWeight.bold)),
                        
                        TextSpan(text: ' ' + produto.discountPercentage + ' OFF', style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII)),
                      ],
                    ),
                  ):RichText(
                    text: TextSpan(
                      children: <TextSpan>[

                        TextSpan(text: produto.regularPrice, style: TextStyle(fontSize: 16.0, color: CustomsColors.customBlueIII)),

                      ],
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      )
    );
  }

}
