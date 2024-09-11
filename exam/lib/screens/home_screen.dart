import 'package:flutter/material.dart';
import '/models/student.dart';
import '/services/student_service.dart';
import 'add_student_screen.dart';
import 'edit_student_screen.dart';
import '../widgets/CustomNavBarCurved.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentService _studentService = StudentService();
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

Future<void> _loadStudents() async {
  final students = await _studentService.loadStudents();
  setState(() {
    _students = students;
  });
}

  void _addStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStudentScreen()),
    );
    if (result == true) {
      _loadStudents();
    }
  }

  void _editStudent(Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStudentScreen(student: student),
      ),
    );
    if (result == true) {
      _loadStudents();
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Student Management'),
    ),
    body: ListView.builder(
      itemCount: _students.length,
      itemBuilder: (context, index) {
        final student = _students[index];
        return ListTile(
          title: Text(student.name),
          subtitle: Text('ID: ${student.id}'),
          onTap: () => _editStudent(student),
        );
      },
    ),
    bottomNavigationBar: CustomNavBarCurved(),
    floatingActionButton: FloatingActionButton(
      onPressed: _addStudent,
      child: Icon(Icons.add),
    ),
  );
}
}
