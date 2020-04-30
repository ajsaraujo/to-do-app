import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'controllers/file_controller.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  Map<String, dynamic> _lastRemovedToDo;
  int _lastRemovedToDoIndex;
  final newToDoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    FileController.readToDosFromFile().then((jsonData) {
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

      FileController.saveToDosToFile(_toDoList);
    });
  }

  Future<Null> _sortToDos() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((toDoA, toDoB) {
        if (toDoA['done'] == toDoB['done']) return 0;
        if (!toDoA['done']) return -1;
        return 1;
      });

      FileController.saveToDosToFile(_toDoList);
    });
  }

  Widget _buildItem(context, index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(Icons.delete_forever, color: Colors.white)),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          setState(() {
            _lastRemovedToDo = Map.from(_toDoList[index]);
            _lastRemovedToDoIndex = index;
            _toDoList.removeAt(index);
            FileController.saveToDosToFile(_toDoList);

            final undoSnackBar = SnackBar(
                content: Text('To do "${_lastRemovedToDo['title']}" removed',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blueAccent,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        _toDoList.insert(
                            _lastRemovedToDoIndex, _lastRemovedToDo);
                        FileController.saveToDosToFile(_toDoList);
                      });
                    }));

            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(undoSnackBar);
          });
        },
        child: CheckboxListTile(
            title: Text(_toDoList[index]['title']),
            value: _toDoList[index]['done'],
            secondary: CircleAvatar(
              backgroundColor:
                  _toDoList[index]['done'] ? Colors.blueAccent : Colors.red,
              child: Icon(
                _toDoList[index]['done'] ? Icons.check : Icons.clear,
                color: Colors.white,
              ),
            ),
            onChanged: (done) {
              setState(() {
                _toDoList[index]['done'] = done;
                FileController.saveToDosToFile(_toDoList);
              });
            }));
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
                child: RefreshIndicator(
                    onRefresh: _sortToDos,
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: _toDoList.length,
                        itemBuilder: _buildItem)))
          ],
        ));
  }
}
