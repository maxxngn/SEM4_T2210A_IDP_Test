import 'dart:io';
import 'dart:convert';
import 'package:exam/models/Student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'add_student_page.dart';
import 'edit_student_page.dart';
import 'search_student_page.dart';

class DisplayStudentsPage extends StatefulWidget {
  @override
  _DisplayStudentsPageState createState() => _DisplayStudentsPageState();
}

class _DisplayStudentsPageState extends State<DisplayStudentsPage> {
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    String jsonString = await rootBundle.loadString('assets/student.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _students = jsonResponse.map((data) => Student.fromJson(data)).toList();
    });
  }

  void _addStudent(Student student) {
    setState(() {
      _students.add(student);
    });
    _saveStudents();
  }

  void _editStudent(Student editedStudent) {
    setState(() {
      int index = _students.indexWhere((student) => student.id == editedStudent.id);
      if (index != -1) {
        _students[index] = editedStudent;
      }
    });
    _saveStudents();
  }

  Future<void> _saveStudents() async {
    final String jsonString = json.encode(_students.map((student) => student.toJson()).toList());
    final file = await _localFile;
    await file.writeAsString(jsonString);
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
        title: Text('Display Students'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchStudentPage(students: _students),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return ExpansionTile(
            title: Text(student.name),
            subtitle: Text('ID: ${student.id}'),
            children: student.subjects.map((subject) {
              return ListTile(
                title: Text(subject.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scores: ${subject.scores.join(', ')}'),
                    Text('Average Score: ${_calculateAverage(subject.scores)}'),
                  ],
                ),
              );
            }).toList(),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditStudentPage(
                      student: student,
                      onEditStudent: _editStudent,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentPage(onAddStudent: _addStudent),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  double _calculateAverage(List<int> scores) {
    if (scores.isEmpty) return 0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}