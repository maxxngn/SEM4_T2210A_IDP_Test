import 'package:student_manage/student_management.dart' as student_manage;
import 'dart:io';
import '../lib/models/student.dart';
import '../lib/services/student_service.dart';

void main() {
  final studentService = StudentService();

  while (true) {
   print('\nChoose a function:');
print('1. Display all students');
print('2. Add a student');
print('3. Edit student information');
print('4. Search for a student by Name or ID');
print('5. Exit');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        studentService.displayStudents();
        break;
      case '2':
        addNewStudent(studentService);
        break;
      case '3':
        editStudentInfo(studentService);
        break;
      case '4':
        searchStudent(studentService);
        break;
      case '5':
        exit(0);
      default:
        print('Not Match.');
    }
  }
}

void addNewStudent(StudentService service) {
  print('Student Id:');
  int id = int.parse(stdin.readLineSync()!);

  print('Student Name:');
  String name = stdin.readLineSync()!;

  List<Subject> subjects = [];
  while (true) {
    print('Subject Name:');
    String subjectName = stdin.readLineSync()!;
    if (subjectName.toLowerCase() == 'x') break;

    print('Exam score:');
    List<int> scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
    subjects.add(Subject(name: subjectName, scores: scores));
  }

  service.addStudent(Student(id: id, name: name, subjects: subjects));
  print('Add Student');
}

void editStudentInfo(StudentService service) {
  print('Student ID for edit:');
  int id = int.parse(stdin.readLineSync()!);

  print('New Name):');
  String? newName = stdin.readLineSync();
  if (newName!.isEmpty) newName = null;

  print('Do you wanna edit? (y/n)');
  if (stdin.readLineSync()!.toLowerCase() == 'y') {
    List<Subject> subjects = [];
    while (true) {
      print('Subject Name:');
      String subjectName = stdin.readLineSync()!;
      if (subjectName.toLowerCase() == 'x') break;

      print('Score:');
      List<int> scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
      subjects.add(Subject(name: subjectName, scores: scores));
    }
    service.updateStudent(id, name: newName, subjects: subjects);
  } else {
    service.updateStudent(id, name: newName);
  }

  print('Edit has Done.');
}

void searchStudent(StudentService service) {
  print('Id or Name:');
  String query = stdin.readLineSync()!;

  if (int.tryParse(query) != null) {
    var student = service.searchStudentById(int.parse(query));
    if (student != null) {
      print('Student has found: ${student.name}');
    } else {
      print('Student has not found.');
    }
  } else {
    var students = service.searchStudentByName(query);
    if (students.isNotEmpty) {
      for (var student in students) {
        print('ID: ${student.id}, Name: ${student.name}');
      }
    } else {
      print('Student Has not found.');
    }
  }
}
