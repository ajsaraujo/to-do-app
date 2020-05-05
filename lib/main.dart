import 'package:flutter/material.dart';
import 'package:todo_list/route_generator.dart';
import 'package:todo_list/views/home.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
