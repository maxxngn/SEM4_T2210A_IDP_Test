import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../widgets/CustomNavBarCurved.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final StudentService _studentService = StudentService();

  late int _id;
  late String _name;
  late List<Subject> _subjects;

  @override
  void initState() {
    super.initState();
    _id = widget.student.id;
    _name = widget.student.name;
    _subjects = List.from(widget.student.subjects);
  }

  void _saveStudent() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final updatedStudent = Student(id: _id, name: _name, subjects: _subjects);

      final students = await _studentService.loadStudents();
      final index = students.indexWhere((s) => s.id == _id);
      if (index != -1) {
        students[index] = updatedStudent;
        await _studentService.saveStudents(students);
      }

      Navigator.pop(context, true);
    }
  }

  void _addSubject() {
    setState(() {
      _subjects.add(Subject(name: '', scores: []));
    });
  }

  void _removeSubject(int index) {
    setState(() {
      _subjects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _id.toString(),
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _id = int.tryParse(value ?? '') ?? _id,
                readOnly: true,
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value ?? '',
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
                  key: UniqueKey(),
                  children: [
                    TextFormField(
                      initialValue: subject.name,
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
                      initialValue: subject.scores.join(', '),
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _addSubject,
                          child: Text('Add Subject'),
                        ),
                        SizedBox(width: 10),
                        if (_subjects.length > 1)
                          ElevatedButton(
                            onPressed: () => _removeSubject(index),
                            child: Text('Remove Subject'),
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.red,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBarCurved(),
    );
  }
}