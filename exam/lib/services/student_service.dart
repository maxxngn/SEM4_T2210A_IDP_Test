import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '/models/student.dart';
import 'package:flutter/services.dart' show rootBundle;

class StudentService {
  static const String fileName = 'assets/students.json';

Future<File> _getLocalFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/$fileName');
}

Future<List<Student>> loadStudents() async {
    try {
      final contents = await rootBundle.loadString(fileName);
      final Map<String, dynamic> jsonData = jsonDecode(contents);
      final List<dynamic> studentsJson = jsonData['students'];
      return studentsJson.map((json) => Student.fromJson(json)).toList();
    } catch (e) {
      print("Error reading file: $e");
    }
    return [];
  }

  Future<void> saveStudents(List<Student> students) async {
    final file = await _getLocalFile();
    final jsonString = jsonEncode(students.map((s) => s.toJson()).toList());
    await file.writeAsString(jsonString);
  }
}
