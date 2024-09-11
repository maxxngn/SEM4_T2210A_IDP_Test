import 'dart:io';

import 'package:dart_application_2/management.dart';

void main() async {
  while (true) {
    print('Student Management System');
    print('1. Display all students');
    print('2. Add a student');
    print('3. Update a student');
    print('4. Search for a student');
    print('5. Exit');
    print('Choose an option:');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        final students = await loadStudents();
        displayStudents(students);
        break;
      case '2':
        await addStudent();
        break;
      case '3':
        await updateStudent();
        break;
      case '4':
        await searchStudent();
        break;
      case '5':
        exit(0);
      default:
        print('Invalid choice. Try again.');
    }
  }
}