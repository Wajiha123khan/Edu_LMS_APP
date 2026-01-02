import '../model/student_model.dart';

class StudentService {
  static List<StudentModel> fetchStudents() {
    return [
      StudentModel(
        name: 'Aisha Rehman',
        id: '101',
        branchCode: '3001',
        admissionDate: '2023-01-15',
        status: 'Active',
      ),
      StudentModel(
        name: 'Maria Khan',
        id: '102',
        branchCode: '3001',
        admissionDate: '2023-02-20',
        status: 'Active',
      ),
      StudentModel(
        name: 'Nadia Sheikh',
        id: '107',
        branchCode: '3003',
        admissionDate: '2023-06-22',
        status: 'Graduated',
      ),
    ];
  }
}
