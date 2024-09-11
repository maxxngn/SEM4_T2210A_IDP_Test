
import 'dart:convert';
import 'dart:io';
import 'student.dart';
import 'subject.dart';

class StudentService {
  final String filePath;

  StudentService(this.filePath);

  List<Student> readStudents() {
    final file = File(filePath);
    if (!file.existsSync()) {
      return [];
    }
    final contents = file.readAsStringSync();
    final Map<String, dynamic> jsonData = jsonDecode(contents);
    return (jsonData['students'] as List)
        .map((json) => Student.fromJson(json))
        .toList();
  }

  void writeStudents(List<Student> students) {
    final file = File(filePath);
    final jsonData = {
      'students': students.map((student) => student.toJson()).toList(),
    };
    file.writeAsStringSync(jsonEncode(jsonData));
  }


  void displayAllStudents(List<Student> students) {
    for (var student in students) {
      print('ID: ${student.id}, Name: ${student.name}');
      for (var subject in student.subjects) {
        print('  Subject: ${subject.name}, Scores: ${subject.scores}');
      }
    }
  }


  void addStudent(List<Student> students, Student newStudent) {
    students.add(newStudent);
    writeStudents(students);
    print('Student added: ${newStudent.name}');
  }


  void editStudent(List<Student> students, int id, String newName) {
    final student = students.firstWhere((student) => student.id == id, );
    if (student != null) {
      student.name = newName;
      writeStudents(students);
      print('Student updated: ${student.name}');
    } else {
      print('Student not found!');
    }
  }
}
