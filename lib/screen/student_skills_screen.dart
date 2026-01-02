import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/filter_controller.dart';
import '../controller/student_skills_controller.dart';
import '../utils/colors.dart';

class StudentSkillsScreen extends StatelessWidget {
  StudentSkillsScreen({super.key});

  final StudentSkillsController controller = Get.put(StudentSkillsController());
  final ScrollController _scrollController = ScrollController();
  final ScrollController _cardScrollController = ScrollController();
  final FilterController filterController = Get.find<FilterController>();

  // Builds the individual filter card
  Widget _buildFilterCard(String title) {
    return Obx(() {
      final bool isActive = title == filterController.selectedFilter.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () => filterController.onFilterTap(title),
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

  // Navigation for horizontal scroll
  void _scrollBackward() {
    if (_cardScrollController.hasClients) {
      final double currentOffset = _cardScrollController.offset;
      final double screenWidth = Get.width - 80;
      final double newOffset = currentOffset - screenWidth * 0.5;

      _cardScrollController.animateTo(
        newOffset.clamp(0.0, _cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollForward() {
    if (_cardScrollController.hasClients) {
      final double currentOffset = _cardScrollController.offset;
      final double screenWidth = Get.width - 80;
      final double newOffset = currentOffset + screenWidth * 0.5;

      _cardScrollController.animateTo(
        newOffset.clamp(0.0, _cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Builds the entire horizontal list with navigation arrows
  Widget _buildCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: _scrollBackward,
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
              child: Obx(
                () => ListView.builder(
                  controller: _cardScrollController,
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
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _scrollForward,
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

  // Builds the table header
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
              flex: 30,
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
            Expanded(
              flex: 35,
              child: Text(
                'Skills',
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

  // Builds skill badge widget - FIXED: Removed duplicate method
  Widget _buildSkillBadge(String skill) {
    final color = controller.getSkillColor(skill);

    return Container(
      margin: EdgeInsets.only(right: 4, bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  // Builds individual table row
  Widget _buildTableRow(Map<String, dynamic> student, int index) {
    List<String> skills = List<String>.from(student['skills']);

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
              flex: 30,
              child: Row(
                children: [
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
                        student['name'][0],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          student['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
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
            Expanded(
              flex: 15,
              child: Text(
                student['id'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 20,
              child: Text(
                student['branchCode'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 35,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: skills
                      .map((skill) => _buildSkillBadge(skill))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                SizedBox(height: 60),
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
                                          color: AppColors.textDark.withOpacity(
                                            0.7,
                                          ),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
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
                                onChanged: controller.onBranchChanged,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Search Dropdown
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
                                          color: AppColors.textDark.withOpacity(
                                            0.7,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 56,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value: controller.selectedValue.value,
                                onChanged: controller.onBranchChanged,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
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
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              print('Filter button tapped');
                            },
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
                      vertical: 20,
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
                          // Table Title with Skill Search Dropdown
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                              bottom: 15,
                            ),
                            child: Obx(
                              () => Row(
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
                                  Container(
                                    width: 160,
                                    height: 45,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                "Search Skills",
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
                                          height: 45,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(0.3),
                                              width: 1.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.05,
                                                ),
                                                blurRadius: 8,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 250,
                                          width: 180,
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 12,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: null,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                              child: Text(
                                                'All Skills',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: AppColors.textDark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ...controller.skillOptions.map((
                                            String skill,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: skill,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                            .getSkillColor(
                                                              skill,
                                                            ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      skill,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .textDark,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ].toList(),
                                        value: controller
                                            .selectedSkillFilter
                                            .value,
                                        onChanged:
                                            controller.onSkillFilterChanged,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Show filter status
                          Obx(() {
                            if (controller.selectedSkillFilter.value == null ||
                                controller.selectedSkillFilter.value!.isEmpty) {
                              return SizedBox.shrink();
                            }

                            final filteredCount =
                                controller.filteredStudents.length;
                            final skill = controller.selectedSkillFilter.value!;
                            final color = controller.getSkillColor(skill);

                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Filtered by: ',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            skill,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: controller.clearSkillFilter,
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: AppColors.textDark
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '($filteredCount students)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textDark.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
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
                                final filteredStudents =
                                    controller.filteredStudents;

                                if (filteredStudents.isEmpty &&
                                    controller.selectedSkillFilter.value !=
                                        null) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          size: 60,
                                          color: Colors.grey[400],
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'No students found with "${controller.selectedSkillFilter.value}" skill',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return Column(
                                  children: [
                                    _buildTableHeader(),
                                    Expanded(
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        thumbVisibility: true,
                                        thickness: 6,
                                        radius: Radius.circular(10),
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          itemCount: filteredStudents.length,
                                          itemBuilder: (context, index) {
                                            return _buildTableRow(
                                              filteredStudents[index],
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
    );
  }
}
