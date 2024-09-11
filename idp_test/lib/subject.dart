
class Subject {
  String name;
  List<int> scores;

  Subject(this.name, this.scores);

  
  Map<String, dynamic> toJson() => {
        'name': name,
        'scores': scores,
      };

 
  static Subject fromJson(Map<String, dynamic> json) {
    List<int> scores = (json['scores'] as List).map((e) => e as int).toList();
    return Subject(json['name'], scores);
  }
}
