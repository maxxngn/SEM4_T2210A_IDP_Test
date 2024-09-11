class Subject {
  final String name;
  final List<int> scores;

  Subject({required this.name, required this.scores});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
      scores: List<int>.from(json['scores']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'scores': scores,
    };
  }
}

class Student {
  final int id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }

  void update(Map<String, dynamic> updatedData) {
    if (updatedData.containsKey('name')) {
      name = updatedData['name'];
    }
    if (updatedData.containsKey('subjects')) {
      subjects = (updatedData['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList();
    }
  }
}
