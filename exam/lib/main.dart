import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/add_student_screen.dart';
import './screens/edit_student_screen.dart';
import './models/student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: HomeScreen(),
      routes: {
        '/': (context) => HomeScreen(),
        '/add': (context) => AddStudentScreen(),
      },
    );
  }
}

void navigateToEditStudentScreen(BuildContext context, Student student) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditStudentScreen(student: student),
    ),
  );
}