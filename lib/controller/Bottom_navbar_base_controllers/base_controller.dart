import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  var currentIndex = 0.obs;

  void changeIndex(int newIndex) {
    if (currentIndex.value != newIndex) {
      Get.nestedKey(
        currentIndex.value,
      )?.currentState?.popUntil((route) => route.isFirst);
      currentIndex.value = newIndex;
    }
  }
}
