class Student_Model_List {
  String? sno;
  String? studentName;
  String? fatherName;
  String? fatherEmail;
  String? homeContact;
  String? dateOfBirth;
  String? studentContact;
  String? emergencyContact;
  String? gender;
  String? address;
  String? qualification;
  String? course;
  String? batch;
  String? branch;
  String? studentJoinDate;
  Null? previousBatch;
  String? country;
  String? countryCode;
  String? city;
  String? email;
  String? portalEmail;
  String? fees;
  String? password;
  String? studentImage;
  Null? testPassword;
  String? date;
  Null? onOff;
  String? batchName;
  String? batchSlot;
  String? batchCode;
  int? count;

  Student_Model_List({
    this.sno,
    this.studentName,
    this.fatherName,
    this.fatherEmail,
    this.homeContact,
    this.dateOfBirth,
    this.studentContact,
    this.emergencyContact,
    this.gender,
    this.address,
    this.qualification,
    this.course,
    this.batch,
    this.branch,
    this.studentJoinDate,
    this.previousBatch,
    this.country,
    this.countryCode,
    this.city,
    this.email,
    this.portalEmail,
    this.fees,
    this.password,
    this.studentImage,
    this.testPassword,
    this.date,
    this.onOff,
    this.batchName,
    this.batchSlot,
    this.batchCode,
    this.count,
  });

  Student_Model_List.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    studentName = json['student_name'];
    fatherName = json['father_name'];
    fatherEmail = json['father_email'];
    homeContact = json['home_contact'];
    dateOfBirth = json['date_of_birth'];
    studentContact = json['student_contact'];
    emergencyContact = json['emergency_contact'];
    gender = json['gender'];
    address = json['address'];
    qualification = json['qualification'];
    course = json['course'];
    batch = json['batch'];
    branch = json['branch'];
    studentJoinDate = json['student_join_date'];
    previousBatch = json['previous_batch'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    email = json['email'];
    portalEmail = json['portal_email'];
    fees = json['fees'];
    password = json['password'];
    studentImage = json['student_image'];
    testPassword = json['test_password'];
    date = json['date'];
    onOff = json['on/off'];
    batchName = json['batch_name'];
    batchSlot = json['batch_slot'];
    batchCode = json['batch_code'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['student_name'] = this.studentName;
    data['father_name'] = this.fatherName;
    data['father_email'] = this.fatherEmail;
    data['home_contact'] = this.homeContact;
    data['date_of_birth'] = this.dateOfBirth;
    data['student_contact'] = this.studentContact;
    data['emergency_contact'] = this.emergencyContact;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['qualification'] = this.qualification;
    data['course'] = this.course;
    data['batch'] = this.batch;
    data['branch'] = this.branch;
    data['student_join_date'] = this.studentJoinDate;
    data['previous_batch'] = this.previousBatch;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['email'] = this.email;
    data['portal_email'] = this.portalEmail;
    data['fees'] = this.fees;
    data['password'] = this.password;
    data['student_image'] = this.studentImage;
    data['test_password'] = this.testPassword;
    data['date'] = this.date;
    data['on/off'] = this.onOff;
    data['batch_name'] = this.batchName;
    data['batch_slot'] = this.batchSlot;
    data['batch_code'] = this.batchCode;
    data['count'] = this.count;
    return data;
  }
}
