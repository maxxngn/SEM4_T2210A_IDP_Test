import 'dart:convert';
import 'dart:io';
import '../models/student.dart';

class StudentService {
  List<Student> students = [];

  StudentService() {
    loadStudents();
  }

  void loadStudents() {
    final file = File('data/student.json');
    final data = json.decode(file.readAsStringSync());
    students = List<Student>.from(data['students'].map((stu) => Student.fromJson(stu)));
  }

  void saveStudents() {
    final file = File('data/student.json');
    final data = json.encode({'students': students.map((stu) => stu.toJson()).toList()});
    file.writeAsStringSync(data);
  }

  void displayStudents() {
    for (var student in students) {
      print('ID: ${student.id}, Name: ${student.name}');
      for (var subject in student.subjects) {
        print('  Subject: ${subject.name}, Scores: ${subject.scores}');
      }
    }
  }

  void addStudent(Student student) {
    students.add(student);
    saveStudents();
  }

  void updateStudent(int id, {String? name, List<Subject>? subjects}) {
    final student = students.firstWhere((stu) => stu.id == id, orElse: () => throw Exception('Student not found'));
    if (name != null) student.name = name;
    if (subjects != null) student.subjects = subjects;
    saveStudents();
  }

Student? searchStudentById(int id) {
  try {
    return students.firstWhere((stu) => stu.id == id);
  } catch (e) {
    return null;
  }
}


  List<Student> searchStudentByName(String name) {
    return students.where((stu) => stu.name.toLowerCase().contains(name.toLowerCase())).toList();
  }
}
