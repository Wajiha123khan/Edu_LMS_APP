import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/nav_ids.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.back(id: NavIds.profile)),
      ),
      body: Center(
        child: Column(
          // added column to group widgets
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("this is original page like Profile page wajiha"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile/detail/innerpage', id: NavIds.profile);
              },
              child: Text("go to profile inner page detail man "),
            ),
          ],
        ),
      ),
    );
  }
}
