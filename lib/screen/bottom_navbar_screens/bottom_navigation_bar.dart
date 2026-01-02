import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:lmseducore/presentation/screens/base_controller.dart';

import '../../controller/Bottom_navbar_base_controllers/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        indicatorColor: Theme.of(context).primaryColor,
        elevation: 10,
        selectedIndex: BaseController.to.currentIndex.value,
        onDestinationSelected: (value) => BaseController.to.changeIndex(value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_outlined, color: Colors.white),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
