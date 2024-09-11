import 'dart:convert';
import 'dart:io';

class Student {
  String id;
  String name;
  Map<String, List<double>> subjects;

  Student({required this.id, required this.name, required this.subjects});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      subjects: (json['subjects'] as Map<String, dynamic>).map(
  (key, value) => MapEntry(
    key, (value as List<dynamic>).map((item) => item as double).toList(),
  ),
),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects,
    };
  }

  @override
  String toString() {
    return 'ID: $id, Tên: $name, Môn học: $subjects';
  }
}

List<Student> loadStudents(String filePath) {
  try {
    String jsonData = File(filePath).readAsStringSync();
    List<dynamic> studentsJson = jsonDecode(jsonData);
    return studentsJson.map((json) => Student.fromJson(json)).toList();
  } catch (e) {
    print('Không thể đọc dữ liệu từ file: $e');
    return [];
  }
}

void saveStudents(String filePath, List<Student> students) {
  try {
    String jsonData = const JsonEncoder.withIndent('  ').convert(students.map((student) => student.toJson()).toList());
    File(filePath).writeAsStringSync(jsonData);
  } catch (e) {
    print('Không thể ghi dữ liệu vào file: $e');
  }
}

void displayAllStudents(List<Student> students) {
  if (students.isEmpty) {
    print('Danh sách sinh viên trống.');
  } else {
    students.forEach((student) => print(student));
  }
}

void addStudent(List<Student> students, String id, String name, Map<String, List<double>> subjects) {
  students.add(Student(id: id, name: name, subjects: subjects));
  print('Đã thêm sinh viên $name.');
}

void editStudent(List<Student> students, String id, {String? newName, Map<String, List<double>>? newSubjects}) {
  Student? student = students.firstWhere((student) => student.id == id, orElse: () => Student(id: '', name: '', subjects: {}));
  if (student.id.isNotEmpty) {
    student.name = newName ?? student.name;
    student.subjects = newSubjects ?? student.subjects;
    print('Đã cập nhật thông tin sinh viên có ID: $id.');
  } else {
    print('Không tìm thấy sinh viên có ID: $id.');
  }
}

void searchStudent(List<Student> students, {String? id, String? name}) {
  List<Student> foundStudents = students.where((student) {
    if (id != null && student.id == id) return true;
    if (name != null && student.name.toLowerCase().contains(name.toLowerCase())) return true;
    return false;
  }).toList();

  if (foundStudents.isNotEmpty) {
    foundStudents.forEach((student) => print(student));
  } else {
    print('Không tìm thấy sinh viên.');
  }
}
