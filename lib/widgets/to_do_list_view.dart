import 'package:flutter/material.dart';
import 'package:todo_list/controllers/to_do_controller.dart';

class ToDoListView extends StatefulWidget {
  Function onRefresh;
  Function buildItem;

  ToDoListView({this.onRefresh, this.buildItem});

  @override
  ToDoListViewState createState() => ToDoListViewState();
}

class ToDoListViewState extends State<ToDoListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
            onRefresh: this.widget.onRefresh,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: ToDoController.toDoList.length,
                itemBuilder: this.widget.buildItem)));
  }
}
