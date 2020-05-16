import 'file_controller.dart';

class ToDoController {
  List toDoList = [];
  Map<String, dynamic> _lastRemovedToDo;
  int _lastRemovedToDoIndex;

  // Singleton implementation below. 
  static final ToDoController _singleton = ToDoController._internal();

  factory ToDoController() {
    return _singleton;
  }

  ToDoController._internal();

  // Class methods.
  String lastRemovedToDoTitle() {
    print('Vou mostrar ${_lastRemovedToDo['title']}');
    return _lastRemovedToDo['title'];
  }

  void addToDo(toDoTitle) {
    Map<String, dynamic> newToDo = Map();

    newToDo['title'] = toDoTitle;
    newToDo['done'] = false;
    
    toDoList.add(newToDo);

    FileController.saveToDosToFile(toDoList);
  }

  void removeToDo(index) {
    _lastRemovedToDo = Map.from(toDoList[index]);
    _lastRemovedToDoIndex = index;
    toDoList.removeAt(index);

    FileController.saveToDosToFile(toDoList);
  }

  void restoreLastDeletedToDo() {
    toDoList.insert(_lastRemovedToDoIndex, _lastRemovedToDo);
    FileController.saveToDosToFile(toDoList);
  }

  void sortToDos() {
    toDoList.sort((toDoA, toDoB) {
      if (toDoA['done'] == toDoB['done']) return 1;
      if (!toDoA['done']) return -1;
      return 1;
    });

    FileController.saveToDosToFile(toDoList);
  }

  void setToDoValue(index, booleanValue) {
    toDoList[index]['done'] = booleanValue;
    FileController.saveToDosToFile(toDoList);
  }

  void setToDoTitle(index, newTitle) {
    toDoList[index]['title'] = newTitle;
    FileController.saveToDosToFile(toDoList);
  }
}