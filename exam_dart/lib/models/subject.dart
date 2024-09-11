class Subject {
  String name;
  List<int> scores;

  Subject({required this.name, required this.scores});

  factory Subject.fromJson(Map<String, dynamic> json) {
    var scoresFromJson = json['scores'];
    List<int> scoresList = List<int>.from(scoresFromJson);
    return Subject(name: json['name'], scores: scoresList);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'scores': scores};
  }
}
