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
  List<Student> _filteredStudents = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudents();
    _searchController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    final students = await _studentService.loadStudents();
    setState(() {
      _students = students;
      _filteredStudents = students;
    });
  }

  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _students;
      } else {
        _filteredStudents = _students.where((student) {
          return student.name.toLowerCase().contains(query);
        }).toList();
      }
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final student = _filteredStudents[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text('ID: ${student.id}'),
                  onTap: () => _editStudent(student),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBarCurved(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        child: Icon(Icons.add),
      ),
    );
  }
}
