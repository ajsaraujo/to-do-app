import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileController {
  static Future<File> getToDosFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/tasks.json');
  }

  static Future<File> saveToDosToFile(toDoList) async {
    String data = json.encode(toDoList);
    final file = await getToDosFile();
    return file.writeAsString(data);
  }

  static Future<String> readToDosFromFile() async {
    try {
      final file = await getToDosFile();
      return file.readAsString();
    } catch (err) {
      print(err);
    }
  }
}