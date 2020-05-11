import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileController {
  static Future<File> getToDosFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/new_tasks.json');
  }

  static Future<File> getColorFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/color.txt');
  }

  static Future<File> saveToDosToFile(toDoList) async {
    String data = json.encode(toDoList);
    final file = await getToDosFile();
    return file.writeAsString(data);
  }

  static Future<File> saveColorToFile(int colorValue) async {
    final file = await getColorFile();
    print('Salvando $colorValue no arquivo...');
    return file.writeAsString(colorValue.toString());
  }

  static Future<int> readColorFromFile() async {
    try {
      final file = await getColorFile();
      final colorAsString = await file.readAsString();
      print('Eu li $colorAsString do arquivo');
      return int.parse(colorAsString);
    } catch (err) {
      print(err);
      return 0xFFFFFFF;
    }
  }

  static Future<String> readToDosFromFile() async {
    try {
      final file = await getToDosFile();
      return file.readAsString();
    } catch (err) {
      print(err);
      return '{}';
    }
  }
}