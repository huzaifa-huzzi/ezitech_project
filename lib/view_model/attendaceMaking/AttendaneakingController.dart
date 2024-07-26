import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AttendanceMarkingController extends GetxController {
  String? attendanceStatus;
  final TextEditingController dayController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController whyController = TextEditingController();
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');

  void submitAttendance(BuildContext context) {
    Map<String, String> attendanceData = {
      'status': attendanceStatus!,
      'date': dateController.text,
    };

    if (attendanceStatus == 'Present' || attendanceStatus == 'Absent') {
      attendanceData['day'] = dayController.text;
    } else if (attendanceStatus == 'Leave') {
      attendanceData['why'] = whyController.text;
      attendanceData['approvalStatus'] = 'Pending';
    }

    _ref.push().set(attendanceData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark attendance: $error')),
      );
    });

    resetForm();
  }

  void resetForm() {
    attendanceStatus = null;
    dayController.clear();
    dateController.clear();
    whyController.clear();
    update();
  }

  @override
  void onClose() {
    dayController.dispose();
    dateController.dispose();
    whyController.dispose();
    super.onClose();
  }
}
