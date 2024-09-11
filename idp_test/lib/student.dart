
import 'subject.dart';

class Student {
  int id;
  String name;
  List<Subject> subjects;

  Student(this.id, this.name, this.subjects);

 
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subjects': subjects.map((subject) => subject.toJson()).toList(),
      };


  static Student fromJson(Map<String, dynamic> json) {
    List<Subject> subjects = (json['subjects'] as List)
        .map((subject) => Subject.fromJson(subject))
        .toList();
    return Student(json['id'], json['name'], subjects);
  }
}
