import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controllers/file_controller.dart';
import 'package:todo_list/controllers/to_do_controller.dart';
import 'package:todo_list/widgets/input_section.dart';
import 'package:todo_list/widgets/my_app_bar.dart';
import 'package:todo_list/widgets/to_do_list_view.dart';

class Home extends StatefulWidget {
  final Function changeThemeCallback;

  Home({this.changeThemeCallback});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    FileController.readToDosFromFile().then((jsonData) {
      setState(() {
        ToDoController.toDoList = json.decode(jsonData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'To dos',
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings',
                      arguments: this.widget.changeThemeCallback);
                })
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: InputSection((String newToDoTitle) {
                setState(() {
                  ToDoController.addToDo(newToDoTitle);
                });
              }),
            ),
            ToDoListView(),
          ],
        ));
  }
}
