import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/student.dart'; // Import your student model
import '../screen/ActiveOn.dart';
import '../screen/AdmissionDate.dart';
import '../screen/add_student_screen.dart';

class ManageStudentController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final ScrollController cardScrollController = ScrollController();

  // FIXED: Use Rxn<String> for nullable string observable
  var selectedValue = Rxn<String>();
  RxString selectedFilter = 'All student'.obs;

  RxMap<String, dynamic> selectedStudent = <String, dynamic>{
    "name": "Aisha Rehman",
    "email": "aisha@edu.com",
    "phone": "555-1234",
    "student_id": "555-1234",
    "class_id": "300091",
    "status": "Active",
  }.obs;

  // API Data
  var studentList = <Student_Model_List>[].obs;
  var isDataLoading = true.obs;
  var errorMessage = ''.obs;

  // Data for the horizontal filter cards
  final List<String> studentFilterOptions = [
    'All student',
    'Admission Date',
    'Leave Date',
    'ActiveOn',
    'Graduated',
    'Skills',
    'On leave',
  ];

  // Fetched student data - will be populated from API
  final RxList<Map<String, dynamic>> students = <Map<String, dynamic>>[].obs;

  List<String> items = ['wajiha', 'huba', 'Hiba', 'Zara']; // Branch items

  @override
  void onInit() {
    super.onInit();
    fetchStudentsFromApi();
  }

  // Fetch students from API
  Future<void> fetchStudentsFromApi() async {
    try {
      isDataLoading(true);
      errorMessage('');

      final response = await http.get(
        Uri.parse(
          'http://192.168.100.198/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',

          //'http://192.168.137.197/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
          //'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
        ),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Clear existing data
        studentList.clear();
        students.clear();

        // Check if response is a List
        if (result is List) {
          studentList.assignAll(
            result.map((x) => Student_Model_List.fromJson(x)).toList(),
          );

          // Convert to the format needed for your UI
          _convertStudentListToMap();
        }
        // Check if response has a 'data' field
        else if (result is Map && result.containsKey('data')) {
          final List list = result['data'];
          studentList.assignAll(
            list.map((x) => Student_Model_List.fromJson(x)).toList(),
          );

          // Convert to the format needed for your UI
          _convertStudentListToMap();
        } else {
          errorMessage('Unexpected API response format');
        }
      } else {
        errorMessage(
          'Failed to load students. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("API Error: $e");
      errorMessage('Failed to load students: $e');
    } finally {
      isDataLoading(false);
    }
  }

  // Convert Student_Model_List to Map format for your UI
  void _convertStudentListToMap() {
    students.assignAll(
      studentList.map((student) {
        // Determine status based on your logic
        String status = 'Active'; // Default status
        if (student.onOff != null &&
            student.onOff.toString().toLowerCase() == 'off') {
          status = 'Inactive';
        }

        return {
          'name': student.studentName ?? 'Unknown',
          'id': student.sno ?? 'N/A',
          'branchCode': student.branch ?? 'N/A',
          'admissionDate': student.studentJoinDate ?? 'N/A',
          'status': status,
          'email': student.email ?? '',
          'contact': student.studentContact ?? '',
          'course': student.course ?? '',
          'batch': student.batchName ?? '',
          'image': student.studentImage,
        };
      }).toList(),
    );
  }

  // Filter students based on search and filters
  List<Map<String, dynamic>> get filteredStudents {
    if (selectedFilter.value == 'All student') {
      return students;
    }

    return students.where((student) {
      if (selectedFilter.value == 'Active') {
        return student['status'] == 'Active';
      } else if (selectedFilter.value == 'Inactive') {
        return student['status'] == 'Inactive';
      } else if (selectedFilter.value == 'Graduated') {
        return student['status'] == 'Graduated';
      }
      return true;
    }).toList();
  }

  @override
  void onClose() {
    scrollController.dispose();
    cardScrollController.dispose();
    super.onClose();
  }

  // --- Navigation Logic for Horizontal Scroll ---
  void scrollBackward() {
    if (cardScrollController.hasClients) {
      final double currentOffset = cardScrollController.offset;
      final double screenWidth = Get.width - 80;
      final double newOffset = currentOffset - screenWidth * 0.5;

      cardScrollController.animateTo(
        newOffset.clamp(0.0, cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollForward() {
    if (cardScrollController.hasClients) {
      final double currentOffset = cardScrollController.offset;
      final double screenWidth = Get.width - 80;
      final double newOffset = currentOffset + screenWidth * 0.5;

      cardScrollController.animateTo(
        newOffset.clamp(0.0, cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.orange;
      case 'graduated':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void onEditStudent(Map<String, dynamic> student) {
    print('Edit student: ${student['name']}');
    // TODO: Implement edit functionality
  }

  void onDeleteStudent(Map<String, dynamic> student) {
    print('Delete student: ${student['name']}');
    Get.dialog(
      AlertDialog(
        title: Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student['name']}?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Implement API delete call
              Get.back();
              // After successful delete, refresh the list
              fetchStudentsFromApi();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // In ManageStudentController class, add:
  void onAddNewStudent() {
    Get.to(() => AddStudentScreen());
  }

  // void onFilterTap(String title) {
  //   if (title == 'All student') {
  //     selectedFilter.value = title;
  //   } else if (title == 'ActiveOn') {
  //     Get.to(() => ActiveOn());
  //   } else if (title == 'Admission Date') {
  //     Get.to(() => Student_AdmissionDate_Screen());
  //   } else if (title == 'Leave Date') {
  //     // Get.to(() => LeaveDate());
  //   } else if (title == 'On leave') {
  //     // Get.to(() => OnLeave());
  //   } else {
  //     selectedFilter.value = title;
  //   }
  //   print('$title filter tapped');
  // }

  // Refresh data
  void refreshData() {
    fetchStudentsFromApi();
  }
}
