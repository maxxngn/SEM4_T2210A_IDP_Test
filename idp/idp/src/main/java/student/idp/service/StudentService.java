package student.idp.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import student.idp.model.Student;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@Service
public class StudentService {

    private static final String FILE_PATH = "Student.json"; // Đặt đúng tên file trong resources
    private Map<String, Student> students = new HashMap<>();

    public StudentService() {
        ObjectMapper mapper = new ObjectMapper();
        try {
            ClassPathResource resource = new ClassPathResource(FILE_PATH);
            List<Student> studentList = mapper.readValue(resource.getInputStream(), new TypeReference<>() {});
            for (Student student : studentList) {
                students.put(student.getId(), student);
            }
        } catch (IOException e) {
            e.printStackTrace(); // Có thể thay bằng logging framework nếu cần
            // Xử lý lỗi ở đây hoặc ném ngoại lệ tùy vào yêu cầu của bạn
        }
    }

    public List<Student> getAllStudents() {
        return new ArrayList<>(students.values());
    }

    public Student getStudentById(String id) {
        return students.get(id);
    }

    public void addStudent(Student student) {
        students.put(student.getId(), student);
    }

    public void updateStudent(Student student) {
        students.put(student.getId(), student);
    }

    public void deleteStudent(String id) {
        students.remove(id);
    }
}
