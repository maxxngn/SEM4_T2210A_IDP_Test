import 'dart:convert';
import 'dart:io';
import '../models/student.dart';

class StudentService {
  List<Student> students = [];

  StudentService() {
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    try {
      final file = File('lib/student.json');
      if (!await file.exists()) {
        print('File not found.');
        return;
      }
      final content = await file.readAsString();
      final jsonData = jsonDecode(content);
      students = (jsonData['students'] as List)
          .map((studentJson) => Student.fromJson(studentJson))
          .toList();
    } catch (e) {
      print('Error loading students: $e');
    }
  }

  void displayStudents() {
    if (students.isEmpty) {
      print('No students available.');
      return;
    }
    for (var student in students) {
      print('ID: ${student.id}');
      print('Name: ${student.name}');
      for (var subject in student.subjects) {
        print('  Subject: ${subject.name}');
        print('  Scores: ${subject.scores.join(', ')}');
      }
      print('---');
    }
  }

  void addStudent(Student student) {
    students.add(student);
    _saveStudents();
  }

  void updateStudent(int id, Map<String, dynamic> updatedData) {
    for (var student in students) {
      if (student.id == id) {
        student.update(updatedData);
        _saveStudents();
        return;
      }
    }
    print('Student with ID $id not found.');
  }

  void searchStudent(String query) {
    final results = students.where((student) {
      return student.name.contains(query) || student.id.toString() == query;
    }).toList();

    if (results.isEmpty) {
      print('No students found.');
    } else {
      for (var student in results) {
        print('ID: ${student.id}');
        print('Name: ${student.name}');
        for (var subject in student.subjects) {
          print('  Subject: ${subject.name}');
          print('  Scores: ${subject.scores.join(', ')}');
        }
        print('---');
      }
    }
  }

  Future<void> _saveStudents() async {
    try {
      final file = File('lib/student.json');
      final jsonData = jsonEncode({'students': students.map((student) => student.toJson()).toList()});
      await file.writeAsString(jsonData);
    } catch (e) {
      print('Error saving students: $e');
    }
  }
}
