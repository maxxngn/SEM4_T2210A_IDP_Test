import 'dart:io';
import 'dart:convert';
import 'package:flutter_demo/models/Student.dart';


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

getApplicationDocumentsDirectory() {
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/Student.json');
}

Future<List<Student>> readStudents() async {
  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);
    return jsonData.map((json) => Student.fromJson(json)).toList();
  } catch (e) {
    return [];
  }
}

// ignore: avoid_types_as_parameter_names
Future<File> writeStudents(List<Student>> students) async {
  final file = await _localFile;
  final jsonData = students.map((student) => student.toJson()).toList();
  return file.writeAsString(json.encode(jsonData));
}