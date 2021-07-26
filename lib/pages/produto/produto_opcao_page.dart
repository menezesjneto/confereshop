import 'package:cached_network_image/cached_network_image.dart';
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/pages/produto/cad_produto_page.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProdutoOpcaoPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ProductModel product;
  const ProdutoOpcaoPage(this.scaffoldKey, {Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.white, Colors.white, Colors.white, CustomsColors.customBlueI, CustomsColors.customBlueII]
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.0,
            child: 
            CachedNetworkImage(
              imageUrl: product.image,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: imageProvider
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  width: 200,
                  height: 200,
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
                  width: 200,
                  height: 200,
                  child: Text('Imagem\nindisponível', textAlign: TextAlign.center, style: TextStyle(color: CustomsColors.customBlueI),),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}