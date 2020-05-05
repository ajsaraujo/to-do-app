import 'package:flutter/material.dart';
import 'package:todo_list/route_generator.dart';
import 'package:todo_list/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorSwatch _primaryColor;
  Color _accentColor;
  Brightness _brightness; 

  void changeTheme({ColorSwatch newPrimaryColor, Color newAccentColor, Brightness newBrightness}) {
    setState(() {
      print('Oi, tô no callback!');
      _primaryColor = newPrimaryColor ?? _primaryColor;
      _accentColor = newAccentColor ?? _accentColor;
      _brightness = newBrightness ?? _brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(changeThemeCallback: changeTheme),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: _primaryColor ?? Colors.blue,
        accentColor: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }
}