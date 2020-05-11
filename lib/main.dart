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

  void changeTheme({Color newPrimaryColor}) async {
    setState(() {
      _primaryColor = newPrimaryColor ?? _primaryColor;
    });
    await FileController.saveColorToFile(_primaryColor.value);
  }

  Future<void> _loadColorFromFile() async {
      final colorValue = await FileController.readColorFromFile();
      _primaryColor =
          colorValue == 0xFFFFFFFF ? Colors.blue : Color(colorValue);
  }

  @override
  Widget build(BuildContext context) {
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
          } else {
            return MaterialApp(
                home:
                    Scaffold(body: Center(child: CircularProgressIndicator())));
          }
        });
  }
}
