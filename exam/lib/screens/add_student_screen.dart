import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../widgets/CustomNavBarCurved.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final StudentService _studentService = StudentService();

  int? _id;
  String? _name;
  List<Subject> _subjects = [];

  void _addSubject() {
    setState(() {
      _subjects.add(Subject(name: '', scores: []));
    });
  }

  void _saveStudent() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final newStudent = Student(id: _id!, name: _name!, subjects: _subjects);

      final students = await _studentService.loadStudents();
      students.add(newStudent);
      await _studentService.saveStudents(students);

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _id = int.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              ..._subjects.map((subject) {
                final index = _subjects.indexOf(subject);
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Subject Name'),
                      onChanged: (value) => _subjects[index].name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Scores (comma separated)'),
                      onChanged: (value) {
                        _subjects[index].scores = value.split(',')
                            .map((score) => int.tryParse(score.trim()) ?? 0)
                            .toList();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter scores';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addSubject,
                      child: Text('Add Subject'),
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Save Student'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBarCurved(),
    );
  }
}
