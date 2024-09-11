import 'dart:io';

import 'package:student_management/services/file_service.dart';
import 'package:student_management/services/student_service.dart';
import 'package:student_management/models/student.dart';
import 'package:student_management/Student.json'
;
Future<void> main() async {
  List<SinhVien> danhSachSinhVien = await FileService.docFileJson();

  while (true) {
    print('1. Hiển thị toàn bộ sinh viên');
    print('2. Thêm sinh viên');
    print('3. Sửa thông tin sinh viên');
    print('4. Tìm kiếm sinh viên theo tên hoặc ID');
    print('5. Thoát');
    print('Chọn chức năng: ');

    int chucNang = int.parse(stdin.readLineSync()!);
    switch (chucNang) {
      case 1:
        StudentService.hienThiDanhSachSinhVien(danhSachSinhVien);
        break;
      case 2:
        StudentService.themSinhVien(danhSachSinhVien);
        break;
      case 3:
        StudentService.suaSinhVien(danhSachSinhVien);
        break;
      case 4:
        StudentService.timKiemSinhVien(danhSachSinhVien);
        break;
      case 5:
        return;
      default:
        print('Chức năng không hợp lệ!');
    }
  }
}

