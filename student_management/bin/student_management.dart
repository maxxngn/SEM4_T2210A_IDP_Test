
import 'dart:io';
import '../lib/models/student.dart';
import '../lib/services/student_service.dart';


void main() {
  final studentService = StudentService();

  while (true) {
    print('\nChọn một chức năng:');
    print('1. Hiển thị toàn bộ sinh viên');
    print('2. Thêm sinh viên');
    print('3. Sửa thông tin sinh viên');
    print('4. Tìm kiếm sinh viên theo Tên hoặc ID');
    print('5. Thoát');

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
        print('Lựa chọn không hợp lệ.');
    }
  }
}

void addNewStudent(StudentService service) {
  print('Nhập ID sinh viên:');
  int id = int.parse(stdin.readLineSync()!);

  print('Nhập tên sinh viên:');
  String name = stdin.readLineSync()!;

  List<Subject> subjects = [];
  while (true) {
    print('Nhập tên môn học (hoặc "x" để dừng):');
    String subjectName = stdin.readLineSync()!;
    if (subjectName.toLowerCase() == 'x') break;

    print('Nhập điểm thi (cách nhau bởi dấu phẩy):');
    List<int> scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
    subjects.add(Subject(name: subjectName, scores: scores));
  }

  service.addStudent(Student(id: id, name: name, subjects: subjects));
  print('Thêm sinh viên thành công.');
}

void editStudentInfo(StudentService service) {
  print('Nhập ID sinh viên cần sửa:');
  int id = int.parse(stdin.readLineSync()!);

  print('Nhập tên mới (hoặc nhấn Enter để giữ nguyên):');
  String? newName = stdin.readLineSync();
  if (newName!.isEmpty) newName = null;

  print('Bạn có muốn sửa môn học không? (y/n)');
  if (stdin.readLineSync()!.toLowerCase() == 'y') {
    List<Subject> subjects = [];
    while (true) {
      print('Nhập tên môn học (hoặc "x" để dừng):');
      String subjectName = stdin.readLineSync()!;
      if (subjectName.toLowerCase() == 'x') break;

      print('Nhập điểm thi (cách nhau bởi dấu phẩy):');
      List<int> scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
      subjects.add(Subject(name: subjectName, scores: scores));
    }
    service.updateStudent(id, name: newName, subjects: subjects);
  } else {
    service.updateStudent(id, name: newName);
  }

  print('Sửa thông tin sinh viên thành công.');
}

void searchStudent(StudentService service) {
  print('Nhập ID hoặc tên sinh viên để tìm kiếm:');
  String query = stdin.readLineSync()!;

  if (int.tryParse(query) != null) {
    var student = service.searchStudentById(int.parse(query));
    if (student != null) {
      print('Tìm thấy sinh viên: ${student.name}');
    } else {
      print('Không tìm thấy sinh viên.');
    }
  } else {
    var students = service.searchStudentByName(query);
    if (students.isNotEmpty) {
      for (var student in students) {
        print('ID: ${student.id}, Name: ${student.name}');
      }
    } else {
      print('Không tìm thấy sinh viên.');
    }
  }
}
