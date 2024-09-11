import 'subject.dart';

class Student {
  int id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});

  // Convert JSON to Student object
  factory Student.fromJson(Map<String, dynamic> json) {
    var subjectsList = json['subjects'] as List;
    List<Subject> subjects =
        subjectsList.map((i) => Subject.fromJson(i)).toList();
    return Student(id: json['id'], name: json['name'], subjects: subjects);
  }

  // Convert Student object to JSON
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> subjects = this.subjects.map((i) => i.toJson()).toList();
    return {'id': id, 'name': name, 'subjects': subjects};
  }
}
