import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../screen/managestudent.dart';
import 'filter_controller.dart'; // Import the ManageStudent screen

class DraftController extends GetxController {
  final FilterController filterController = Get.find<FilterController>();
  final ScrollController scrollController = ScrollController();

  final RxString selectedValue = ''.obs;

  final List<String> items = ['wajiha', 'huba', 'Hiba', 'Zara'];

  final List<Map<String, dynamic>> managementOptions = [
    {
      'icon': Icons.school_outlined,
      'title': 'Manage Student',
      'color': AppColors.primary,
      'route': '/manage-student', // Add route identifier
    },
    {
      'icon': Icons.people_outlined,
      'title': 'Manage Teacher',
      'color': AppColors.primary,
      'route': '/manage-teacher',
    },
    {
      'icon': Icons.business_outlined,
      'title': 'Manage Branch',
      'color': AppColors.primary,
      'route': '/manage-branch',
    },
    {
      'icon': Icons.menu_book_outlined,
      'title': 'Manage Course',
      'color': AppColors.primary,
      'route': '/manage-course',
    },
  ];

  void onDropdownChanged(String? value) {
    if (value != null) {
      selectedValue.value = value;
    }
  }

  void onFilterTap() {
    print('Filter button tapped');
  }

  // void onManagementCardTap(int index) {
  //   print('${managementOptions[index]['title']} tapped');
  //
  //   // Navigate to the appropriate screen based on the card tapped
  //   switch (index) {
  //     case 0: // Manage Student
  //       Get.to(() => ManageStudent()); // Navigate to ManageStudent screen
  //       break;
  //     case 1: // Manage Teacher
  //       // Get.to(() => ManageTeacher()); // Uncomment when you create this screen
  //       break;
  //     case 2: // Manage Branch
  //       // Get.to(() => ManageBranch()); // Uncomment when you create this screen
  //       break;
  //     case 3: // Manage Course
  //       // Get.to(() => ManageCourse()); // Uncomment when you create this screen
  //       break;
  //   }
  // }

  void onManagementCardTap(int index) {
    print('${managementOptions[index]['title']} tapped');

    switch (index) {
      case 0: // Manage Student
        filterController.currentScreenIndex.value = 1;
        break;
      case 1:
        filterController.currentScreenIndex.value = 2;
        break;
      case 2:
        filterController.currentScreenIndex.value = 3;
        break;
      case 3:
        filterController.currentScreenIndex.value = 4;
        break;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
