import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lmseducore/const/nav_ids.dart';

import '../const/nav_ids.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/home_detail', id: NavIds.home);
          },
          child: Text("go to home detail"),
        ),
      ),
    );
  }
}
