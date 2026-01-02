class CommonData {
  // Branch items for dropdown
  static const List<String> branchItems = ['wajiha', 'huba', 'Hiba', 'Zara'];

  // Common filter options
  static const List<String> studentFilterOptions = [
    'All student',
    'Admission Date',
    'Leave Date',
    'ActiveOn',
    'Graduated',
    'Skills',
    'On leave',
  ];

  // Sample students data structure
  static List<Map<String, dynamic>> get sampleStudents => [
    {
      'name': 'Aisha Rehman',
      'id': '101',
      'branchCode': '3001',
      'admissionDate': '2023-01-15',
      'status': 'Active',
    },
    {
      'name': 'Maria Khan',
      'id': '102',
      'branchCode': '3001',
      'admissionDate': '2023-02-20',
      'status': 'Active',
    },
    {
      'name': 'Fatima Ali',
      'id': '103',
      'branchCode': '3002',
      'admissionDate': '2023-03-10',
      'status': 'Active',
    },
    {
      'name': 'Zainab Ahmed',
      'id': '104',
      'branchCode': '3001',
      'admissionDate': '2023-01-05',
      'status': 'Inactive',
    },
    {
      'name': 'Sara Malik',
      'id': '105',
      'branchCode': '3002',
      'admissionDate': '2023-04-12',
      'status': 'Active',
    },
    {
      'name': 'Hina Raza',
      'id': '106',
      'branchCode': '3001',
      'admissionDate': '2023-05-18',
      'status': 'Active',
    },
    {
      'name': 'Nadia Sheikh',
      'id': '107',
      'branchCode': '3003',
      'admissionDate': '2023-06-22',
      'status': 'Graduated',
    },
    {
      'name': 'Ayesha Noor',
      'id': '108',
      'branchCode': '3001',
      'admissionDate': '2023-07-30',
      'status': 'Active',
    },
  ];

  // Active students data
  static List<Map<String, dynamic>> get activeStudents => [
    {
      'name': 'Aisha Rehman',
      'id': '101',
      'branchCode': '3001',
      'day': 'Mon',
      'time': '12:00',
    },
    {
      'name': 'Maria Khan',
      'id': '102',
      'branchCode': '3001',
      'day': 'Tue',
      'time': '14:30',
    },
    {
      'name': 'Fatima Ali',
      'id': '103',
      'branchCode': '3002',
      'day': 'Wed',
      'time': '10:00',
    },
    {
      'name': 'Zainab Ahmed',
      'id': '104',
      'branchCode': '3001',
      'day': 'Thu',
      'time': '16:45',
    },
    {
      'name': 'Sara Malik',
      'id': '105',
      'branchCode': '3002',
      'day': 'Fri',
      'time': '09:15',
    },
    {
      'name': 'Hina Raza',
      'id': '106',
      'branchCode': '3001',
      'day': 'Mon',
      'time': '11:30',
    },
    {
      'name': 'Nadia Sheikh',
      'id': '107',
      'branchCode': '3003',
      'day': 'Sat',
      'time': '13:00',
    },
    {
      'name': 'Ayesha Noor',
      'id': '108',
      'branchCode': '3001',
      'day': 'Sun',
      'time': '15:20',
    },
  ];

  // sample data for manage student record
  final List<Map<String, dynamic>> allStudents = [
    {
      'name': 'Aisha Rehman',
      'id': '101',
      'branchCode': '3001',
      'admissionDate': '2023-01-15',
      'status': 'Active',
    },
    {
      'name': 'Maria Khan',
      'id': '102',
      'branchCode': '3001',
      'admissionDate': '2023-02-20',
      'status': 'Active',
    },
    {
      'name': 'Fatima Ali',
      'id': '103',
      'branchCode': '3002',
      'admissionDate': '2023-03-10',
      'status': 'Active',
    },
    {
      'name': 'Zainab Ahmed',
      'id': '104',
      'branchCode': '3001',
      'admissionDate': '2023-01-05',
      'status': 'Inactive',
    },
    {
      'name': 'Sara Malik',
      'id': '105',
      'branchCode': '3002',
      'admissionDate': '2023-04-12',
      'status': 'Active',
    },
    {
      'name': 'Hina Raza',
      'id': '106',
      'branchCode': '3001',
      'admissionDate': '2023-05-18',
      'status': 'Active',
    },
    {
      'name': 'Nadia Sheikh',
      'id': '107',
      'branchCode': '3003',
      'admissionDate': '2023-06-22',
      'status': 'Graduated',
    },
    {
      'name': 'Ayesha Noor',
      'id': '108',
      'branchCode': '3001',
      'admissionDate': '2023-07-30',
      'status': 'Active',
    },
  ];

  final List<Map<String, dynamic>> admissiondatestudents = [
    {
      'name': 'Aisha Rehman',
      'id': '101',
      'branchCode': '3001',
      'admissionDate': '2023-01-15',
    },
    {
      'name': 'Maria Khan',
      'id': '102',
      'branchCode': '3001',
      'admissionDate': '2023-02-20',
    },
    {
      'name': 'Fatima Ali',
      'id': '103',
      'branchCode': '3002',
      'admissionDate': '2023-03-10',
    },
    {
      'name': 'Zainab Ahmed',
      'id': '104',
      'branchCode': '3001',
      'admissionDate': '2023-01-05',
    },
    {
      'name': 'Sara Malik',
      'id': '105',
      'branchCode': '3002',
      'admissionDate': '2023-04-12',
    },
    {
      'name': 'Hina Raza',
      'id': '106',
      'branchCode': '3001',
      'admissionDate': '2023-05-18',
    },
    {
      'name': 'Nadia Sheikh',
      'id': '107',
      'branchCode': '3003',
      'admissionDate': '2023-06-22',
    },
    {
      'name': 'Ayesha Noor',
      'id': '108',
      'branchCode': '3001',
      'admissionDate': '2023-07-30',
    },
  ];
}
