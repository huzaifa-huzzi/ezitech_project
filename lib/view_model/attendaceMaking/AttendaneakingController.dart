import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceMarkingController extends GetxController {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');
  String? attendanceStatus;
  final TextEditingController dayController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController whyController = TextEditingController();

  void submitAttendance(BuildContext context) {
    Map<String, String> attendanceData = {
      'status': attendanceStatus!,
      'date': dateController.text,
    };

    if (attendanceStatus == 'Present' || attendanceStatus == 'Absent') {
      attendanceData['day'] = dayController.text;
    } else if (attendanceStatus == 'Leave') {
      attendanceData['why'] = whyController.text;
    }

    _ref.push().set(attendanceData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully!')),
      );
      resetForm();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark attendance: $error')),
      );
    });
  }

  void resetForm() {
    attendanceStatus = null;
    dayController.clear();
    dateController.clear();
    whyController.clear();
    update();
  }

  @override
  void dispose() {
    dayController.dispose();
    dateController.dispose();
    whyController.dispose();
    super.dispose();
  }
}
