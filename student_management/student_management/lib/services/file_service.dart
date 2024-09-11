import 'dart:convert';
import 'dart:io';
import '../models/student.dart';

class FileService {
  static String filePath = 'Student.json';

  // Đọc dữ liệu từ file JSON
  static Future<List<SinhVien>> docFileJson() async {
    final file = File(filePath);
    final noiDung = await file.readAsString();
    final jsonData = jsonDecode(noiDung);
    return (jsonData['students'] as List).map((sinhVien) => SinhVien.fromJson(sinhVien)).toList();
  }

  // Lưu dữ liệu vào file JSON
  static Future<void> luuFileJson(List<SinhVien> danhSachSinhVien) async {
    final file = File(filePath);
    final jsonData = jsonEncode({
      'students': danhSachSinhVien.map((sv) => sv.toJson()).toList()
    });
    await file.writeAsString(jsonData);
  }
}
