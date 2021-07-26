import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter/material.dart';

class SizesListPage extends StatefulWidget {
  final ProductModel product;

  SizesListPage(this.product, {Key key}) : super(key: key);

  @override
  _SizesListPageState createState() => _SizesListPageState();
}

class _SizesListPageState extends State<SizesListPage> {
  int active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Tamanhos disponíveis',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.product.sizes.length,

              /// list of button colors based on SizesListPage
              itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      setState(() {
                        ///sets the color pressed to be the active one
                        active = index;
                      });
                    },
                    child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Transform.scale(
                        scale: active == index ? 1.5 : 1,
                        child: Text(widget.product.sizes[index].size, 
                          style: TextStyle(color: active == index ? CustomsColors.customBlueIII : Colors.white, fontWeight: active == index ? FontWeight.bold : FontWeight.w400)),
                      ),
                      decoration: BoxDecoration(
                        color: active == index ? Colors.white38 : Colors.transparent,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}