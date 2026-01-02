import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/left_Student_model.dart';
import '../screen/ActiveOn.dart';
import '../screen/AdmissionDate.dart';
import '../screen/managestudent.dart';

class LeftStudentController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final ScrollController cardScrollController = ScrollController();

  // FIXED: Use Rxn<String> for nullable string observable
  var selectedValue = Rxn<String>();
  RxString selectedFilter = 'Leave Date'.obs;

  // API Data - Use Left_Student_Model correctly
  var leftStudentModel = Rxn<Left_Student_Model>();
  var isDataLoading = true.obs;
  var errorMessage = ''.obs;

  // Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var limit = 10.obs;

  // Filters
  var searchQuery = ''.obs;
  var selectedSlot = ''.obs;

  // Data for the horizontal filter cards
  final List<String> admissionFilterOptions = [
    'All student',
    'Admission Date',
    'Leave Date',
    'ActiveOn',
    'Graduated',
    'Skills',
    'On leave',
  ];

  List<String> items = ['wajiha', 'huba', 'Hiba', 'Zara']; // Branch items
  List<String> slotOptions = ['All', 'TTS', 'MWF'];

  @override
  void onInit() {
    super.onInit();
    fetchStudentsFromApi();
  }

  // Future<void> fetchStudentsFromApi() async {
  //   try {
  //     isDataLoading(true);
  //     errorMessage('');
  //     print('Starting API fetch for LEFT STUDENTS...');
  //
  //     // Build query parameters
  //     final params = {
  //       'page': currentPage.value.toString(),
  //       'limit': limit.value.toString(),
  //     };
  //
  //     if (searchQuery.isNotEmpty) {
  //       params['search'] = searchQuery.value;
  //     }
  //
  //     if (selectedSlot.isNotEmpty && selectedSlot.value != 'All') {
  //       params['slot'] = selectedSlot.value;
  //     }
  //
  //     // CORRECT: Use the left student API endpoint
  //     final uri = Uri.parse(
  //       'http://192.168.100.198/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
  //
  //       //'http://192.168.137.197/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
  //       //'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_left_api.php',
  //     ).replace(queryParameters: params);
  //
  //     print('API URL: $uri');
  //
  //     final response = await http.get(uri);
  //
  //     print('API Response Status: ${response.statusCode}');
  //     print('API Response Body length: ${response.body.length}');
  //
  //     if (response.statusCode == 200) {
  //       print('API Response successful');
  //       final result = jsonDecode(response.body);
  //
  //       // Debug: Print the type of result
  //       print('Result type: ${result.runtimeType}');
  //       print('Result keys: ${result is Map ? result.keys : 'N/A'}');
  //
  //       if (result['success'] == true) {
  //         leftStudentModel.value = Left_Student_Model.fromJson(result);
  //         totalPages.value =
  //             leftStudentModel.value?.data?.pagination?.totalPages ?? 1;
  //
  //         final studentCount =
  //             leftStudentModel.value?.data?.students?.length ?? 0;
  //         print('Successfully fetched $studentCount left students');
  //
  //         // Print first student details for debugging
  //         if (studentCount > 0) {
  //           final firstStudent = leftStudentModel.value!.data!.students!.first;
  //           print('First student: ${firstStudent.studentName}');
  //           print('Left date: ${firstStudent.leftDate}');
  //           print('Admission date: ${firstStudent.admissionDate}');
  //         }
  //       } else {
  //         errorMessage('API returned success: false');
  //         print('API error: ${result['message'] ?? 'Unknown error'}');
  //       }
  //     } else {
  //       errorMessage(
  //         'Failed to load students. Status code: ${response.statusCode}',
  //       );
  //       print('API failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("API Error: $e");
  //     errorMessage('Failed to load students: $e');
  //   } finally {
  //     isDataLoading(false);
  //     print('Data loading completed');
  //   }
  // }

  Future<void> fetchStudentsFromApi() async {
    try {
      isDataLoading(true);
      errorMessage('');
      print('Starting API fetch for LEFT STUDENTS...');

      final params = {
        'page': currentPage.value.toString(),
        'limit': limit.value.toString(),
      };

      // ✅ FIX 1
      if (searchQuery.value.isNotEmpty) {
        params['search'] = searchQuery.value;
      }

      // ✅ FIX 2
      if (selectedSlot.value.isNotEmpty && selectedSlot.value != 'All') {
        params['slot'] = selectedSlot.value;
      }

      final uri = Uri.parse(
        //'http://192.168.100.198/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
        'http://192.168.100.198/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_left_api.php',
      ).replace(queryParameters: params);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // ✅ FIX 3 (MOST IMPORTANT)
        if (result is! Map<String, dynamic>) {
          errorMessage('Invalid API response');
          return;
        }

        if (result['success'] == true) {
          leftStudentModel.value = Left_Student_Model.fromJson(result);

          totalPages.value =
              leftStudentModel.value?.data?.pagination?.totalPages ?? 1;
        } else {
          errorMessage(result['message'] ?? 'API error');
        }
      } else {
        errorMessage(
          'Failed to load students. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      errorMessage('Failed to load students: $e');
    } finally {
      isDataLoading(false);
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    currentPage.value = 1; // Reset to first page on new search
    fetchStudentsFromApi();
  }

  void setSlot(String slot) {
    selectedSlot.value = slot;
    currentPage.value = 1;
    fetchStudentsFromApi();
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      fetchStudentsFromApi();
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      fetchStudentsFromApi();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      fetchStudentsFromApi();
    }
  }

  // Get the list of students
  List<Students>? get studentsList {
    return leftStudentModel.value?.data?.students;
  }

  // Filter students based on admission date filters
  List<Students>? get filteredStudents {
    return studentsList;
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
  //   if (title == 'Leave Date') {
  //     selectedFilter.value = title;
  //   } else if (title == 'All Student') {
  //     Get.to(() => ManageStudent());
  //   } else if (title == 'ActiveOn') {
  //     Get.to(() => ActiveOn());
  //   } else if (title == 'Admission Date') {
  //     Get.to(() => Student_AdmissionDate_Screen());
  //   } else if (title == 'Leave Date') {
  //     // Already on this screen
  //   } else if (title == 'On leave') {
  //     // Get.to(() => OnLeave());
  //   } else {
  //     selectedFilter.value = title;
  //   }
  //   print('$title filter tapped');
  // }
  // void onFilterTap(String title) {
  //   print('Filter tapped: "$title"'); // Debug print
  //
  //   if (title.toLowerCase().contains('leave date')) {
  //     selectedFilter.value = title;
  //   } else if (title.toLowerCase().contains('all student')) {
  //     Get.to(() => ManageStudent());
  //   } else if (title.toLowerCase().contains('activeon')) {
  //     Get.to(() => ActiveOn());
  //   } else if (title.toLowerCase().contains('admission date')) {
  //     Get.to(() => Student_AdmissionDate_Screen());
  //   } else if (title.toLowerCase().contains('on leave')) {
  //     // Get.to(() => OnLeave());
  //   } else {
  //     selectedFilter.value = title;
  //   }
  // }

  // Refresh data
  void refreshData() {
    fetchStudentsFromApi();
  }

  // Format date for display
  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty || dateString == 'N/A') {
      return 'N/A';
    }

    try {
      // Try to parse ISO format (YYYY-MM-DD)
      if (dateString.contains('-')) {
        final parts = dateString.split('-');
        if (parts.length >= 3) {
          return '${parts[2]}/${parts[1]}/${parts[0]}'; // Convert to DD/MM/YYYY
        }
      }

      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  // Format batch names for display
  String formatBatchNames(List<BatchDetails>? batchDetails) {
    if (batchDetails == null || batchDetails.isEmpty) {
      return 'No Batch';
    }

    return batchDetails.map((b) => b.batchName ?? 'Unknown').join(', ');
  }

  // Get batch slots for display
  String formatBatchSlots(List<BatchDetails>? batchDetails) {
    if (batchDetails == null || batchDetails.isEmpty) {
      return '';
    }

    final slots = batchDetails.map((b) => b.batchSlot ?? '').toSet();
    return slots.join(', ');
  }
}
