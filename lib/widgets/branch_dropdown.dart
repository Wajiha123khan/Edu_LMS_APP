import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/draft_controller.dart';
import '../utils/colors.dart';

class BranchDropdown extends StatelessWidget {
  final DraftController controller;

  const BranchDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown
            Container(
              height: 50,
              width: 270,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Select Branch Code",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.textDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 56,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 220,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  items: controller.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  value: controller.selectedValue.value.isEmpty
                      ? null
                      : controller.selectedValue.value,
                  onChanged: controller.onDropdownChanged,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Filter Button
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: controller.onFilterTap,
                  child: const Center(
                    child: Icon(Icons.sort, size: 26, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
