import 'dart:io';
import 'package:exam_student_dart/Service/StudentManager.dart';
import 'package:exam_student_dart/models/Student.dart';



void main() async {
  var studentManager = StudentManager();
  await studentManager.loadStudents();

  while (true) {
    print("\n--- Student Management Menu ---");
    print("1. Display all students");
    print("2. Add a new student");
    print("3. Edit a student");
    print("4. Search student by Name or ID");
    print("5. Exit");

    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        studentManager.displayStudents();
        break;
      case '2':
        stdout.write("Enter student ID: ");
        int id = int.parse(stdin.readLineSync()!);
        stdout.write("Enter student name: ");
        String name = stdin.readLineSync()!;
        // Add subjects and scores
        var subjects = <Subject>[];
        bool addingSubjects = true;
        while (addingSubjects) {
          stdout.write("Enter subject name: ");
          String subjectName = stdin.readLineSync()!;
          stdout.write("Enter scores (comma-separated): ");
          List<int> scores = stdin
              .readLineSync()!
              .split(',')
              .map((score) => int.parse(score.trim()))
              .toList();
          subjects.add(Subject(name: subjectName, scores: scores));

          stdout.write("Add another subject? (y/n): ");
          addingSubjects = stdin.readLineSync()?.toLowerCase() == 'y';
        }
        studentManager.addStudent(id, name, subjects);
        await studentManager.saveStudents();
        break;
      case '3':
        stdout.write("Enter student ID to edit: ");
        int id = int.parse(stdin.readLineSync()!);
        studentManager.editStudent(id);
        await studentManager.saveStudents();
        break;
      case '4':
        stdout.write("Enter Name or ID to search: ");
        String query = stdin.readLineSync()!;
        studentManager.searchStudent(query);
        break;
      case '5':
        print("Exiting...");
        return;
      default:
        print("Invalid option. Please try again.");
    }
  }
}
