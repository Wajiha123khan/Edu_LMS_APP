import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/data_controller.dart';
//import 'package:get/get_core/src/get_main.dart';;

class Apiscreen extends StatefulWidget {
  const Apiscreen({super.key});

  @override
  State<Apiscreen> createState() => _ApiscreenState();
}

class _ApiscreenState extends State<Apiscreen> {
  final DataController dataController = Get.put(DataController());

  static const String baseImageUrl =
      'http://192.168.18.106/portal_dashbaord/uploads/';

  @override
  void initState() {
    super.initState();
    dataController.getUserInformationFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students")),
      body: Obx(() {
        if (dataController.isDataloading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (dataController.studentList.isEmpty) {
          return const Center(child: Text("No data found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: dataController.studentList.length,
          itemBuilder: (ctx, i) {
            final student = dataController.studentList[i];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      student.studentImage != null &&
                          student.studentImage!.isNotEmpty
                      ? NetworkImage(baseImageUrl + student.studentImage!)
                      : null,
                  child: student.studentImage == null
                      ? const Icon(Icons.person)
                      : null,
                ),

                // STUDENT NAME
                title: Text(
                  student.studentName ?? 'No Name',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                // DETAILS
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    Text("SNO: ${student.sno ?? '-'}"),
                    Text("Email: ${student.email ?? '-'}"),
                    Text("Branch: ${student.branch ?? '-'}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
