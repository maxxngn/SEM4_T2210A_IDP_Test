package student.idp.model;

import java.util.List;
import lombok.Data;

@Data
public class Student {
    private String id;
    private String name;
    private List<Subject> subjects;
}
