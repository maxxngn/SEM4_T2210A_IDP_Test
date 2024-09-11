class MonHoc {
  String ten;
  List<int> diem;

  MonHoc({required this.ten, required this.diem});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    var diemList = json['scores'].cast<int>();
    return MonHoc(ten: json['name'], diem: diemList);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': ten,
      'scores': diem,
    };
  }

  @override
  String toString() {
    return '$ten: ${diem.join(", ")}';
  }
}
