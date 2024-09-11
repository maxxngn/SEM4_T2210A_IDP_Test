import 'dart:convert';
import 'dart:io';
import '../models/student.dart';
import '../models/subject.dart';

List<Student> students = [];

void loadStudents() {
  try {
    String jsonString = File('lib/Student.json').readAsStringSync();
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    var studentsList = jsonResponse['students'] as List;
    students = studentsList.map((i) => Student.fromJson(i)).toList();
    print('Dữ liệu đã được load thành công.');
  } catch (e) {
    print('Không thể load dữ liệu: $e');
  }
}

void saveStudents() {
  try {
    List<Map<String, dynamic>> jsonStudents = students.map((i) => i.toJson()).toList();
    String jsonString = JsonEncoder.withIndent('  ').convert({'students': jsonStudents});
    File('lib/Student.json').writeAsStringSync(jsonString);
    print('Dữ liệu đã được lưu và format thành công.');
  } catch (e) {
    print('Không thể lưu dữ liệu: $e');
  }
}


void displayStudents() {
  if (students.isEmpty) {
    print('Danh sách sinh viên trống.');
    return;
  }
  for (var student in students) {
    print('ID: ${student.id}, Tên: ${student.name}');
    for (var subject in student.subjects) {
      print('  Môn: ${subject.name}, Điểm: ${subject.scores}');
    }
  }
}

void addStudent() {
  print('Nhập ID sinh viên: ');
  int id = int.parse(stdin.readLineSync()!);
  print('Nhập tên sinh viên: ');
  String name = stdin.readLineSync()!;
  List<Subject> subjects = [];

  print('Nhập số môn học: ');
  int numSubjects = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < numSubjects; i++) {
    print('Nhập tên môn học thứ ${i + 1}: ');
    String subjectName = stdin.readLineSync()!;
    print('Nhập số lượng điểm cho môn học: ');
    int numScores = int.parse(stdin.readLineSync()!);
    List<int> scores = [];
    for (int j = 0; j < numScores; j++) {
      print('Nhập điểm thứ ${j + 1}: ');
      int score = int.parse(stdin.readLineSync()!);
      scores.add(score);
    }
    subjects.add(Subject(name: subjectName, scores: scores));
  }

  students.add(Student(id: id, name: name, subjects: subjects));
  print('Thêm sinh viên thành công.');

  // Lưu lại dữ liệu vào file Student.json sau khi thêm
  saveStudents();
}


void editStudent() {
  print('Nhập ID sinh viên cần chỉnh sửa: ');
  int id = int.parse(stdin.readLineSync()!);
  Student? student = students.firstWhere(
      (s) => s.id == id, orElse: () => Student(id: -1, name: 'Unknown', subjects: []));
  
  if (student.id == -1) {
    print('Không tìm thấy sinh viên.');
    return;
  }

  print('Nhập tên mới (hoặc để trống nếu không thay đổi): ');
  String name = stdin.readLineSync()!;
  if (name.isNotEmpty) {
    student.name = name;
  }

  print('Có muốn chỉnh sửa môn học không? (y/n): ');
  String choice = stdin.readLineSync()!;
  if (choice.toLowerCase() == 'y') {
    print('Nhập số môn học mới: ');
    int numSubjects = int.parse(stdin.readLineSync()!);
    List<Subject> newSubjects = [];
    for (int i = 0; i < numSubjects; i++) {
      print('Nhập tên môn học thứ ${i + 1}: ');
      String subjectName = stdin.readLineSync()!;
      print('Nhập số lượng điểm cho môn học: ');
      int numScores = int.parse(stdin.readLineSync()!);
      List<int> scores = [];
      for (int j = 0; j < numScores; j++) {
        print('Nhập điểm thứ ${j + 1}: ');
        int score = int.parse(stdin.readLineSync()!);
        scores.add(score);
      }
      newSubjects.add(Subject(name: subjectName, scores: scores));
    }
    student.subjects = newSubjects;
    print('Chỉnh sửa thành công.');
  }

  // Lưu dữ liệu vào file Student.json sau khi chỉnh sửa
  saveStudents();
}


void searchStudent() {
  print('Nhập ID hoặc tên sinh viên: ');
  String query = stdin.readLineSync()!;
  var results = students.where((student) =>
      student.name.toLowerCase().contains(query.toLowerCase()) ||
      student.id.toString() == query);
  if (results.isEmpty) {
    print('Không tìm thấy sinh viên.');
  } else {
    for (var student in results) {
      print('ID: ${student.id}, Tên: ${student.name}');
      for (var subject in student.subjects) {
        print('  Môn: ${subject.name}, Điểm: ${subject.scores}');
      }
    }
  }
}
