import 'dart:convert';

import 'file_controller.dart';

class ToDoController {
  static List _toDoList = [];
  static Map<String, dynamic> _lastRemovedToDo;
  static int _lastRemovedToDoIndex;

  static List get toDoList => _toDoList; 
  
  static void set toDoList(List toDoList) {
    _toDoList = toDoList;
  }

  static String get lastRemovedToDo => _lastRemovedToDo['title'];

  static void addToDo(toDoTitle) {
    Map<String, dynamic> newToDo = Map();

    newToDo['title'] = toDoTitle;
    newToDo['done'] = false;

    _toDoList.add(newToDo);

    FileController.saveToDosToFile(_toDoList);
  }

  static void removeToDo(index) {
    _lastRemovedToDo = Map.from(_toDoList[index]);
    _lastRemovedToDoIndex = index;
    _toDoList.removeAt(index);

    FileController.saveToDosToFile(_toDoList);
  }

  static void restoreLastDeletedToDo() {
    _toDoList.insert(_lastRemovedToDoIndex, _lastRemovedToDo);
    FileController.saveToDosToFile(_toDoList);
  }

  static void sortToDos() {
    _toDoList.sort((toDoA, toDoB) {
      if (toDoA['done'] == toDoB['done']) return 1;
      if (!toDoA['done']) return -1;
      return 1;
    });

    FileController.saveToDosToFile(_toDoList);
  }

  static void setToDoValue(index, value) {
    _toDoList[index]['done'] = value;
    FileController.saveToDosToFile(_toDoList);
  }
}