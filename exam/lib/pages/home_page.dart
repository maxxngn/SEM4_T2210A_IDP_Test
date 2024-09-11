// File: pages/HomePage.dart
import 'package:flutter/material.dart';
import '../widgets/CustomNavBarCurved.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
      bottomNavigationBar: CustomNavBarCurved(),
    );
  }
}