import 'package:dart_bai_thi/dart_bai_thi.dart' as dart_bai_thi;
import 'dart:io';
import 'package:dart_bai_thi/student_management.dart';

void main(List<String> arguments) {
  const String filePath = 'lib/Student.json';
  List<Student> students = loadStudents(filePath);

  print('Chương trình Quản Lý Sinh Viên');
  bool isRunning = true;

  while (isRunning) {
    print('\nChọn chức năng:');
    print('1. Hiển thị toàn bộ sinh viên');
    print('2. Thêm sinh viên');
    print('3. Sửa thông tin sinh viên');
    print('4. Tìm kiếm sinh viên');
    print('5. Thoát chương trình');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        displayAllStudents(students);
        break;
      case '2':
        print('Nhập ID sinh viên:');
        String id = stdin.readLineSync()!;
        print('Nhập tên sinh viên:');
        String name = stdin.readLineSync()!;
        print('Nhập môn học và điểm (ví dụ: Toán, 8.5, 9.0):');
        Map<String, List<double>> subjects = {};
        while (true) {
          print('Nhập tên môn học (hoặc bấm Enter để kết thúc):');
          String subject = stdin.readLineSync()!;
          if (subject.isEmpty) break;
          print('Nhập điểm môn học (cách nhau bởi dấu phẩy):');
          List<double> grades = stdin.readLineSync()!
              .split(',')
              .map((grade) => double.parse(grade.trim()))
              .toList();
          subjects[subject] = grades;
        }
        addStudent(students, id, name, subjects);
        saveStudents(filePath, students);
        break;
      case '3':
        print('Nhập ID sinh viên cần sửa:');
        String id = stdin.readLineSync()!;
        print('Nhập tên mới (hoặc bấm Enter để bỏ qua):');
        String? newName = stdin.readLineSync();
        newName = newName!.isEmpty ? null : newName;
        print('Nhập môn học và điểm mới (hoặc bấm Enter để bỏ qua):');
        Map<String, List<double>>? newSubjects = {};
        while (true) {
          print('Nhập tên môn học (hoặc bấm Enter để kết thúc):');
          String subject = stdin.readLineSync()!;
          if (subject.isEmpty) break;
          print('Nhập điểm môn học (cách nhau bởi dấu phẩy):');
          List<double> grades = stdin.readLineSync()!
              .split(',')
              .map((grade) => double.parse(grade.trim()))
              .toList();
          newSubjects[subject] = grades;
        }
        if (newSubjects.isEmpty) newSubjects = null;
        editStudent(students, id, newName: newName, newSubjects: newSubjects);
        saveStudents(filePath, students);
        break;
      case '4':
        print('Tìm theo ID hoặc tên? (1: ID, 2: Tên)');
        String? searchChoice = stdin.readLineSync();
        if (searchChoice == '1') {
          print('Nhập ID:');
          String id = stdin.readLineSync()!;
          searchStudent(students, id: id);
        } else if (searchChoice == '2') {
          print('Nhập tên:');
          String name = stdin.readLineSync()!;
          searchStudent(students, name: name);
        } else {
          print('Lựa chọn không hợp lệ.');
        }
        break;
      case '5':
        isRunning = false;
        break;
      default:
        print('Lựa chọn không hợp lệ.');
    }
  }
}
