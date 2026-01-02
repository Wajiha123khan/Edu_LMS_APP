import 'package:educorelms/controller/bottom_nav_controller.dart';
import 'package:educorelms/screen/ActiveOn.dart';
import 'package:educorelms/screen/AdmissionDate.dart';
import 'package:educorelms/screen/Left_student.dart';
import 'package:educorelms/screen/bottom_navbar_base/base_screen.dart';
import 'package:educorelms/screen/bottomnavbar.dart';
import 'package:educorelms/screen/draft_Screen.dart';
import 'package:educorelms/screen/managestudent.dart';
import 'package:educorelms/screen/StudentNavTab/student_profile.dart';
import 'package:educorelms/screen/student_skills_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/Bottom_navbar_base_controllers/base_controller.dart';
import 'controller/filter_controller.dart';

void main() {
  // Initialize GetX
  Get.put(FilterController()); // ← ADD THIS LINE
  Get.put(BaseController()); // ← Add this
  Get.put(BottomNavController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LMS APP',
      debugShowCheckedModeBanner: false,
      //home: Scaffold(bottomNavigationBar: BottomNavbar1()),
      home: BaseScreen(), // ✅ ONLY THIS
      //home: StudentProfile(),
      //home: BottomNavbar(),
      // home: StudentProfileDetail(),
      //home: ManageStudent(),
      //home: StudentSkillsScreen(),
      //home: Student_AdmissionDate_Screen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
