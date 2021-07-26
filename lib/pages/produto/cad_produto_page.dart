import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:confereshop/bloc/product_bloc.dart';
import 'package:confereshop/models/product_model.dart';
import 'package:confereshop/models/size_model.dart';
import 'package:confereshop/providers/product_provider.dart';
import 'package:confereshop/widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:confereshop/widgets/custom_input.dart';
import 'package:confereshop/widgets/theme.dart';


class CadProdutoPage extends StatefulWidget {
  
  ProductModel produto;
  bool isOff;
  CadProdutoPage({Key key, this.produto, this.isOff}) : super(key: key);

  @override
  _CadProdutoPageState createState() => new _CadProdutoPageState();
}

class _CadProdutoPageState extends State<CadProdutoPage> with SingleTickerProviderStateMixin {
  
  final ProductBloc productBloc = BlocProvider.getBloc<ProductBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = new TextEditingController();
  TextEditingController percentualController = new TextEditingController();
  var precoController = MoneyMaskedTextController(leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');
  var precoPromocionalController = MoneyMaskedTextController(leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');

  final FocusNode _nomeFocus = FocusNode();
  final FocusNode _precoFocus = FocusNode();
  final FocusNode _precoPromocionalFocus = FocusNode();
  final FocusNode _percentualFocus = FocusNode();

  bool sending = false;

  bool enableButton = false;

  @override
  void initState() {
    super.initState();

    ProductModel product = new ProductModel(
      actualPrice: '',
      codeColor: '',
      codeSlug: '',
      color: '',
      discountPercentage: '',
      image: 'https://source.unsplash.com/200x200/?dress',
      installments: '',
      isMyProduct: true,
      name: '',
      onSale: '',
      regularPrice: '',
      sizes: [
        new SizeModel(
          available: true,
          size: 'P',
          sku: '28AJMSKKAMM'
        )
      ],
      style: '',
      id: DateTime.now().millisecondsSinceEpoch,
      active: true
    );

    if(widget.produto != null) {
      product = ProductModel.clone(widget.produto);
      
      nomeController.text = product.name;
      precoController.text = product.regularPrice;
      precoPromocionalController.text = product.actualPrice;
      percentualController.text = product.discountPercentage;

    }

    productBloc.sinkProduct.add(product);


  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductModel>(
        initialData: null,
        stream: productBloc.streamProduct,
        builder: (BuildContext context, snap) {

          var product = snap.data;

          if(snap.hasData){
            
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                centerTitle: true,
                title: Text(widget.produto == null ? 'Novo Produto' : 'Editar Produto', style: TextStyle(color: Colors.white)),
                backgroundColor: CustomsColors.customBlueI,
                actions: widget.produto == null ? [] : [
                  IconButton(
                    padding: EdgeInsets.only(right: 10.0),
                    icon: Icon(Icons.delete, size: 25.0),
                    onPressed: () {
                      _showDialogDeletar(context, product);
                    },
                  ),
                ],
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              backgroundColor: Colors.grey[00],
              body: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: CustomScrollView(slivers: <Widget>[
                        SliverList(delegate: SliverChildListDelegate([

                          //NOME
                          CustomInput.getInputLabel('*Nome'),
                          Container(
                            decoration: CustomInput.decorationCircular(),
                            child: TextFormField(
                              controller: nomeController,
                              style: TextStyle(color: Colors.black, fontSize: 18.0),
                              decoration: CustomInput.inputDecorationI('Nome', showError: true),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              focusNode: _nomeFocus,
                              minLines: 1,
                              maxLines: 2,
                              validator: (text) {
                                if(text.length < 4) return "Insira o nome do produto";
                                return null;
                              },
                              onFieldSubmitted: (term) {
                                _nomeFocus.unfocus();
                                FocusScope.of(context).requestFocus(_precoFocus);
                              },
                              onChanged: (val) => product.name = val
                            ),
                          ),
                          
                          //PRECO
                          CustomInput.getInputLabel(r'*Preço (R$)'),
                          Container(
                            decoration: CustomInput.decorationCircular(),
                            child: TextFormField(
                              controller: precoController,
                              style: TextStyle(color: Colors.black, fontSize: 18.0),
                              decoration: CustomInput.inputDecorationI(r'Preço (R$)', showError: true),
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              focusNode: _precoFocus,
                              validator: (text) {
                                if(precoController.numberValue <= 0) return "Insira o preço do produto";
                                return null;
                              },
                              onFieldSubmitted: (term) {
                                _precoFocus.unfocus();
                                FocusScope.of(context).requestFocus(_precoPromocionalFocus);
                              },
                              onChanged: (val) => product.regularPrice = precoController.text
                              
                            ),
                          ),

                          //PRECO PROMOCIONAL
                          CustomInput.getInputLabel(r'*Preço promocional (R$)'),
                          Container(
                            decoration: CustomInput.decorationCircular(),
                            child: TextFormField(
                              controller: precoPromocionalController,
                              style: TextStyle(color: Colors.black, fontSize: 18.0),
                              decoration: CustomInput.inputDecorationI(r'Preço promocional (R$)', showError: true),
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              focusNode: _precoPromocionalFocus,
                              validator: (text) {
                                if(precoController.numberValue <= 0) return "Insira o preço promocional do produto";
                                return null;
                              },
                              onFieldSubmitted: (term) {
                                _precoPromocionalFocus.unfocus();
                                FocusScope.of(context).requestFocus(_percentualFocus);
                              },
                              onChanged: (val) => product.actualPrice = precoPromocionalController.text
                            ),
                          ),

                          //DESCONTO
                          CustomInput.getInputLabel(r'*Percentual de desconto (%)'),
                          Container(
                            decoration: CustomInput.decorationCircular(),
                            child: TextFormField(
                              controller: percentualController,
                              style: TextStyle(color: Colors.black, fontSize: 18.0),
                              decoration: CustomInput.inputDecorationI(r'Percentual de desconto (%)', showError: true),
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              focusNode: _percentualFocus,
                              validator: (text) {
                                if(precoController.numberValue <= 0) return "Insira o percentual de desconto";
                                return null;
                              },
                              onFieldSubmitted: (term) {
                                _percentualFocus.unfocus();
                                FocusScope.of(context).requestFocus(_precoPromocionalFocus);
                              },
                              onChanged: (val) {
                                val = val.replaceAll("%", "").replaceAll(" ", "");
                                if(val[0] != "0"){
                                  product.discountPercentage = val + r' %';
                                  product.onSale = 'true';
                                }else{
                                  product.discountPercentage = "";
                                }
                              }
                            ),
                          ),

                          CustomInput.getInputLabel('Disponível para venda'),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: createRadioList(product),
                            ),
                          ),


                        ]))
                      ])
                    )
                  )
                )
              ),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 35, 20, 35),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: new TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(CustomsColors.customBlueI),
                      overlayColor: MaterialStateProperty.all(CustomsColors.customBlueIII),
                    ),
                    child: sending ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)) : Text(widget.produto == null ? 'CADASTRAR' : 'SALVAR', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    onPressed: sending || enableButton ? null : () async {
                      final form = _formKey.currentState;
                      
                      if (form.validate()) {
                        if(widget.produto == null) _criar(product);
                        else _editar(product);
                      }
                    },
                  )
                ),
              ),
            );

          } else return Container();
      }
    );
  }
  

  void _criar(product) {
    setState(() {
      sending = true;
      enableButton = true;
    });

    ProductProvider.addOff(product).then((value){
      setState(() {
        sending = false;
      });
      CustomWidgets.showSnackBarSuccess(_scaffoldKey, "Produto adicionado com sucesso!");
      Future.delayed(Duration(milliseconds: 1200)).then((value){
        
        Navigator.pop(context, 'reload');
      });
    });

  }

  void _editar(product) {
    setState(() {
      sending = true;
      enableButton = true;
    });

    ProductProvider.editOff(product).then((value){
      setState(() {
        sending = false;
      });
      CustomWidgets.showSnackBarSuccess(_scaffoldKey, "Produto editado com sucesso!");
      Future.delayed(Duration(milliseconds: 1200)).then((value){
        
        Navigator.pop(context, product);
      });
    });
  }

  void _deletar(product) {
    setState(() {
      sending = true;
      enableButton = true;
    });

    ProductProvider.removeOff(product.id).then((value){
      setState(() {
        sending = false;
      });
      CustomWidgets.showSnackBarSuccess(_scaffoldKey, "Produto removido com sucesso!");
      Future.delayed(Duration(milliseconds: 1200)).then((value){
        
        Navigator.pop(context, 'reload2');
      });
    });
  }


  List<Widget> createRadioList(product){
    List<Widget> widgets = [];
    for (var item in ['Sim', 'Não']) {
      widgets.add(
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.4,
          child: RadioListTile(
            value: item,
            groupValue: product.active ?  'Sim' : 'Não',
            activeColor: CustomsColors.customBlueI,
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Text(
              item,
              style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
            ),
            onChanged: (value){
              setState(() {
                product.active = !product.active;
              });
            },
            selected: item == 'Sim',
          ),
        )
      );
    }
    return widgets;
  }

  void _showDialogDeletar(context,product) {
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
                Navigator.of(ctx).pop();

                _deletar(product);

                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

}
