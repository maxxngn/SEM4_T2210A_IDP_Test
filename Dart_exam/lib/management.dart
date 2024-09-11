import 'dart:convert';
import 'dart:io';

class Student {
  String id;
  String name;
  List<Subject> subjects;

  Student({
    required this.id,
    required this.name,
    required this.subjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    var subjectsJson = json['Subjects'] as List;
    List<Subject> subjectsList =
        subjectsJson.map((i) => Subject.fromJson(i)).toList();

    return Student(
      id: json['ID'] ?? '', 
      name: json['Name'] ?? '', 
      subjects: subjectsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Subjects': subjects.map((e) => e.toJson()).toList(),
    };
  }
}

class Subject {
  String subject;
  double score;

  Subject({
    required this.subject,
    required this.score,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject: json['Subject'] ?? '', 
      score: (json['Score'] as num).toDouble(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'Score': score,
    };
  }
}

Future<List<Student>> loadStudents() async {
  try {
    final file = File('Student.json');
    final jsonString = await file.readAsString();
    final jsonResponse = json.decode(jsonString) as List;
    return jsonResponse.map((student) => Student.fromJson(student)).toList();
  } catch (e) {
    print('Error loading students: $e');
    return [];
  }
}

Future<void> saveStudents(List<Student> students) async {
  try {
    final file = File('Student.json');
    final jsonString = json.encode(students.map((s) => s.toJson()).toList());
    await file.writeAsString(jsonString);
  } catch (e) {
    print('Error saving students: $e');
  }
}

void displayStudents(List<Student> students) {
  for (var student in students) {
    print('ID: ${student.id}, Name: ${student.name}');
    for (var subject in student.subjects) {
      print('  Subject: ${subject.subject}, Score: ${subject.score}');
    }
    print('');
  }
}

Future<void> addStudent() async {
  final students = await loadStudents();

  print('Enter student ID:');
  String id = stdin.readLineSync() ?? ''; 
  print('Enter student Name:');
  String name = stdin.readLineSync() ?? ''; 

  List<Subject> subjects = [];
  while (true) {
    print('Enter Subject (or type "done" to finish):');
    String subjectName = stdin.readLineSync() ?? ''; 
    if (subjectName == 'done') break;

    print('Enter Score:');
    double score = double.parse(stdin.readLineSync() ?? '0'); 

    subjects.add(Subject(subject: subjectName, score: score));
  }

  students.add(Student(id: id, name: name, subjects: subjects));
  await saveStudents(students);

  print('Student added successfully!');
}

Future<void> updateStudent() async {
  final students = await loadStudents();

  print('Enter student ID to update:');
  String id = stdin.readLineSync() ?? ''; 
  Student? student = students.firstWhere(
    (s) => s.id == id,
    orElse: () => Student(id: '', name: '', subjects: []), 
  );

  if (student.id.isEmpty) {
    print('Student not found!');
    return;
  }

  print('Enter new name (leave empty to keep current):');
  String name = stdin.readLineSync() ?? ''; 
  if (name.isNotEmpty) student.name = name;

  print('Enter new subjects (or type "done" to finish):');
  List<Subject> subjects = [];
  while (true) {
    String subjectName = stdin.readLineSync() ?? ''; 
    if (subjectName == 'done') break;

    print('Enter Score:');
    double score = double.parse(stdin.readLineSync() ?? '0'); 

    subjects.add(Subject(subject: subjectName, score: score));
  }
  student.subjects = subjects;

  // Cập nhật danh sách học sinh
  final updatedStudents = students.where((s) => s.id != id).toList()..add(student);
  await saveStudents(updatedStudents);

  print('Student updated successfully!');
}


Future<void> searchStudent() async {
  final students = await loadStudents();

  print('Enter student ID or Name to search:');
  String searchTerm = stdin.readLineSync() ?? ''; 
  Student? student = students.firstWhere(
    (s) => s.id == searchTerm || s.name.contains(searchTerm),
    orElse: () => Student(id: '', name: '', subjects: []), 
  );

  if (student.id.isEmpty) {
    print('Student not found!');
  } else {
    print('ID: ${student.id}, Name: ${student.name}');
    for (var subject in student.subjects) {
      print('  Subject: ${subject.subject}, Score: ${subject.score}');
    }
  }
}



