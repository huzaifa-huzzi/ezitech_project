import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminPanelController extends GetxController {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('attendance');
  RxList<Map<String, dynamic>> attendanceList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAttendanceRecords();
  }

  void _fetchAttendanceRecords() {
    _ref.onValue.listen((event) {
      attendanceList.clear();
      event.snapshot.children.forEach((snapshot) {
        final Map<String, dynamic> record = Map<String, dynamic>.from(snapshot.value as Map);
        record['key'] = snapshot.key;
        if (!record.containsKey('approvalStatus')) {
          record['approvalStatus'] = 'Pending';
        }
        attendanceList.add(record);
      });
    });
  }

  void approveLeave(String key) {
    _ref.child(key).update({'approvalStatus': 'Approved'}).then((_) {
      Timer(const Duration(seconds: 1), () {
        removeAttendanceAfterApproval(key);
      });
    });
  }

  void disapproveLeave(String key) {
    _ref.child(key).update({'approvalStatus': 'Disapproved'}).then((_) {
      Timer(const Duration(seconds: 1), () {
        removeAttendanceAfterApproval(key);
      });
    });
  }

  void deleteAttendance(String key) {
    _ref.child(key).remove();
  }

  void removeAttendanceAfterApproval(String key) {
    attendanceList.removeWhere((record) => record['key'] == key);
  }

  void editAttendance(String key, BuildContext context) {
    final record = attendanceList.firstWhere((record) => record['key'] == key);
    final TextEditingController dayController = TextEditingController(text: record['day']);
    final TextEditingController dateController = TextEditingController(text: record['date']);
    final TextEditingController whyController = TextEditingController(text: record['why']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Attendance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (record['status'] == 'Present' || record['status'] == 'Absent')
                TextField(
                  controller: dayController,
                  decoration: const InputDecoration(labelText: 'Day'),
                ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              if (record['status'] == 'Leave')
                TextField(
                  controller: whyController,
                  decoration: const InputDecoration(labelText: 'Why?'),
                  maxLines: 4,
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final Map<String, dynamic> updatedRecord = {
                  'day': dayController.text,
                  'date': dateController.text,
                  'why': whyController.text,
                };

                _ref.child(key).update(updatedRecord);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
