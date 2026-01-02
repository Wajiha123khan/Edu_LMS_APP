// controllers/bottom_nav_controller.dart
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
