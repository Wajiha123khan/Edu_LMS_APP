import 'package:get/get.dart';
import '../screen/ActiveOn.dart';
import '../screen/AdmissionDate.dart';
import '../screen/Left_student.dart';
import '../screen/managestudent.dart';
import '../screen/student_skills_screen.dart';

class FilterController extends GetxController {
  RxString selectedFilter = 'All Student'.obs;
  Rx currentScreenIndex = 0.obs;

  void onFilterTap(String title) {
    print('🔵 Filter tapped: "$title"');
    print('🔵 Current route before: ${Get.currentRoute}');

    // Update the global selected filter
    selectedFilter.value = title;
    print('🔵 Selected filter updated to: $title');

    // Navigate based on filter type
    // if (title == 'All student') {
    //   print('🟢 Attempting to navigate to ManageStudent...');
    //   Get.to(() => ManageStudent());
    //   print('✅ Navigation to ManageStudent completed');
    // } else if (title == 'ActiveOn') {
    //   print('🟢 Attempting to navigate to ActiveOn...');
    //   Get.to(() => ActiveOn());
    //   print('✅ Navigation to ActiveOn completed');
    // } else if (title == 'Admission Date') {
    //   print('🟢 Attempting to navigate to Student_AdmissionDate_Screen...');
    //   Get.to(() => Student_AdmissionDate_Screen());
    //   print('✅ Navigation to Admission Date completed');
    // } else if (title == 'Leave Date') {
    //   print('🟢 Attempting to navigate to StudentLeftStudentScreen...');
    //   Get.to(() => StudentLeftStudentScreen());
    //   print('✅ Navigation to Leave Date completed');
    // } else if (title == 'Skills') {
    //   print('✅ Attempting to navigate to skills completed');
    //   Get.to(() => StudentSkillsScreen());
    //   print('✅ Navigation to Leave Date completed');
    // } else if (title == 'On leave') {
    //   // Get.to(() => OnLeave());
    //   print('⚠️ On leave screen not implemented yet');
    // }

    if (title == 'All student') {
      currentScreenIndex.value = 0; // Manage Student screen index
    } else if (title == 'ActiveOn') {
      currentScreenIndex.value = 1; // ActiveOn screen index
    } else if (title == 'Admission Date') {
      currentScreenIndex.value = 2; // Admission Date screen index
    } else if (title == 'Leave Date') {
      currentScreenIndex.value = 3; // Leave Date screen index
    } else if (title == 'Skills') {
      currentScreenIndex.value = 4; // Skills screen index
    }

    print('🔵 Current route after: ${Get.currentRoute}');
    print('🔵 Selected filter value: ${selectedFilter.value}');
  }
}
