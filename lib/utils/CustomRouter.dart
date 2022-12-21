import 'package:seat/screens/home.dart';
import 'package:seat/utils/CommonUtils.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static getRoutes() {
    return <String, WidgetBuilder>{
      Home.routeName: (_) => Home(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return getMaterialRoute(settings.name);
  }

  static MaterialPageRoute<dynamic> getMaterialRoute(String? routeName) {
    if (CommonUtils.checkIfNotNull(routeName)) {
      switch (routeName) {
        case Home.routeName:
          return MaterialPageRoute(builder: (_) => Home());
        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(child: Text('No route defined for ${routeName}')),
                  ));
      }
    } else {
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${routeName}')),
              ));
    }
  }
}
