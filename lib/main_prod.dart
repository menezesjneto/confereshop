import 'package:confereshop/resources/app_config.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'services/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  var configureApp = AppConfig(
    buildType: 'prod',
    child: materialApp,
    urlServer: '111.111.111.11:8080',
  );
  
  return runApp(configureApp);
}