import 'package:exam/pages/display_students_page.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DisplayStudentsPage(),
    );
  }
}