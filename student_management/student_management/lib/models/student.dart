import 'subject.dart';

class SinhVien {
  int id;
  String ten;
  List<MonHoc> monHoc;

  SinhVien({required this.id, required this.ten, required this.monHoc});

  
  factory SinhVien.fromJson(Map<String, dynamic> json) {
    var list = json['subjects'] as List;
    List<MonHoc> monHocList = list.map((i) => MonHoc.fromJson(i)).toList();
    return SinhVien(id: json['id'], ten: json['name'], monHoc: monHocList);
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': ten,
      'subjects': monHoc.map((mon) => mon.toJson()).toList()
    };
  }

  @override
  String toString() {
    return 'ID: $id, Tên: $ten, Môn học: ${monHoc.toString()}';
  }
}
