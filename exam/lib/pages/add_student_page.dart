import 'dart:convert';
import 'dart:io';
import 'package:exam/models/Student.dart';
import 'package:exam/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class AddStudentPage extends StatefulWidget {
  final Function(Student) onAddStudent;

  AddStudentPage({required this.onAddStudent});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  List<Subject> _subjects = [];

  void _addSubject() {
    final String subjectName = _subjectController.text;
    final int score = int.parse(_scoreController.text);

    setState(() {
      _subjects.add(Subject(name: subjectName, scores: [score]));
    });

    _subjectController.clear();
    _scoreController.clear();
  }

  void _addStudent() {
    final String id = _idController.text;
    final String name = _nameController.text;

    final Student newStudent = Student(id: id, name: name, subjects: _subjects);

    widget.onAddStudent(newStudent);

    // Lưu dữ liệu sau khi thêm sinh viên mới
    _saveStudents(newStudent);

    Navigator.pop(context);
  }

  Future<void> _saveStudents(Student newStudent) async {
    final List<Student> students = await _loadStudents();
    students.add(newStudent);

    final String jsonString = json.encode(students.map((student) => student.toJson()).toList());
    final file = await _localFile;
    await file.writeAsString(jsonString);
  }

  Future<List<Student>> _loadStudents() async {
    try {
      final file = await _localFile;
      final jsonString = await file.readAsString();
      final List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/student.json');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _scoreController,
              decoration: InputDecoration(labelText: 'Score'),
            ),
            ElevatedButton(
              onPressed: _addSubject,
              child: Text('Add Subject'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  return ListTile(
                    title: Text(subject.name),
                    subtitle: Text('Scores: ${subject.scores.join(', ')}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}