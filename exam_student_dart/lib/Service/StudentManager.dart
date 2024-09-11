import 'dart:convert';
import 'dart:io';
import 'package:exam_student_dart/models/Student.dart';

class StudentManager {
  List<Student> students = [];

  StudentManager();

  // Load data from JSON file
  Future<void> loadStudents() async {
    final file = File('Student.json');
    if (await file.exists()) {
      String contents = await file.readAsString();
      Map<String, dynamic> jsonData = jsonDecode(contents);
      var studentsFromJson = jsonData['students'] as List;
      students = studentsFromJson.map((s) => Student.fromJson(s)).toList();
    } else {
      print("Student.json file not found!");
    }
  }

  // Save data to JSON file
  Future<void> saveStudents() async {
    final file = File('Student.json');
    Map<String, dynamic> jsonData = {
      'students': students.map((s) => s.toJson()).toList(),
    };
    await file.writeAsString(jsonEncode(jsonData));
  }
}

extension StudentManagerOperations on StudentManager {
  
  // 1. Display all students
  void displayStudents() {
    if (students.isEmpty) {
      print("No students found.");
      return;
    }
    for (var student in students) {
      print("ID: ${student.id}, Name: ${student.name}");
      for (var subject in student.subjects) {
        print("  Subject: ${subject.name}, Scores: ${subject.scores}");
      }
    }
  }

  // 2. Add a new student
  void addStudent(int id, String name, List<Subject> subjects) {
    var newStudent = Student(id: id, name: name, subjects: subjects);
    students.add(newStudent);
    print("Student added successfully.");
  }

  // 3. Edit student details by ID
  void editStudent(int id) {
    var student = students.firstWhere((student) => student.id == id, orElse: () => Student(id: -1, name: '', subjects: []));
    if (student.id == -1) {
      print("Student with ID $id not found.");
      return;
    }
    print("Editing student with ID: $id");
    stdout.write("Enter new name (leave blank to keep current): ");
    String newName = stdin.readLineSync()!;
    if (newName.isNotEmpty) {
      student.name = newName;
    }
    print("Student info updated.");
  }

  // 4. Search student by Name or ID
  void searchStudent(String query) {
    var result = students.where((student) => student.name.contains(query) || student.id.toString() == query);
    if (result.isEmpty) {
      print("No students found for '$query'.");
    } else {
      for (var student in result) {
        print("ID: ${student.id}, Name: ${student.name}");
        for (var subject in student.subjects) {
          print("  Subject: ${subject.name}, Scores: ${subject.scores}");
        }
      }
    }
  }
}

