import 'package:flutter/material.dart';
import 'package:todo_list/controllers/to_do_controller.dart';

class ToDoListView extends StatefulWidget {
  @override
  ToDoListViewState createState() => ToDoListViewState();
}

class ToDoListViewState extends State<ToDoListView> {
  final toDos = ToDoController();

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      toDos.sortToDos();
    });
  }

  Widget _buildItem(context, index) {
    String _textEditingBuffer = toDos.toDoList[index]['title'];
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
            toDos.removeToDo(index);

            final undoSnackBar = SnackBar(
                content: Text('To do "${toDos.lastRemovedToDoTitle()}" removed',
                    style: TextStyle(color: Theme.of(context).accentColor)),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                    textColor: Theme.of(context).accentColor,
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        toDos.restoreLastDeletedToDo();
                      });
                    }));

            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(undoSnackBar);
          });
        },
        child: CheckboxListTile(
            title: TextFormField(
              initialValue: toDos.toDoList[index]['title'],
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                _textEditingBuffer = value;
              },
              onEditingComplete: () {
                toDos.setToDoTitle(index, _textEditingBuffer);
              },
            ),
            value: toDos.toDoList[index]['done'],
            checkColor: Theme.of(context).accentColor,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (done) {
              setState(() {
                toDos.setToDoValue(index, done);
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: toDos.toDoList.length,
                itemBuilder: _buildItem)));
  }
}
