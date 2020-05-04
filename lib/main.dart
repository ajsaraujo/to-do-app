import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/widgets/input_section.dart';
import 'package:todo_list/widgets/to_do_list_view.dart';

import 'controllers/file_controller.dart';
import 'controllers/to_do_controller.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
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

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      ToDoController.sortToDos();
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('To Dos'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
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
