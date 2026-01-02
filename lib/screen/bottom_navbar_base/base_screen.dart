import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:lmseducore/nav/home/home_nav.dart';
//import 'package:lmseducore/nav/profile/profile.dart';
//import 'package:lmseducore/presentation/screens/bottom_navigation_bar.dart';

import '../../controller/Bottom_navbar_base_controllers/base_controller.dart';
import '../../controller/bottom_nav_controller.dart';
import '../../controller/filter_controller.dart';
import '../../nav/home/home_nav.dart';
import '../../nav/profile/profile.dart';
import '../ActiveOn.dart';
import '../AdmissionDate.dart';
import '../HomeContainer.dart';
import '../Left_student.dart';
import '../StudentNavTab/CoursesScreen.dart';
import '../StudentNavTab/FilesScreen.dart';
import '../StudentNavTab/ManageStudent.dart';
import '../StudentNavTab/student_profile.dart';
import '../bottom_navbar_screens/bottom_navigation_bar.dart';
import '../bottomnavbar.dart';
import '../managestudent.dart';
import '../student_skills_screen.dart';
// import 'base_controller.dart';

// class BaseScreen extends StatelessWidget {
//   const BaseScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true, // ✅ THIS LINE REMOVES WHITE BACKGROUND
//       body: Obx(
//         () => IndexedStack(
//           index: BaseController.to.currentIndex.value,
//           children: const [HomeNav(), ProfileNav()],
//         ),
//       ),
//       bottomNavigationBar: BottomNavbar1(),
//     );
//   }
// }

// class BaseScreen extends StatelessWidget {
//   const BaseScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final FilterController filterController = Get.find<FilterController>();
//
//     return Scaffold(
//       extendBody: true,
//       body: Obx(() {
//         // Get the current screen based on filter selection
//         Widget currentScreen;
//         switch (filterController.currentScreenIndex.value) {
//           case 0:
//             currentScreen = ManageStudent();
//             break;
//           case 1:
//             currentScreen = ActiveOn();
//             break;
//           case 2:
//             currentScreen = Student_AdmissionDate_Screen();
//             break;
//           case 3:
//             currentScreen = StudentLeftStudentScreen();
//             break;
//           case 4:
//             currentScreen = StudentSkillsScreen();
//             break;
//           default:
//             currentScreen = ManageStudent();
//         }
//
//         return currentScreen;
//       }),
//       bottomNavigationBar: BottomNavbar1(),
//     );
//   }
// }

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController navController = Get.find();

    return Scaffold(
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: navController.currentIndex.value,
          children: [
            HomeContainer(), // Home tab
            Managestudent(), // Manage tab
            Coursesscreen(),
            Filesscreen(),
            StudentProfile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar1(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/bottom_nav_controller.dart';
// import '../HomeContainer.dart';
// import '../StudentNavTab/student_profile.dart';
// import '../bottomnavbar.dart';
//
// class BaseScreen extends StatelessWidget {
//   const BaseScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController navController = Get.find();
//
//     return Scaffold(
//       extendBody: true,
//       body: Obx(() {
//         // Get the current index
//         int index = navController.currentIndex.value;
//
//         // Map indices to screens
//         if (index == 0) {
//           return HomeContainer();
//         } else if (index == 1) {
//           // Return your Manage screen here
//           return Container(child: Text("Manage Screen"));
//         } else if (index == 2) {
//           // Return your Courses screen here
//           return Container(child: Text("Courses Screen"));
//         } else if (index == 3) {
//           // Return your Files screen here
//           return Container(child: Text("Files Screen"));
//         } else if (index == 4) {
//           // Profile screen - show StudentProfile
//           return StudentProfile();
//         } else {
//           return HomeContainer();
//         }
//       }),
//       bottomNavigationBar: BottomNavbar1(),
//     );
//   }
// }
