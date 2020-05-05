import 'package:flutter/material.dart';
import 'package:todo_list/views/home.dart';
import 'package:todo_list/views/settings.dart';
import 'package:todo_list/widgets/my_app_bar.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/settings':
        if (settings.arguments is Function) {
          return MaterialPageRoute(
              builder: (_) =>
                  SettingsPage(changeThemeCallback: settings.arguments));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: MyAppBar(title: 'ERROR'), body: Center(child: Text('ERROR')));
    });
  }
}
