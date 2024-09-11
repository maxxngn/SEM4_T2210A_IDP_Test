import 'dart:io';
import 'package:student_management/services/file_service.dart';
import 'package:student_management/services/student_service.dart';
import 'package:student_management/models/student.dart';

class StudentService {
  static void hienThiDanhSachSinhVien(List<Student> danhSachSinhVien) {
    if (danhSachSinhVien.isEmpty) {
      print('Danh sách sinh viên rỗng.');
    } else {
      for (var student in danhSachSinhVien) {
        print('ID: ${student.id}, Tên: ${student.name}');
        for (var subject in student.subjects) {
          print('  Môn: ${subject.name}, Điểm: ${subject.scores.scores}');
        }
      }
    }
  }

  static void themSinhVien(List<Student> danhSachSinhVien) async {
    // Thêm sinh viên mới
  }

  static void suaSinhVien(List<Student> danhSachSinhVien) async {
    // Sửa thông tin sinh viên
  }

  static void timKiemSinhVien(List<Student> danhSachSinhVien) {
    // Tìm kiếm sinh viên
  }
}