import 'package:flutter/material.dart';
import 'package:todo_list/controllers/to_do_controller.dart';

class ToDoTile extends StatefulWidget {
  final int index;
  final String title;
  bool done;
  final Function callback;

  ToDoTile({this.index, this.title, this.done, this.callback});

  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  String _textEditingBuffer;
  final toDos = ToDoController();

  void _loadChangesToBuffer(String newValue) {
    _textEditingBuffer = newValue;
  }

  void _saveChanges() {
    toDos.setToDoTitle(this.widget.index, _textEditingBuffer);
  }

  void _toggleToDoIsDone(bool isDone) {
    setState(() {
      this.widget.done = isDone;
    });
    toDos.setToDoValue(this.widget.index, isDone);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: TextFormField(
          textInputAction: TextInputAction.done,
          maxLines: null,
          initialValue: this.widget.title,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: _loadChangesToBuffer,
          onEditingComplete: _saveChanges,
        ),
        value: this.widget.done,
        checkColor: Theme.of(context).accentColor,
        activeColor: Theme.of(context).primaryColor,
        onChanged: _toggleToDoIsDone);
  }
}
