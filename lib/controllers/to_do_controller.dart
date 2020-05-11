import 'file_controller.dart';

class ToDoController {
  static List toDoList = [];
  static Map<String, dynamic> _lastRemovedToDo;
  static int _lastRemovedToDoIndex;

  static String get lastRemovedToDo => _lastRemovedToDo['title'];

  static void addToDo(toDoTitle) {
    Map<String, dynamic> newToDo = Map();

    newToDo['title'] = toDoTitle;
    newToDo['done'] = false;
    
    toDoList.add(newToDo);

    FileController.saveToDosToFile(toDoList);
  }

  static void removeToDo(index) {
    _lastRemovedToDo = Map.from(toDoList[index]);
    _lastRemovedToDoIndex = index;
    toDoList.removeAt(index);

    FileController.saveToDosToFile(toDoList);
  }

  static void restoreLastDeletedToDo() {
    toDoList.insert(_lastRemovedToDoIndex, _lastRemovedToDo);
    FileController.saveToDosToFile(toDoList);
  }

  static void sortToDos() {
    toDoList.sort((toDoA, toDoB) {
      if (toDoA['done'] == toDoB['done']) return 1;
      if (!toDoA['done']) return -1;
      return 1;
    });

    FileController.saveToDosToFile(toDoList);
  }

  static void setToDoValue(index, value) {
    toDoList[index]['done'] = value;
    FileController.saveToDosToFile(toDoList);
  }
}