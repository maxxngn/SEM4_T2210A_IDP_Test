import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Student> _students = [];
  List<Student> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/Student.json');
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(contents);
        setState(() {
          _students = jsonData.map((data) => Student.fromJson(data)).toList();
        });
      }
    } catch (e) {
      print('Error loading student data: $e');
    }
  }

  void _searchStudent() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _students.where((student) {
        return student.name.toLowerCase().contains(query) ||
               student.id.toLowerCase().contains(query);
      }).toList();
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
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Name or ID'),
            ),
            ElevatedButton(
              onPressed: _searchStudent,
              child: Text('Search Student'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_searchResults[index].name} (${_searchResults[index].id})'),
                    subtitle: Text('Subject: ${_searchResults[index].subject}, Score: ${_searchResults[index].score}'),
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

class Student {
  final String name;
  final String id;
  final String subject;
  final String score;

  Student(this.name, this.id, this.subject, this.score);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['name'],
      json['id'],
      json['subject'],
      json['score'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'subject': subject,
        'score': score,
      };
}