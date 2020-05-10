import 'package:flutter/material.dart';
import 'package:todo_list/controllers/file_controller.dart';
import 'package:todo_list/route_generator.dart';
import 'package:todo_list/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _primaryColor;
  Color _accentColor;
  Brightness _brightness;

  void changeTheme(
      {Color newPrimaryColor, Color newAccentColor, Brightness newBrightness}) {
    setState(() async {
      print('Oi, tô no callback!');
      _primaryColor = newPrimaryColor ?? _primaryColor;
      _accentColor = newAccentColor ?? _accentColor;
      _brightness = newBrightness ?? _brightness;

      await FileController.saveColorToFile(_primaryColor.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _loadColorFromFile() async {
      final colorValue = await FileController.readColorFromFile();
      _primaryColor =
          colorValue == 0xFFFFFFFF ? Colors.blue : Color(colorValue);
    }

    return FutureBuilder(
        future: _loadColorFromFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Home(changeThemeCallback: changeTheme),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: ThemeData(
                primaryColor: _primaryColor ?? Colors.blue,
                accentColor: Colors.white,
                brightness: Brightness.light,
              ),
            );
          }
          else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator()
                )
              )
            );
          }
        });
  }
}
