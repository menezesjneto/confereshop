import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  
  final String buildType;
  final Widget child;
  final String urlServer;

  AppConfig({
    @required this.buildType,
    @required this.child,
    @required this.urlServer,
  }) : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
