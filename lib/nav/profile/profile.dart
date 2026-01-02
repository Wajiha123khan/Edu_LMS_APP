import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:lmseducore/pages/profile.dart';
//import 'package:lmseducore/presentation/screens/profile_detail.dart';

import '../../const/nav_ids.dart';
//import '../../presentation/screens/profile_detail_inner page.dart';
import '../../pages/profile.dart';
import '../../screen/screen_draft/profile_detail.dart';
import '../../screen/screen_draft/profile_detail_inner page.dart';

class ProfileNav extends StatelessWidget {
  const ProfileNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.profile),
      onGenerateRoute: (settings) {
        if (settings.name == '/profile/detail') {
          return GetPageRoute(
            settings: settings,
            page: () => const ProfileDetail(),
          );
        } else if (settings.name == '/profile/detail/innerpage') {
          return GetPageRoute(
            settings: settings,
            page: () => ProfileDetailInnerpage(),
          );
        } else {
          return GetPageRoute(settings: settings, page: () => const Profile());
        }
        return null;
      },
    );
  }
}
