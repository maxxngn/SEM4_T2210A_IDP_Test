import 'dart:io';
import '../lib/services/student_service.dart';
import '../lib/models/student.dart';

void main(List<String> arguments) async {
  final studentService = StudentService();

  while (true) {
    print('1. Display Students');
    print('2. Add Student');
    print('3. Update Student');
    print('4. Search Student');
    print('5. Exit');
    stdout.write('Choose an option: ');
    final choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        studentService.displayStudents();
        break;
      case 2:
        stdout.write('Enter student ID: ');
        final id = int.parse(stdin.readLineSync()!);
        stdout.write('Enter student name: ');
        final name = stdin.readLineSync()!;
        stdout.write('Enter subjects (comma-separated): ');
        final subjectsInput = stdin.readLineSync()!;
        final subjects = subjectsInput.split(',').map((subject) {
          stdout.write('Enter scores for $subject (comma-separated): ');
          final scoresInput = stdin.readLineSync()!;
          final scores = scoresInput.split(',').map(int.parse).toList();
          return Subject(name: subject.trim(), scores: scores);
        }).toList();
        studentService.addStudent(Student(id: id, name: name, subjects: subjects));
        break;
      case 3:
        stdout.write('Enter student ID to update: ');
        final id = int.parse(stdin.readLineSync()!);
        final updatedData = <String, dynamic>{};

        stdout.write('Enter new name (leave blank to keep current): ');
        final name = stdin.readLineSync();
        if (name != null && name.isNotEmpty) {
          updatedData['name'] = name;
        }

        stdout.write('Enter new subjects (comma-separated, leave blank to keep current): ');
        final subjectsInput = stdin.readLineSync();
        if (subjectsInput != null && subjectsInput.isNotEmpty) {
          final subjects = subjectsInput.split(',').map((subject) {
            stdout.write('Enter scores for $subject (comma-separated): ');
            final scoresInput = stdin.readLineSync()!;
            final scores = scoresInput.split(',').map(int.parse).toList();
            return {'name': subject.trim(), 'scores': scores};
          }).toList();
          updatedData['subjects'] = subjects;
        }

        studentService.updateStudent(id, updatedData);
        break;
      case 4:
        stdout.write('Enter name or ID to search: ');
        final query = stdin.readLineSync()!;
        studentService.searchStudent(query);
        break;
      case 5:
        exit(0);
      default:
        print('Invalid option. Please try again.');
    }
  }
}
