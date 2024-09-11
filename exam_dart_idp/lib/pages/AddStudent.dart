import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final List<Student> _students = [];

  void _addStudent() async {
    final String name = _nameController.text;
    final String id = _idController.text;
    final String subject = _subjectController.text;
    final String score = _scoreController.text;

    if (name.isNotEmpty && id.isNotEmpty && subject.isNotEmpty && score.isNotEmpty) {
      setState(() {
        _students.add(Student(name, id, subject, score));
        _nameController.clear();
        _idController.clear();
        _subjectController.clear();
        _scoreController.clear();
      });

      // Save to JSON file
      try {
        await _saveToFile();
        print('Student data saved successfully.');
      } catch (e) {
        print('Error saving student data: $e');
      }
    }
  }

  Future<void> _saveToFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/Student.json');
      print('Saving to file: ${file.path}'); // Print file path for verification
      final List<Map<String, dynamic>> jsonData = _students.map((student) => student.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonData));
      print('File content: ${await file.readAsString()}'); // Print file content for verification
    } catch (e) {
      print('Error writing to file: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
           
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
              onPressed: _addStudent,
              child: Text('Add Student'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_students[index].name} (${_students[index].id})'),
                    subtitle: Text('Subject: ${_students[index].subject}, Score: ${_students[index].score}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String name;
  final String id;
  final String subject;
  final String score;

  Student(this.name, this.id, this.subject, this.score);

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'subject': subject,
        'score': score,
      };
}