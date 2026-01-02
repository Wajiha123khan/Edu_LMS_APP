import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/nav_ids.dart';

class ProfileDetailInnerpage extends StatelessWidget {
  const ProfileDetailInnerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.back(id: NavIds.profile)),
      ),
      body: Center(
        child: Text("this is profile inner page of Profile page wajiha "),
      ),
    );
  }
}
