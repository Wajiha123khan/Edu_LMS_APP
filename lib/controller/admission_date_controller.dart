import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/student.dart';
import '../screen/ActiveOn.dart';
import '../screen/AdmissionDate.dart';
import '../screen/Left_student.dart';
import '../screen/managestudent.dart'; // Import your student model

class AdmissionDateController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final ScrollController cardScrollController = ScrollController();

  // FIXED: Use Rxn<String> for nullable string observable
  var selectedValue = Rxn<String>();
  RxString selectedFilter = 'Admission Date'.obs;

  // API Data
  var studentList = <Student_Model_List>[].obs;
  var isDataLoading = true.obs;
  var errorMessage = ''.obs;

  // Data for the horizontal filter cards
  final List<String> admissionFilterOptions = [
    'All student',
    'Admission Date',
    'Leave Date',
    'ActiveOn',
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

  // In the fetchStudentsFromApi method, add these debug prints:
  Future<void> fetchStudentsFromApi() async {
    try {
      isDataLoading(true);
      errorMessage('');
      print('Starting API fetch...');

      final response = await http.get(
        Uri.parse(
          'http://192.168.100.198/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',

          //'http://192.168.137.197/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',

          //'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
          // --- my home have this used
          //'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
        ),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body length: ${response.body.length}');

      if (response.statusCode == 200) {
        print('API Response successful');
        final result = jsonDecode(response.body);

        // Debug: Print the type of result
        print('Result type: ${result.runtimeType}');
        if (result is List) {
          print('Result is a List with ${result.length} items');
        } else if (result is Map) {
          print('Result is a Map with keys: ${result.keys}');
        }

        // Clear existing data
        studentList.clear();
        students.clear();

        // Check if response is a List
        if (result is List) {
          studentList.assignAll(
            result.map((x) => Student_Model_List.fromJson(x)).toList(),
          );

          print('Converted ${studentList.length} students from list');
          _convertStudentListToMap();
        }
        // Check if response has a 'data' field
        else if (result is Map && result.containsKey('data')) {
          final List list = result['data'];
          studentList.assignAll(
            list.map((x) => Student_Model_List.fromJson(x)).toList(),
          );

          print('Converted ${studentList.length} students from data field');
          _convertStudentListToMap();
        } else {
          errorMessage('Unexpected API response format: ${result.runtimeType}');
          print('Unexpected format: $result');
        }
      } else {
        errorMessage(
          'Failed to load students. Status code: ${response.statusCode}',
        );
        print('API failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      errorMessage('Failed to load students: $e');
    } finally {
      isDataLoading(false);
      print('Data loading completed. Students count: ${students.length}');
    }
  }

  // In _convertStudentListToMap method:
  void _convertStudentListToMap() {
    print('Converting ${studentList.length} students to map format');

    students.assignAll(
      studentList.map((student) {
        print('Student: ${student.studentName}, Date: ${student.date}');
        return {
          'name': student.studentName ?? 'Unknown',
          'id': student.sno ?? 'N/A',
          'branchCode': student.branch ?? 'N/A',
          'admissionDate': student.date ?? 'N/A', // Use date field
          'status': 'Admitted',
          'email': student.email ?? '',
          'contact': student.studentContact ?? '',
          'course': student.course ?? '',
          'batch': student.batchName ?? '',
          'image': student.studentImage,
        };
      }).toList(),
    );

    print('Converted ${students.length} students to map format');
  }

  // Filter students based on admission date filters
  List<Map<String, dynamic>> get filteredStudents {
    return students.where((student) {
      final admissionDate = student['admissionDate'];
      if (admissionDate == null || admissionDate == 'N/A') return false;
      if (selectedFilter.value == 'Admission Date') {
        return true;
      } else if (selectedFilter.value == 'This Month') {
        // Filter for this month's admissions
        return true; // Add your date filtering logic here
      } else if (selectedFilter.value == 'Last Month') {
        // Filter for last month's admissions
        return true; // Add your date filtering logic here
      } else if (selectedFilter.value == 'This Year') {
        // Filter for this year's admissions
        return true; // Add your date filtering logic here
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

  // void onFilterTap(String title) {
  //   selectedFilter.value = title;
  //   print('$title filter tapped');
  // }

  // void onFilterTap(String title) {
  //   if (title == 'Admission Date') {
  //     selectedFilter.value = title;
  //   } else if (title == 'All Student') {
  //     Get.to(() => ManageStudent());
  //   } else if (title == 'ActiveOn') {
  //     Get.to(() => ActiveOn());
  //   } else if (title == 'Admission Date') {
  //     Get.to(() => Student_AdmissionDate_Screen());
  //   } else if (title == 'Leave Date') {
  //     Get.to(() => StudentLeftStudentScreen());
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

  // Format date for display
  String formatDate(String dateString) {
    if (dateString == 'N/A' || dateString.isEmpty) return 'N/A';
    try {
      // Assuming date format is YYYY-MM-DD
      final parts = dateString.split('-');
      if (parts.length >= 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}'; // Convert to DD/MM/YYYY
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }
}
