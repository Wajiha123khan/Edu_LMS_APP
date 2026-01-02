import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

// GetX Controller to hold columns reactively
class TableHeaderController extends GetxController {
  var columns = <TableColumn>[].obs;

  // Method to update columns list
  void setColumns(List<TableColumn> newColumns) {
    columns.value = newColumns;
  }
}

// Widget now listens to controller's columns reactively
class TableHeaderWidget extends StatelessWidget {
  TableHeaderWidget({Key? key, required List<TableColumn> columns})
    : super(key: key);

  final TableHeaderController controller = Get.put(TableHeaderController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.3),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Row(
            children: controller.columns.map((column) {
              return Expanded(
                flex: column.flex,
                child: column.paddingLeft
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          column.title,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Text(
                        column.title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        textAlign: column.textAlign,
                        overflow: TextOverflow.ellipsis,
                      ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class TableColumn {
  final String title;
  final int flex;
  final TextAlign textAlign;
  final bool paddingLeft;

  const TableColumn({
    required this.title,
    required this.flex,
    this.textAlign = TextAlign.center,
    this.paddingLeft = false,
  });
}
