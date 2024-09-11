import 'package:exam/models/Student.dart';
import 'package:exam/models/subject.dart';
import 'package:flutter/material.dart';


class EditStudentPage extends StatefulWidget {
  final Student student;
  final Function(Student) onEditStudent;

  EditStudentPage({required this.student, required this.onEditStudent});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late List<Subject> _subjects;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.student.id);
    _nameController = TextEditingController(text: widget.student.name);
    _subjects = widget.student.subjects;
  }

  void _editSubject(int index, String name, int score) {
    setState(() {
      _subjects[index] = Subject(name: name, scores: [score]);
    });
  }

  void _editStudent() {
    final String id = _idController.text;
    final String name = _nameController.text;

    final Student editedStudent = Student(id: id, name: name, subjects: _subjects);

    widget.onEditStudent(editedStudent);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
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
            Expanded(
              child: ListView.builder(
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  return ListTile(
                    title: Text(subject.name),
                    subtitle: Text('Scores: ${subject.scores.join(', ')}'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController _subjectNameController = TextEditingController(text: subject.name);
                          final TextEditingController _scoreController = TextEditingController(text: subject.scores.join(', '));
                          return AlertDialog(
                            title: Text('Edit Subject'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _subjectNameController,
                                  decoration: InputDecoration(labelText: 'Subject Name'),
                                ),
                                TextField(
                                  controller: _scoreController,
                                  decoration: InputDecoration(labelText: 'Score'),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _editSubject(index, _subjectNameController.text, int.parse(_scoreController.text));
                                  Navigator.pop(context);
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _editStudent,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}