
import '../lib/student.dart';
import '../lib/subject.dart';
import '../lib/student_service.dart';

void main() {
  const filePath = 'Student.json';
  final studentService = StudentService(filePath);

 
  List<Student> students = studentService.readStudents();

 
  print('Displaying all students:');
  studentService.displayAllStudents(students);

  final newStudent = Student(3, 'Nam ', [
    Subject('History', [10, 9, 9]),
    Subject('Geography', [6, 7, 8]),
  ]);
  studentService.addStudent(students, newStudent);

  studentService.editStudent(students, 1, 'Nam Updated');


}


