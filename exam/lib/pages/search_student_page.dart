import 'package:exam/models/Student.dart';
import 'package:flutter/material.dart';


class SearchStudentPage extends StatefulWidget {
  final List<Student> students;

  SearchStudentPage({required this.students});

  @override
  _SearchStudentPageState createState() => _SearchStudentPageState();
}

class _SearchStudentPageState extends State<SearchStudentPage> {
  TextEditingController _searchController = TextEditingController();
  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = widget.students;
  }

  void _filterStudents(String query) {
    final filtered = widget.students.where((student) {
      final nameLower = student.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredStudents = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search by name'),
              onChanged: _filterStudents,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text('ID: ${student.id}'),
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