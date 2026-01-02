import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../utils/colors.dart';
import '../controller/managestudent_controller.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final ManageStudentController controller =
      Get.find<ManageStudentController>();
  final _formKey = GlobalKey<FormState>();
  //final ImagePicker _picker = ImagePicker();

  // Form controllers
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherEmailController = TextEditingController();
  final TextEditingController _fatherContactController =
      TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _portalEmailController = TextEditingController();
  final TextEditingController _portalPasswordController =
      TextEditingController();
  final TextEditingController _studentContactController =
      TextEditingController();
  final TextEditingController _emergencyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quliController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _studentJoinDateController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  File? _selectedImage;
  bool _isSubmitting = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    // Set default values
    _countryController.text = 'Pakistan';
    _countryCodeController.text = '+92';
    _cityController.text = 'Karachi';
    _studentJoinDateController.text = DateTime.now().toIso8601String().split(
      'T',
    )[0];
  }

  @override
  void dispose() {
    // Dispose all controllers
    _studentNameController.dispose();
    _fatherNameController.dispose();
    _fatherEmailController.dispose();
    _fatherContactController.dispose();
    _studentEmailController.dispose();
    _portalEmailController.dispose();
    _portalPasswordController.dispose();
    _studentContactController.dispose();
    _emergencyController.dispose();
    _addressController.dispose();
    _quliController.dispose();
    _courseController.dispose();
    _batchController.dispose();
    _branchIdController.dispose();
    _dateOfBirthController.dispose();
    _studentJoinDateController.dispose();
    _countryController.dispose();
    _countryCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'http://192.168.15.2/portal_dashbaord/admin_dashboard/admin_dashboard_api/add_student_api.php',
        ),
      );

      // Add form fields - EXACTLY as your API expects
      request.fields['student_name'] = _studentNameController.text.trim();
      request.fields['father_name'] = _fatherNameController.text.trim();
      request.fields['father_email'] = _fatherEmailController.text.trim();
      request.fields['father_contact'] = _fatherContactController.text.trim();
      request.fields['student_email'] = _studentEmailController.text.trim();
      request.fields['portal_email'] = _portalEmailController.text.trim();
      request.fields['portal_password'] = _portalPasswordController.text;
      request.fields['student_contact'] = _studentContactController.text.trim();
      request.fields['emergency'] = _emergencyController.text.trim();
      request.fields['gender'] = _selectedGender ?? 'Male';
      request.fields['address'] = _addressController.text.trim();
      request.fields['quli'] = _quliController.text.trim();
      request.fields['date_of_birth'] = _dateOfBirthController.text.trim();
      request.fields['student_join_date'] = _studentJoinDateController.text
          .trim();
      request.fields['course'] = _courseController.text.trim();
      request.fields['batch'] = _batchController.text.trim();
      request.fields['branch_id'] = _branchIdController.text.trim();
      request.fields['country'] = _countryController.text.trim();
      request.fields['country_code'] = _countryCodeController.text.trim();
      request.fields['city'] = _cityController.text.trim();

      // Send request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Add Student API Response: ${response.statusCode}');
      print('Add Student API Body: $responseBody');

      if (response.statusCode == 200) {
        final result = jsonDecode(responseBody);

        if (result['success'] == true) {
          setState(() {
            _successMessage =
                result['message'] ?? 'Student added successfully!';
          });

          // Clear form
          _formKey.currentState!.reset();
          setState(() {
            _selectedGender = null;
            _selectedImage = null;
            // Reset default values
            _countryController.text = 'Pakistan';
            _countryCodeController.text = '+92';
            _cityController.text = 'Karachi';
            _studentJoinDateController.text = DateTime.now()
                .toIso8601String()
                .split('T')[0];
          });

          // Refresh student list after delay
          Future.delayed(Duration(seconds: 2), () {
            controller.refreshData();
            Get.back();
          });
        } else {
          setState(() {
            _errorMessage = result['message'] ?? 'Failed to add student';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      print("Add Student Error: $e");
      setState(() {
        _errorMessage = 'Failed to add student: $e';
      });
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool required = true,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label${required ? ' *' : ''}',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: validator,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Stack(
        children: [
          // Background Image - Same as ManageStudent
          Container(
            height: 220,
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
              SizedBox(height: MediaQuery.of(context).padding.top),
              // App Bar with Back Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 40,
                        height: 40,
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
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Add New Student",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Spacer(),
                    // Logo - Same as ManageStudent
                    Container(
                      width: 45,
                      height: 45,
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
                              child: Icon(Icons.image, size: 20),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Form Container - Same style as ManageStudent table
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Error/Success Messages
                            if (_errorMessage != null)
                              Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _errorMessage!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            if (_successMessage != null)
                              Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.green.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _successMessage!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Student Name
                            _buildTextField(
                              label: 'Student Name',
                              controller: _studentNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter student name';
                                }
                                return null;
                              },
                            ),

                            // Father Name
                            _buildTextField(
                              label: 'Father Name',
                              controller: _fatherNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter father name';
                                }
                                return null;
                              },
                            ),

                            // Father Email
                            _buildTextField(
                              label: 'Father Email',
                              controller: _fatherEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter father email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),

                            // Father Contact
                            _buildTextField(
                              label: 'Father Contact',
                              controller: _fatherContactController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter father contact';
                                }
                                return null;
                              },
                            ),

                            // Student Email
                            _buildTextField(
                              label: 'Student Email',
                              controller: _studentEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter student email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),

                            // Portal Email
                            _buildTextField(
                              label: 'Portal Email',
                              controller: _portalEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter portal email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),

                            // Portal Password
                            _buildTextField(
                              label: 'Portal Password',
                              controller: _portalPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter portal password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              hintText: 'Minimum 6 characters',
                            ),

                            // Student Contact
                            _buildTextField(
                              label: 'Student Contact',
                              controller: _studentContactController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter student contact';
                                }
                                return null;
                              },
                            ),

                            // Emergency Contact
                            _buildTextField(
                              label: 'Emergency Contact',
                              controller: _emergencyController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter emergency contact';
                                }
                                return null;
                              },
                            ),

                            // Date of Birth with Date Picker
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date of Birth *',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _dateOfBirthController,
                                  readOnly: true,
                                  onTap: () => _selectDate(
                                    context,
                                    _dateOfBirthController,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'YYYY-MM-DD',
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        size: 20,
                                      ),
                                      onPressed: () => _selectDate(
                                        context,
                                        _dateOfBirthController,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select date of birth';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),

                            // Student Join Date with Date Picker
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Student Join Date *',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _studentJoinDateController,
                                  readOnly: true,
                                  onTap: () => _selectDate(
                                    context,
                                    _studentJoinDateController,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'YYYY-MM-DD',
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        size: 20,
                                      ),
                                      onPressed: () => _selectDate(
                                        context,
                                        _studentJoinDateController,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select join date';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),

                            // Gender Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender *',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  items: _genderOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select gender';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),

                            // Address
                            _buildTextField(
                              label: 'Address',
                              controller: _addressController,
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                            ),

                            // Qualification (quli)
                            _buildTextField(
                              label: 'Qualification (Quli)',
                              controller: _quliController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter qualification';
                                }
                                return null;
                              },
                            ),

                            // Course
                            _buildTextField(
                              label: 'Course',
                              controller: _courseController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter course';
                                }
                                return null;
                              },
                            ),

                            // Batch ID
                            _buildTextField(
                              label: 'Batch ID',
                              controller: _batchController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter batch ID';
                                }
                                return null;
                              },
                            ),

                            // Branch ID
                            _buildTextField(
                              label: 'Branch ID',
                              controller: _branchIdController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter branch ID';
                                }
                                return null;
                              },
                            ),

                            // Country
                            _buildTextField(
                              label: 'Country',
                              controller: _countryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country';
                                }
                                return null;
                              },
                            ),

                            // Country Code
                            _buildTextField(
                              label: 'Country Code',
                              controller: _countryCodeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country code';
                                }
                                return null;
                              },
                            ),

                            // City
                            _buildTextField(
                              label: 'City',
                              controller: _cityController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            // Submit Button - Same style as New Student button
                            Container(
                              height: 45,
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: _isSubmitting ? null : _submitForm,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.primary.withOpacity(0.8),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(
                                            0.3,
                                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (_isSubmitting)
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        else
                                          Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        SizedBox(width: _isSubmitting ? 12 : 8),
                                        Text(
                                          _isSubmitting
                                              ? 'Adding...'
                                              : 'Add Student',
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

                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import '../utils/colors.dart';
// import '../controller/managestudent_controller.dart';
//
// class AddStudentScreen extends StatefulWidget {
//   const AddStudentScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddStudentScreenState createState() => _AddStudentScreenState();
// }
//
// class _AddStudentScreenState extends State<AddStudentScreen> {
//   final ManageStudentController controller =
//       Get.find<ManageStudentController>();
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//
//   // Form controllers
//   final TextEditingController _studentNameController = TextEditingController();
//   final TextEditingController _fatherNameController = TextEditingController();
//   final TextEditingController _fatherEmailController = TextEditingController();
//   final TextEditingController _fatherContactController =
//       TextEditingController();
//   final TextEditingController _studentEmailController = TextEditingController();
//   final TextEditingController _portalEmailController = TextEditingController();
//   final TextEditingController _portalPasswordController =
//       TextEditingController();
//   final TextEditingController _studentContactController =
//       TextEditingController();
//   final TextEditingController _emergencyController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _quliController = TextEditingController();
//   final TextEditingController _courseController = TextEditingController();
//   final TextEditingController _batchController = TextEditingController();
//   final TextEditingController _branchIdController = TextEditingController();
//   final TextEditingController _dateOfBirthController = TextEditingController();
//   final TextEditingController _studentJoinDateController =
//       TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _countryCodeController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//
//   String? _selectedGender;
//   final List<String> _genderOptions = ['Male', 'Female', 'Other'];
//
//   File? _selectedImage;
//   bool _isSubmitting = false;
//   String? _errorMessage;
//   String? _successMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set default values
//     _countryController.text = 'Pakistan';
//     _countryCodeController.text = '+92';
//     _cityController.text = 'Karachi';
//     _studentJoinDateController.text = DateTime.now().toIso8601String().split(
//       'T',
//     )[0];
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers
//     _studentNameController.dispose();
//     _fatherNameController.dispose();
//     _fatherEmailController.dispose();
//     _fatherContactController.dispose();
//     _studentEmailController.dispose();
//     _portalEmailController.dispose();
//     _portalPasswordController.dispose();
//     _studentContactController.dispose();
//     _emergencyController.dispose();
//     _addressController.dispose();
//     _quliController.dispose();
//     _courseController.dispose();
//     _batchController.dispose();
//     _branchIdController.dispose();
//     _dateOfBirthController.dispose();
//     _studentJoinDateController.dispose();
//     _countryController.dispose();
//     _countryCodeController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }
//
//   // Future<void> _pickImage() async {
//   //   try {
//   //     final XFile? image = await _picker.pickImage(
//   //       source: ImageSource.gallery,
//   //       imageQuality: 85,
//   //     );
//   //
//   //     if (image != null) {
//   //       setState(() {
//   //         _selectedImage = File(image.path);
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print("Image picker error: $e");
//   //     setState(() {
//   //       _errorMessage = 'Failed to pick image: $e';
//   //     });
//   //   }
//   // }
//
//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     // if (_selectedImage == null) {
//     //   setState(() {
//     //     _errorMessage = 'Student image is required!';
//     //   });
//     //   return;
//     // }
//
//     setState(() {
//       _isSubmitting = true;
//       _errorMessage = null;
//       _successMessage = null;
//     });
//
//     try {
//       // Create multipart request
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           'http://192.168.15.31/portal_dashbaord/admin_dashboard/admin_dashboard_api/add_student_api.php',
//         ),
//       );
//
//       // // Add image file
//       // request.files.add(
//       //   await http.MultipartFile.fromPath('image', _selectedImage!.path),
//       // );
//
//       // Add form fields - EXACTLY as your API expects
//       request.fields['student_name'] = _studentNameController.text.trim();
//       request.fields['father_name'] = _fatherNameController.text.trim();
//       request.fields['father_email'] = _fatherEmailController.text.trim();
//       request.fields['father_contact'] = _fatherContactController.text.trim();
//       request.fields['student_email'] = _studentEmailController.text.trim();
//       request.fields['portal_email'] = _portalEmailController.text.trim();
//       request.fields['portal_password'] = _portalPasswordController.text;
//       request.fields['student_contact'] = _studentContactController.text.trim();
//       request.fields['emergency'] = _emergencyController.text.trim();
//       request.fields['gender'] = _selectedGender ?? 'Male';
//       request.fields['address'] = _addressController.text.trim();
//       request.fields['quli'] = _quliController.text.trim();
//       request.fields['date_of_birth'] = _dateOfBirthController.text.trim();
//       request.fields['student_join_date'] = _studentJoinDateController.text
//           .trim();
//       request.fields['course'] = _courseController.text.trim();
//       request.fields['batch'] = _batchController.text.trim();
//       request.fields['branch_id'] = _branchIdController.text.trim();
//       request.fields['country'] = _countryController.text.trim();
//       request.fields['country_code'] = _countryCodeController.text.trim();
//       request.fields['city'] = _cityController.text.trim();
//
//       // Send request
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//
//       print('Add Student API Response: ${response.statusCode}');
//       print('Add Student API Body: $responseBody');
//
//       if (response.statusCode == 200) {
//         final result = jsonDecode(responseBody);
//
//         if (result['success'] == true) {
//           setState(() {
//             _successMessage =
//                 result['message'] ?? 'Student added successfully!';
//           });
//
//           // Clear form
//           _formKey.currentState!.reset();
//           setState(() {
//             _selectedGender = null;
//             _selectedImage = null;
//             // Reset default values
//             _countryController.text = 'Pakistan';
//             _countryCodeController.text = '+92';
//             _cityController.text = 'Karachi';
//             _studentJoinDateController.text = DateTime.now()
//                 .toIso8601String()
//                 .split('T')[0];
//           });
//
//           // Refresh student list after delay
//           Future.delayed(Duration(seconds: 2), () {
//             controller.refreshData();
//             Get.back();
//           });
//         } else {
//           setState(() {
//             _errorMessage = result['message'] ?? 'Failed to add student';
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Server error: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       print("Add Student Error: $e");
//       setState(() {
//         _errorMessage = 'Failed to add student: $e';
//       });
//     } finally {
//       setState(() {
//         _isSubmitting = false;
//       });
//     }
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     bool required = true,
//     String? hintText,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label${required ? ' *' : ''}',
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: AppColors.textDark,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             hintText: hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: AppColors.primary),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//           validator: validator,
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
//
//   Future<void> _selectDate(
//     BuildContext context,
//     TextEditingController controller,
//   ) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       controller.text =
//           "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//     }
//   }
//
//   // Widget _buildImagePicker() {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Student Image *',
//   //         style: GoogleFonts.poppins(
//   //           fontSize: 14,
//   //           fontWeight: FontWeight.w500,
//   //           color: AppColors.textDark,
//   //         ),
//   //       ),
//   //       SizedBox(height: 8),
//   //       GestureDetector(
//   //         onTap: _pickImage,
//   //         child: Container(
//   //           height: 150,
//   //           width: double.infinity,
//   //           decoration: BoxDecoration(
//   //             border: Border.all(
//   //               color: AppColors.primary.withOpacity(0.3),
//   //               width: 2,
//   //             ),
//   //             borderRadius: BorderRadius.circular(12),
//   //             color: Colors.grey[100],
//   //           ),
//   //           child: _selectedImage == null
//   //               ? Column(
//   //                   mainAxisAlignment: MainAxisAlignment.center,
//   //                   children: [
//   //                     Icon(
//   //                       Icons.camera_alt,
//   //                       size: 40,
//   //                       color: AppColors.primary.withOpacity(0.5),
//   //                     ),
//   //                     SizedBox(height: 8),
//   //                     Text(
//   //                       'Tap to select image',
//   //                       style: GoogleFonts.poppins(
//   //                         color: AppColors.textDark.withOpacity(0.6),
//   //                       ),
//   //                     ),
//   //                     Text(
//   //                       '(Max 5MB, JPG/PNG/GIF)',
//   //                       style: GoogleFonts.poppins(
//   //                         fontSize: 12,
//   //                         color: AppColors.textDark.withOpacity(0.4),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 )
//   //               : ClipRRect(
//   //                   borderRadius: BorderRadius.circular(10),
//   //                   child: Image.file(
//   //                     _selectedImage!,
//   //                     fit: BoxFit.cover,
//   //                     width: double.infinity,
//   //                     height: double.infinity,
//   //                   ),
//   //                 ),
//   //         ),
//   //       ),
//   //       SizedBox(height: 16),
//   //     ],
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightBlue,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.primary),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Add New Student',
//           style: GoogleFonts.poppins(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: AppColors.primary,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Error/Success Messages
//               if (_errorMessage != null)
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.red.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.red.withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.error, color: Colors.red),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           _errorMessage!,
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//               if (_successMessage != null)
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.green.withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.green),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           _successMessage!,
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//               // Image Picker
//               // _buildImagePicker(),
//
//               // Student Name
//               _buildTextField(
//                 label: 'Student Name',
//                 controller: _studentNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter student name';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Father Name
//               _buildTextField(
//                 label: 'Father Name',
//                 controller: _fatherNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter father name';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Father Email
//               _buildTextField(
//                 label: 'Father Email',
//                 controller: _fatherEmailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter father email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Father Contact
//               _buildTextField(
//                 label: 'Father Contact',
//                 controller: _fatherContactController,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter father contact';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Student Email
//               _buildTextField(
//                 label: 'Student Email',
//                 controller: _studentEmailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter student email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Portal Email
//               _buildTextField(
//                 label: 'Portal Email',
//                 controller: _portalEmailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter portal email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Portal Password
//               _buildTextField(
//                 label: 'Portal Password',
//                 controller: _portalPasswordController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter portal password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 hintText: 'Minimum 6 characters',
//               ),
//
//               // Student Contact
//               _buildTextField(
//                 label: 'Student Contact',
//                 controller: _studentContactController,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter student contact';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Emergency Contact
//               _buildTextField(
//                 label: 'Emergency Contact',
//                 controller: _emergencyController,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter emergency contact';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Date of Birth with Date Picker
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Date of Birth *',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   TextFormField(
//                     controller: _dateOfBirthController,
//                     readOnly: true,
//                     onTap: () => _selectDate(context, _dateOfBirthController),
//                     decoration: InputDecoration(
//                       hintText: 'YYYY-MM-DD',
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.calendar_today),
//                         onPressed: () =>
//                             _selectDate(context, _dateOfBirthController),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: AppColors.primary.withOpacity(0.3),
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               ),
//
//               // Student Join Date with Date Picker
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Student Join Date *',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   TextFormField(
//                     controller: _studentJoinDateController,
//                     readOnly: true,
//                     onTap: () =>
//                         _selectDate(context, _studentJoinDateController),
//                     decoration: InputDecoration(
//                       hintText: 'YYYY-MM-DD',
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.calendar_today),
//                         onPressed: () =>
//                             _selectDate(context, _studentJoinDateController),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: AppColors.primary.withOpacity(0.3),
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select join date';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               ),
//
//               // Gender Dropdown
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Gender *',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   DropdownButtonFormField<String>(
//                     value: _selectedGender,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: AppColors.primary.withOpacity(0.3),
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                     items: _genderOptions.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedGender = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select gender';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               ),
//
//               // Address
//               _buildTextField(
//                 label: 'Address',
//                 controller: _addressController,
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter address';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Qualification (quli)
//               _buildTextField(
//                 label: 'Qualification (Quli)',
//                 controller: _quliController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter qualification';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Course
//               _buildTextField(
//                 label: 'Course',
//                 controller: _courseController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Batch ID
//               _buildTextField(
//                 label: 'Batch ID',
//                 controller: _batchController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter batch ID';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Branch ID
//               _buildTextField(
//                 label: 'Branch ID',
//                 controller: _branchIdController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter branch ID';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Country
//               _buildTextField(
//                 label: 'Country',
//                 controller: _countryController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter country';
//                   }
//                   return null;
//                 },
//               ),
//
//               // Country Code
//               _buildTextField(
//                 label: 'Country Code',
//                 controller: _countryCodeController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter country code';
//                   }
//                   return null;
//                 },
//               ),
//
//               // City
//               _buildTextField(
//                 label: 'City',
//                 controller: _cityController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter city';
//                   }
//                   return null;
//                 },
//               ),
//
//               SizedBox(height: 30),
//
//               // Submit Button
//               Container(
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _isSubmitting ? null : _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 4,
//                   ),
//                   child: _isSubmitting
//                       ? SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.white,
//                           ),
//                         )
//                       : Text(
//                           'Add Student',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
