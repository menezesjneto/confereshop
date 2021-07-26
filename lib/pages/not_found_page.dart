import 'package:flutter/material.dart';
import 'package:confereshop/widgets/appbar.dart';
import 'package:confereshop/widgets/theme.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBack(context, "Erro"),
      body: Center(
        child: Text('Pagina não encontrada!',
          style: TextStyle(fontSize: 22, color: CustomsColors.customBlueIII),
        ),
      ),
    );
  }
}
