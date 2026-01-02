class Left_Student_Model {
  bool? success;
  Data? data;

  Left_Student_Model({this.success, this.data});

  Left_Student_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Students>? students;
  Pagination? pagination;
  Filters? filters;

  Data({this.students, this.pagination, this.filters});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    filters = json['filters'] != null
        ? new Filters.fromJson(json['filters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.filters != null) {
      data['filters'] = this.filters!.toJson();
    }
    return data;
  }
}

class Students {
  String? sno;
  int? count;
  String? studentName;
  String? email;
  String? fatherName;
  String? fatherEmail;
  String? homeContact;
  String? dateOfBirth;
  String? studentContact;
  String? emergencyContact;
  String? gender;
  String? address;
  String? qualification;
  String? country;
  String? city;
  String? countryCode;
  String? course;
  String? batch;
  String? image;
  String? admissionDate;
  String? leftDate;
  List<BatchDetails>? batchDetails;

  Students({
    this.sno,
    this.count,
    this.studentName,
    this.email,
    this.fatherName,
    this.fatherEmail,
    this.homeContact,
    this.dateOfBirth,
    this.studentContact,
    this.emergencyContact,
    this.gender,
    this.address,
    this.qualification,
    this.country,
    this.city,
    this.countryCode,
    this.course,
    this.batch,
    this.image,
    this.admissionDate,
    this.leftDate,
    this.batchDetails,
  });

  Students.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    count = json['count'];
    studentName = json['student_name'];
    email = json['email'];
    fatherName = json['father_name'];
    fatherEmail = json['father_email'];
    homeContact = json['home_contact'];
    dateOfBirth = json['date_of_birth'];
    studentContact = json['student_contact'];
    emergencyContact = json['emergency_contact'];
    gender = json['gender'];
    address = json['address'];
    qualification = json['qualification'];
    country = json['country'];
    city = json['city'];
    countryCode = json['country_code'];
    course = json['course'];
    batch = json['batch'];
    image = json['image'];
    admissionDate = json['admission_date'];
    leftDate = json['left_date'];
    if (json['batch_details'] != null) {
      batchDetails = <BatchDetails>[];
      json['batch_details'].forEach((v) {
        batchDetails!.add(new BatchDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['count'] = this.count;
    data['student_name'] = this.studentName;
    data['email'] = this.email;
    data['father_name'] = this.fatherName;
    data['father_email'] = this.fatherEmail;
    data['home_contact'] = this.homeContact;
    data['date_of_birth'] = this.dateOfBirth;
    data['student_contact'] = this.studentContact;
    data['emergency_contact'] = this.emergencyContact;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['qualification'] = this.qualification;
    data['country'] = this.country;
    data['city'] = this.city;
    data['country_code'] = this.countryCode;
    data['course'] = this.course;
    data['batch'] = this.batch;
    data['image'] = this.image;
    data['admission_date'] = this.admissionDate;
    data['left_date'] = this.leftDate;
    if (this.batchDetails != null) {
      data['batch_details'] = this.batchDetails!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class BatchDetails {
  String? batchId;
  String? batchName;
  String? batchSlot;
  String? batchCode;
  String? batchTime;

  BatchDetails({
    this.batchId,
    this.batchName,
    this.batchSlot,
    this.batchCode,
    this.batchTime,
  });

  BatchDetails.fromJson(Map<String, dynamic> json) {
    batchId = json['batch_id'];
    batchName = json['batch_name'];
    batchSlot = json['batch_slot'];
    batchCode = json['batch_code'];
    batchTime = json['batch_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_id'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['batch_slot'] = this.batchSlot;
    data['batch_code'] = this.batchCode;
    data['batch_time'] = this.batchTime;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  String? totalRecords;
  int? limit;
  int? offset;
  int? startPage;
  int? endPage;
  List<int>? paginationBoxes;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalRecords,
    this.limit,
    this.offset,
    this.startPage,
    this.endPage,
    this.paginationBoxes,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalRecords = json['total_records'];
    limit = json['limit'];
    offset = json['offset'];
    startPage = json['start_page'];
    endPage = json['end_page'];
    paginationBoxes = json['pagination_boxes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_records'] = this.totalRecords;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['start_page'] = this.startPage;
    data['end_page'] = this.endPage;
    data['pagination_boxes'] = this.paginationBoxes;
    return data;
  }
}

class Filters {
  String? slot;
  String? search;

  Filters({this.slot, this.search});

  Filters.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    data['search'] = this.search;
    return data;
  }
}
