import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../controller/bottom_nav_controller.dart';
import '../utils/colors.dart';

class BottomNavbar1 extends StatelessWidget {
  BottomNavbar1({super.key});

  final BottomNavController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => SalomonBottomBar(
          backgroundColor: Colors.transparent,
          duration: const Duration(milliseconds: 500),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.group_add, color: Colors.white),
              title: const Text(
                'Manage',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.menu_book, color: Colors.white),
              title: const Text(
                'Courses',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.insert_drive_file, color: Colors.white),
              title: const Text('Files', style: TextStyle(color: Colors.white)),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.white,
            ),
          ],
          currentIndex: _controller.currentIndex.value,
          onTap: (index) => _controller.changeIndex(index),
          itemPadding: const EdgeInsets.all(8),
          curve: Curves.easeInOut,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}
