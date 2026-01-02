import 'dart:convert';
import 'package:get/get.dart';
//import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../model/student.dart';

class DataController extends GetxController {
  var studentList = <Student_Model_List>[].obs;
  var isDataloading = true.obs;

  getUserInformationFromApi() async {
    try {
      isDataloading(true);

      final response = await http.get(
        Uri.parse(
          'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
          //'http://192.168.18.106/portal_dashbaord/admin_dashboard/admin_dashboard_api/student_list_api.php',
        ),
      );

      print(response.body); // DEBUG

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // if API returns LIST
        studentList.assignAll(
          List<Student_Model_List>.from(
            result.map((x) => Student_Model_List.fromJson(x)),
          ),
        );

        // if API returns {data: []}
        // final List list = result['data'];
        // studentList.assignAll(
        //   list.map((x) => Student_Model_List.fromJson(x)).toList(),
        // );
      }
    } catch (e) {
      print("API Error: $e");
    } finally {
      isDataloading(false);
    }
  }
}
