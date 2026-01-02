import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart'; // Make sure this path is correct

class StudentSkillsController extends GetxController {
  // Rx variables for state management
  var selectedValue = Rxn<String>();
  var selectedFilter = 'Skills'.obs;
  var selectedSkillFilter = Rxn<String>();

  final RxList<String> items = ['wajiha', 'huba', 'Hiba', 'Zara'].obs;

  // Skills options for the search dropdown
  final RxList<String> skillOptions = [
    'UI/UX',
    'PHP',
    'Flutter',
    'React Native',
    'WebDev',
    'MobileDev',
    'GraphicDes',
    'DBMS',
  ].obs;

  // Data for the horizontal filter cards
  final RxList<String> studentFilterOptions = [
    'All student',
    'Admission Date',
    'Leave Date',
    'ActiveOn',
    'Graduated',
    'Skills',
    'On leave',
  ].obs;

  // Sample student data
  final RxList<Map<String, dynamic>> students = [
    {
      'name': 'Aisha Rehman',
      'id': '101',
      'branchCode': '3001',
      'skills': ['UI/UX', 'GD'],
    },
    {
      'name': 'Maria Khan',
      'id': '102',
      'branchCode': '3001',
      'skills': ['PHP', 'DBM'],
    },
    {
      'name': 'Fatima Ali',
      'id': '103',
      'branchCode': '3002',
      'skills': ['Flutter', 'MD'],
    },
    {
      'name': 'Zainab Ahmed',
      'id': '104',
      'branchCode': '3001',
      'skills': ['UI/UX', 'WD'],
    },
    {
      'name': 'Sara Malik',
      'id': '105',
      'branchCode': '3002',
      'skills': ['React Native', 'JS'],
    },
    {
      'name': 'Hina Raza',
      'id': '106',
      'branchCode': '3001',
      'skills': ['PHP', 'Laravel'],
    },
    {
      'name': 'Nadia Sheikh',
      'id': '107',
      'branchCode': '3003',
      'skills': ['WD', 'UI/UX'],
    },
    {
      'name': 'Ayesha Noor',
      'id': '108',
      'branchCode': '3001',
      'skills': ['GD', 'UI/UX'],
    },
  ].obs;

  // Create a separate observable for filtered students
  final RxList<Map<String, dynamic>> _filteredStudents =
      <Map<String, dynamic>>[].obs;

  // Getter for filtered students
  RxList<Map<String, dynamic>> get filteredStudents => _filteredStudents;

  @override
  void onInit() {
    super.onInit();
    // Initialize with all students
    _filteredStudents.assignAll(students);

    // Listen for skill filter changes
    ever(selectedSkillFilter, (_) => _updateFilteredStudents());
    ever(students, (_) => _updateFilteredStudents());
  }

  // Update filtered students when filters change
  void _updateFilteredStudents() {
    if (selectedSkillFilter.value == null ||
        selectedSkillFilter.value!.isEmpty) {
      _filteredStudents.assignAll(students);
    } else {
      final filteredList = students.where((student) {
        List<String> skills = List<String>.from(student['skills']);
        return skills.any(
          (skill) => skill.toLowerCase().contains(
            selectedSkillFilter.value!.toLowerCase(),
          ),
        );
      }).toList();
      _filteredStudents.assignAll(filteredList);
    }
  }

  // Get color for skill badge
  Color getSkillColor(String skill) {
    return AppColors.lightBlue; // Make sure AppColors is imported
  }

  // Methods for dropdown changes
  void onBranchChanged(String? value) {
    selectedValue.value = value;
  }

  void onSkillFilterChanged(String? value) {
    selectedSkillFilter.value = value;
    // _updateFilteredStudents() will be called automatically due to ever()
  }

  // void onFilterTap(String title) {
  //   selectedFilter.value = title;
  //   print('$title filter tapped');
  // }

  void clearSkillFilter() {
    selectedSkillFilter.value = null;
  }
}
