import 'package:exam/models/Student.dart';
import 'package:exam/pages/add_student_page.dart';
import 'package:exam/pages/display_students_page.dart';
import 'package:exam/pages/edit_student_page.dart';
import 'package:exam/pages/search_student_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayStudentsPage()),
                );
              },
              child: Text('Display all students'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudentPage(onAddStudent: (student) {
                    // Logic to add student
                  })),
                );
              },
              child: Text('Add a student'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ElevatedButton(
              onPressed: () async {
                // Logic to select a student to edit
                Student? selectedStudent = await _selectStudent(context);
                if (selectedStudent != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditStudentPage(
                        student: selectedStudent,
                        onEditStudent: (student) {
                          // Logic to edit student
                        },
                      ),
                    ),
                  );
                }
              },
              child: Text('Edit a student'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchStudentPage(students: [],)),
                );
              },
              child: Text('Search a student'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Student?> _selectStudent(BuildContext context) async {
    // Logic to select a student, e.g., show a dialog with a list of students
    // For simplicity, returning a dummy student
    return Student(id: '1', name: 'Dummy Student', subjects: []);
  }
}