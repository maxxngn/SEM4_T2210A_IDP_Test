import 'package:exam_dart_idp/pages/AddStudent.dart';
import 'package:exam_dart_idp/pages/EditStudentPage.dart';
import 'package:exam_dart_idp/pages/SearchPage.dart';
import 'package:flutter/material.dart';
import 'student_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management '),
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
                  MaterialPageRoute(builder: (context) => AddStudent()),
                );
              },
              child: Text('Add a student'),
            ),


             Padding(
              padding: EdgeInsets.all(10),
            ),



            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditStudentPage()),
                );
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
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Text('Search a student'),
            ),
          ],
        ),
      ),
    );
  }
}