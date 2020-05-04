import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/widgets/input_section.dart';

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
            ToDoController.removeToDo(index);

            final undoSnackBar = SnackBar(
                content: Text('To do "${ToDoController.lastRemovedToDo}" removed',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blueAccent,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        ToDoController.restoreLastDeletedToDo();
                      });
                    }));

            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(undoSnackBar);
          });
        },
        child: CheckboxListTile(
            title: Text(ToDoController.toDoList[index]['title']),
            value: ToDoController.toDoList[index]['done'],
            onChanged: (done) {
              setState(() {
                ToDoController.setToDoValue(index, done);
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
              child: InputSection((String newToDoTitle) {
                setState(() {
                  ToDoController.addToDo(newToDoTitle);
                });
              }),
            ),
            Expanded(
                child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: ToDoController.toDoList.length,
                        itemBuilder: _buildItem)))
          ],
        ));
  }
}
