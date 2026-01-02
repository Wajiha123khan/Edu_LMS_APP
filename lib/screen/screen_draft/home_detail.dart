import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/nav_ids.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({super.key});

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.back(id: NavIds.home)),
      ),
      body: Center(child: Text("this is oroginal page like Home page wajiha ")),
    );
  }
}
