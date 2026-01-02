import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/filter_controller.dart';
import '../utils/colors.dart';
import 'ActiveOn.dart';
import '../controller/managestudent_controller.dart';

class ManageStudent extends StatelessWidget {
  ManageStudent({super.key});

  final FilterController filterController = Get.find<FilterController>();

  final ManageStudentController controller = Get.put(ManageStudentController());

  // Builds the individual filter card
  Widget _buildFilterCard(String title) {
    return Obx(() {
      final bool isActive = title == filterController.selectedFilter.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            // ✅ Call the FilterController's method instead of Get.to()
            Get.find<FilterController>().onFilterTap(title);
          },
          // onTap: () => filterController.onFilterTap(title),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isActive
                  ? null
                  : Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1.0,
                    ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Builds the entire horizontal list with navigation arrows
  Widget _buildCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.scrollBackward,
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.textDark.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                controller: controller.cardScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: controller.studentFilterOptions.length,
                itemBuilder: (context, index) {
                  return _buildFilterCard(
                    controller.studentFilterOptions[index],
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: controller.scrollForward,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.textDark.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the table header with better column management
  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.3),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Student Name',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Text(
                'ID',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 20,
              child: Text(
                'Branch',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Expanded(
            //   flex: 15,
            //   child: Text(
            //     'Status',
            //     style: GoogleFonts.poppins(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.primary,
            //     ),
            //     textAlign: TextAlign.center,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            Expanded(
              flex: 15,
              child: Text(
                'Actions',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds individual table row with better column management
  // Builds individual table row with better column management
  Widget _buildTableRow(Map<String, dynamic> student, int index) {
    return Container(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              flex: 35,
              child: Row(
                children: [
                  // Student Avatar - using first letter of name
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBlue,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        student['name'].isNotEmpty ? student['name'][0] : '?',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Student Name with email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          student['name'] ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        if (student['email'] != null &&
                            student['email'].isNotEmpty)
                          Text(
                            student['email'],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: AppColors.textDark.withOpacity(0.6),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Student ID
            Expanded(
              flex: 15,
              child: Text(
                student['id']?.toString() ?? 'N/A',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Branch
            Expanded(
              flex: 20,
              child: Text(
                student['branchCode'] ?? 'N/A',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Status
            // Expanded(
            //   flex: 15,
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 2),
            //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     decoration: BoxDecoration(
            //       color: controller
            //           .getStatusColor(student['status'])
            //           .withOpacity(0.1),
            //       borderRadius: BorderRadius.circular(12),
            //       border: Border.all(
            //         color: controller
            //             .getStatusColor(student['status'])
            //             .withOpacity(0.3),
            //         width: 1,
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         student['status'] ?? 'Unknown',
            //         style: GoogleFonts.poppins(
            //           fontSize: 10,
            //           fontWeight: FontWeight.w500,
            //           color: controller.getStatusColor(student['status'] ?? ''),
            //         ),
            //         textAlign: TextAlign.center,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ),
            // ),
            // Actions - FIXED: Added constraints and reduced button sizes
            Expanded(
              flex: 15,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 60,
                ), // Add max width constraint
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Use min size
                  children: [
                    // Edit button - reduced size
                    GestureDetector(
                      onTap: () => controller.onEditStudent(student),
                      child: Container(
                        width: 24, // Reduced from 28
                        height: 24, // Reduced from 28
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 12, // Reduced from 14
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4), // Reduced from 6
                    // Delete button - reduced size
                    GestureDetector(
                      onTap: () => controller.onDeleteStudent(student),
                      child: Container(
                        width: 24, // Reduced from 28
                        height: 24, // Reduced from 28
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            size: 12, // Reduced from 14
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Loading widget
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Loading students...',
            style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  // Error widget
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red),
          SizedBox(height: 16),
          Obx(
            () => Text(
              controller.errorMessage.value,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.refreshData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 60, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No students found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add some students to get started',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        filterController.currentScreenIndex.value = 0;
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                filterController.currentScreenIndex.value = 0;
              },
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
            ),
          ),
          backgroundColor: AppColors.lightBlue,
          body: Stack(
            children: [
              // Background Image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/backgroundpic.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.lightBlue.withOpacity(0.91),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              ),
              // Main Content
              Column(
                children: [
                  SizedBox(height: 9),
                  // Header with Logo and Branch Dropdown
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          // Logo
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image, size: 24),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          // Greeting Text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hello",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                "PixxelHouse!",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          // Branch Dropdown
                          Container(
                            width: 130,
                            height: 50,
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Branch",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: AppColors.textDark
                                                .withOpacity(0.7),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 160,
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 12,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  items: controller.items.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          item,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: AppColors.textDark,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: controller.selectedValue.value,
                                  onChanged: (String? value) {
                                    controller.selectedValue.value = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Page Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Manage",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Students",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 27),
                  // Search and Filter Section
                  // Search and Filter Section - FIXED: Added Expanded to prevent overflow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Search Dropdown - FIXED: Wrapped in Expanded
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Search by ID & Name",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: AppColors.textDark
                                                .withOpacity(0.7),
                                          ),
                                          overflow:
                                              TextOverflow.ellipsis, // Add this
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    height: 56,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
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
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  items: controller.items.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        child: Text(
                                          item,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: AppColors.textDark,
                                          ),
                                          overflow:
                                              TextOverflow.ellipsis, // Add this
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: controller.selectedValue.value,
                                  onChanged: (String? value) {
                                    controller.selectedValue.value = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Filter Button - FIXED: Added fixed width
                        Container(
                          height: 50,
                          width: 50,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                print('Filter button tapped');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.sort,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  // Filter Cards
                  _buildCardList(),
                  SizedBox(height: 15),
                  // Student Records Table
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Table Title with Refresh Button
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Student Records",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  // Refresh Button
                                  Obx(
                                    () => Row(
                                      children: [
                                        if (controller.errorMessage.isNotEmpty)
                                          Text(
                                            'Error Loading Data',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.red,
                                            ),
                                          ),
                                        IconButton(
                                          onPressed: () =>
                                              controller.refreshData(),
                                          icon: Icon(
                                            Icons.refresh,
                                            color: AppColors.primary,
                                          ),
                                          tooltip: 'Refresh',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Table Container
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Obx(() {
                                  if (controller.isDataLoading.value) {
                                    return _buildLoadingWidget();
                                  }

                                  if (controller.errorMessage.isNotEmpty) {
                                    return _buildErrorWidget();
                                  }

                                  if (controller.filteredStudents.isEmpty) {
                                    return _buildEmptyWidget();
                                  }

                                  return Column(
                                    children: [
                                      _buildTableHeader(),
                                      Expanded(
                                        child: Scrollbar(
                                          controller:
                                              controller.scrollController,
                                          thumbVisibility: true,
                                          thickness: 6,
                                          radius: Radius.circular(10),
                                          child: ListView.builder(
                                            controller:
                                                controller.scrollController,
                                            itemCount: controller
                                                .filteredStudents
                                                .length,
                                            itemBuilder: (context, index) {
                                              return _buildTableRow(
                                                controller
                                                    .filteredStudents[index],
                                                index,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            // Add New Student Button
                            // Add New Student Button
                            // Add New Student Button
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 40,
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () => controller
                                          .onAddNewStudent(), // FIXED: Added parentheses
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primary,
                                              AppColors.primary.withOpacity(
                                                0.8,
                                              ),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'New Student',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
