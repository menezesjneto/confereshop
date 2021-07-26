
import 'package:flutter/material.dart';
import 'package:confereshop/resources/app_config.dart';

import 'main.dart';
import 'services/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  var configureApp = AppConfig(
    buildType: 'dev',
    child: materialApp,
    urlServer: '10.100.000.00:443',
  );
  

  return runApp(configureApp);
}