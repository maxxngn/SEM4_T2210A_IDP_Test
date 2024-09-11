import '../lib/services/student_service.dart';
import 'dart:io';

void main() {
  loadStudents();
  int choice;

  do {
    print('Chương trình quản lý sinh viên');
    print('1. Hiển thị toàn bộ sinh viên');
    print('2. Thêm sinh viên');
    print('3. Sửa thông tin sinh viên');
    print('4. Tìm kiếm sinh viên theo tên hoặc ID');
    print('5. Thoát');
    print('Lựa chọn của bạn: ');
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        displayStudents();
        break;
      case 2:
        addStudent();
        break;
      case 3:
        editStudent();
        break;
      case 4:
        searchStudent();
        break;
      case 5:
        print('Thoát chương trình.');
        break;
      default:
        print('Lựa chọn không hợp lệ.');
    }
  } while (choice != 5);

  saveStudents();
}
