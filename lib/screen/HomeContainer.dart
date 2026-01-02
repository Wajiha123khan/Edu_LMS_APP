import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/filter_controller.dart';
import 'ActiveOn.dart';
import 'AdmissionDate.dart';
import 'Left_student.dart';
import 'draft_Screen.dart';
import 'managestudent.dart';

// class HomeContainer extends StatelessWidget {
//   HomeContainer({super.key});
//
//   final FilterController filterController = Get.put(FilterController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       switch (filterController.currentScreenIndex.value) {
//         case 0:
//           return DraftScreen(); // default Home screen
//         case 1:
//         //return ManageStudent();
//         case 2:
//         //return ActiveOn();
//         default:
//           return DraftScreen();
//       }
//     });
//   }
// }

class HomeContainer extends StatelessWidget {
  HomeContainer({super.key});

  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (filterController.currentScreenIndex.value) {
        case 0:
          return DraftScreen(); // Home
        case 1:
          return ManageStudent();
        case 2:
          return Student_AdmissionDate_Screen();
        //return ActiveOn();
        case 3:
          return StudentLeftStudentScreen();
        //return ActiveOn();
        case 4:
          return ActiveOn();
        //return StudentLeftStudentScreen();
        default:
          return DraftScreen();
      }
    });
  }
}
