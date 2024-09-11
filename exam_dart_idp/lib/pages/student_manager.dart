import 'package:exam_dart_idp/models/Student.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DisplayStudentsPage extends StatelessWidget {
  Future<List<Student>> _loadStudents() async {
    String jsonString = await rootBundle.loadString('assets/Student.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Student.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Students'),
      ),
      body: FutureBuilder<List<Student>>(
        future: _loadStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found.'));
          } else {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  title: Text('ID: ${student.id} - Name: ${student.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      ...student.subjects.map((subject) {
                        return Text('${subject.name}: ${subject.scores.join(", ")}');
                      }).toList(),
                    ],
                  ),
                 
                );
              },
            );
          }
        },
      ),
    );
  }
}









