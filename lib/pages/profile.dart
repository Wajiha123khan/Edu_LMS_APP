import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/nav_ids.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/profile/detail', id: NavIds.profile);
          },
          child: Text("go to profile detail"),
        ),
      ),
    );
  }
}
