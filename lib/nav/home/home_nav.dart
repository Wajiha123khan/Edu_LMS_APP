import 'package:educorelms/screen/managestudent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:lmseducore/presentation/screens/home_detail.dart';

import '../../const/nav_ids.dart';
import '../../pages/home.dart';
import '../../screen/screen_draft/home_detail.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.home),
      onGenerateRoute: (settings) {
        if (settings.name == '/home_detail') {
          return GetPageRoute(
            settings: settings,
            page: () => const HomeDetail(),
          );
        } else {
          return GetPageRoute(settings: settings, page: () => ManageStudent());
        }
        return null;
      },
    );
  }
}
