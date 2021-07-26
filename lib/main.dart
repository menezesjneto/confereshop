import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:confereshop/bloc/main_bloc.dart';
import 'package:confereshop/bloc/product_bloc.dart';
import 'package:confereshop/pages/not_found_page.dart';
import 'package:confereshop/routes/routes.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final materialApp = BlocProvider(
  blocs: [
    Bloc((i) => MainBloc()),
    Bloc((i) => ProductBloc()),
  ],
  child: MaterialApp(
  title: "Confere Shop",
  theme: ThemeData(
    primarySwatch: CustomsColors.customBlueI,
    primaryColor: Colors.white,
    textSelectionColor: Colors.grey[400],
  ),
  debugShowCheckedModeBanner: false,
  localizationsDelegates: [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  routes: routesApp,
  builder: (context, child) {
    return MediaQuery(
      child: child,
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    );
  })
);

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    default:
      return MaterialPageRoute(builder: (context) => NotFoundPage());
  }
}
