import 'package:confereshop/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:confereshop/pages/intro/intro_page.dart';
import 'package:confereshop/pages/tab_page.dart';
import '../pages/home_page.dart';

final routesApp = {
  '/': (BuildContext context) => new SplashPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/intro': (BuildContext context) => new IntroPage(),
  '/tab': (BuildContext context) => new TabPage(),
};
