class Subject {
  final String name;
  final List<int> scores;

  Subject({required this.name, required this.scores});

  factory Subject.fromJson(Map<String, dynamic> json) {
    var list = json['scores'] as List;
    List<int> scoreList = list.map((i) => i as int).toList();

    return Subject(
      name: json['name'],
      scores: scoreList,
    );
  }
}