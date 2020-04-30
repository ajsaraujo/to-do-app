import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List _toDoList = [];
  final newToDoController = TextEditingController();

  @override 
  void initState() {
    super.initState();
    
    _readToDosFromFile().then((jsonData) {
      setState(() {
        _toDoList = json.decode(jsonData);
      });
    });
  }
  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();

      newToDo['title'] = newToDoController.text;
      newToDo['done'] = false;

      _toDoList.add(newToDo);

      newToDoController.clear();

      _saveToDosToFile();
    });
  }

  Future<File> _getToDosFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/tasks.json');
  }

  Future<File> _saveToDosToFile() async {
    String data = json.encode(_toDoList);
    final file = await _getToDosFile();
    return file.writeAsString(data);
  }

  Future<String> _readToDosFromFile() async {
    try {
      final file = await _getToDosFile();
      return file.readAsString();
    } catch (err) {
      print(err);
    }
  }

  Widget _buildItem(context, index) {
    return CheckboxListTile(
      title: Text(_toDoList[index]['title']),
      value: _toDoList[index]['done'],
      secondary: CircleAvatar(
        backgroundColor: _toDoList[index]['done'] ? Colors.blueAccent : Colors.red,
        child: Icon(
          _toDoList[index]['done'] ? Icons.check : Icons.clear,
          color: Colors.white,
        ),
      ),
      onChanged: (done) {
        setState(() {
          _toDoList[index]['done'] = done;
          _saveToDosToFile();
        });
      }
    );
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: newToDoController,
                      decoration: InputDecoration(
                        labelText: 'New To Do',
                        labelStyle: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Text('ADD'),
                    textColor: Colors.white,
                    onPressed: _addToDo,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: _buildItem
             ) )
          ],
        ));
  }
}
