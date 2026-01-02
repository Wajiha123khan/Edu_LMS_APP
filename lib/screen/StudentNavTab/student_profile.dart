import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/filter_controller.dart';
import '../../utils/colors.dart';
import '../ActiveOn.dart';
import '../../controller/managestudent_controller.dart';

class StudentProfile extends StatelessWidget {
  StudentProfile({super.key});

  final ManageStudentController controller = Get.put(ManageStudentController());

  // ================= PROFILE CARD =================
  Widget _buildProfileCard() {
    return Obx(() {
      final student = controller.selectedStudent;
      if (student.isEmpty) return const SizedBox();

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 40, // Reduced horizontal padding
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, // Centered content
          children: [
            // First letter avatar - EXACTLY like in the image
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.primary,
              child: Text(
                (student['name']?[0] ?? 'A')
                    .toUpperCase(), // Changed to uppercase like in image
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Name - CENTERED like in image
            Text(
              student['name'] ?? 'Aisha Rehman',
              textAlign: TextAlign.center, // Centered text
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),

            // Status badge - CENTERED
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                student['status'] ?? 'Active',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ================= INFO ROW =================
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ), // Adjusted vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600], // Slightly darker grey like in image
            ),
          ),
          const SizedBox(height: 6), // Increased spacing
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8), // Added spacing before divider
          const Divider(height: 1, color: Colors.grey), // Lighter divider
        ],
      ),
    );
  }

  // ================= GENERAL INFO CARD (SCROLLABLE) =================
  Widget _buildGeneralInfoCard() {
    return Obx(() {
      final student = controller.selectedStudent;
      if (student.isEmpty) return const SizedBox();

      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
        ), // Match profile card margin
        padding: const EdgeInsets.all(24), // Increased padding like in image
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title - matches the blue color and style from image
            Text(
              "General Information",
              style: GoogleFonts.poppins(
                fontSize: 18, // Slightly larger
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20), // Increased spacing
            // Info rows - NO fixed height, auto expand
            Column(
              children: [
                _infoRow("Email", student['email'] ?? 'aisha@edu.com'),
                _infoRow("Phone", student['phone'] ?? '555-1234'),
                _infoRow("Student ID", student['id']?.toString() ?? 'N/A'),
                _infoRow(
                  "Class ID",
                  student['classId']?.toString() ?? '300091',
                ),
                _infoRow("Status", student['status'] ?? 'Active'),
              ],
            ),
          ],
        ),
      );
    });
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightBlue,
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () => Get.back(),
            ),
          ),
          body: Stack(
            children: [
              // Background - matches second image styling
              Container(
                height: 220, // Reduced height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/backgroundpic.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.lightBlue.withOpacity(0.85), // Less opacity
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              ),

              // CONTENT
              Column(
                children: [
                  const SizedBox(height: 10), // Reduced top spacing
                  // HEADER - EXACTLY like second image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28, // Slightly smaller
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "Hello" text - smaller and grey like in image
                            Text(
                              "Hello",
                              style: GoogleFonts.poppins(
                                fontSize: 14, // Smaller
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700], // Darker grey
                              ),
                            ),
                            // Name text - exactly like in second image
                            Text(
                              "J.J Thomson!",
                              style: GoogleFonts.poppins(
                                fontSize: 16, // Larger and bold
                                fontWeight: FontWeight.w700, // Bold
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10), // Reduced spacing
                  // PAGE SCROLL - Adjusted spacing
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(), // Smoother scrolling
                      child: Column(
                        children: [
                          _buildProfileCard(),
                          const SizedBox(height: 10), // REDUCED from 16 to 10
                          _buildGeneralInfoCard(),
                          const SizedBox(height: 30),
                        ],
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
